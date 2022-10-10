#!/bin/sh

. /lib/functions.sh

KEEPALIVED_USER=keepalived
KEEPALIVED_HOME=$(awk -F: "/^$KEEPALIVED_USER/{print \$6}" /etc/passwd)

utc_timestamp() {
	date -u +%s
}

update_last_sync_time() {
	uci_revert_state keepalived "$1" last_sync_time
	uci_set_state keepalived "$1" last_sync_time "$(utc_timestamp)"
}

update_last_sync_status() {
	local cfg=$1
	shift
	local status="$@"
	uci_revert_state keepalived "$cfg" last_sync_status
	uci_set_state keepalived "$cfg" last_sync_status "$status"
}

ha_sync_send() {
	local cfg=$1
	local address ssh_port sync_list sync_dir sync_file
	local ssh_options ssh_remote
	local DIRS FILES

	config_get address $cfg address
	[ -z "$address" ] && return 0

	config_get ssh_port $cfg ssh_port 22
	config_get sync_dir $cfg sync_dir $KEEPALIVED_HOME
	[ -z "$sync_dir" ] && return 0
	config_get ssh_key $cfg ssh_key $sync_dir/.ssh/id_rsa
	config_get sync_list $cfg sync_list

	for sync_file in $sync_list $(sysupgrade -l); do
		[ -f "$sync_file" ] && {
			dir="${sync_file%/*}"
			list_contains FILES ${sync_file} || append FILES ${sync_file}
		}
		[ -d "$sync_file" ] && dir=${sync_file}
		list_contains DIRS ${sync_dir}${dir} || append DIRS ${sync_dir}${dir}
	done

	ssh_options="-y -y -i $ssh_key -p $ssh_port"
	ssh_remote="$KEEPALIVED_USER@$address"

	changed_files=$(rsync --out-format='%n' --dry-run -a --relative $FILES -e "ssh $ssh_options" --rsync-path="sudo rsync" $ssh_remote:$sync_dir | wc -l)
	if [ $? -ne 0 ]; then
		update_last_sync_time "$cfg"
		update_last_sync_status "$cfg" "Rsync Detection Failed"
		return 0
	elif [ $changed_files -le 0 ]; then
		update_last_sync_time "$cfg"
		update_last_sync_status "$cfg" "Up to Date"
		return 0
	fi

	ssh $ssh_options $ssh_remote mkdir -m 755 -p $DIRS || {
		update_last_sync_time "$cfg"
		update_last_sync_status "SSH Connection Failed"
		return 0
	}

	rsync -a --relative $FILES -e "ssh $ssh_options" --rsync-path="sudo rsync" $ssh_remote:$sync_dir || {
		update_last_sync_time "$cfg"
		update_last_sync_status "$cfg" "Rsync Transfer Failed"
	}

	update_last_sync_time "$cfg"
	update_last_sync_status "$cfg" "Successful"
}

ha_sync_receive() {
	local cfg=$1
	local ssh_pubkey
	local name auth_file home_dir

	config_get name $cfg name
	config_get sync_dir $cfg sync_dir $KEEPALIVED_HOME
	[ -z "$sync_dir" ] && return 0
	config_get ssh_pubkey $cfg ssh_pubkey
	[ -z "$ssh_pubkey" ] && return 0

	home_dir=$sync_dir
	auth_file="$home_dir/.ssh/authorized_keys"

	if ! grep -q "^$ssh_pubkey$" "$auth_file" 2>/dev/null; then
		echo "$ssh_pubkey" > "$auth_file"
		chown $KEEPALIVED_USER:$KEEPALIVED_USER "$auth_file"
	fi

	/etc/init.d/keepalived-inotify enabled || /etc/init.d/keepalived-inotify enable
	/etc/init.d/keepalived-inotify running "$name" || /etc/init.d/keepalived-inotify start "$name"
}

ha_sync_each_peer() {
	local cfg="$1"
	local c_name="$2"
	local name sync sync_mode

	config_get name $cfg name
	[ "$name" != "$c_name" ] && return 0

	config_get sync $cfg sync 0
	[ "$sync" = "0" ] && return 0

	config_get sync_mode $cfg sync_mode
	[ -z "$sync_mode" ] && return 0

	case "$sync_mode" in
		send) ha_sync_send $cfg ;;
		receive) ha_sync_receive $cfg ;;
	esac
}

ha_sync_peers() {
	config_foreach ha_sync_each_peer peer "$1"
}

ha_sync() {
	config_list_foreach "$1" unicast_peer ha_sync_peers
}


LOCK=/var/lock/keepalived-rsync.lock

lock -n $LOCK > /dev/null 2>&1 || exit 0
config_load keepalived
config_foreach ha_sync vrrp_instance
lock -u $LOCK

exit 0
