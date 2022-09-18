#!/bin/sh

. /lib/functions.sh

ha_sync_send() {
	local cfg=$1
	local address ssh_user ssh_port sync_list sync_dir sync_file

	config_get address $cfg address
	[ -z "$address" ] && return 0

	config_get ssh_user $cfg ssh_user root
	config_get ssh_port $cfg ssh_port 22
	config_get ssh_key $cfg ssh_key /root/.ssh/id_rsa
	config_get sync_dir $cfg sync_dir /usr/share/keepalived/rsync
	config_get sync_list $cfg sync_list

	for sync_file in $sync_list $(sysupgrade -l); do
		[ -f "$sync_file" ] && {
			dir="${sync_file%/*}"
			list_contains FILES ${sync_file} || append FILES ${sync_file}
		}
		[ -d "$sync_file" ] && dir=${sync_file}
		list_contains DIRS ${sync_dir}${dir} || append DIRS ${sync_dir}${dir}
	done

	changed_files=$(rsync --out-format='%n' --dry-run -a --relative $FILES -e "ssh -y -i $ssh_key -p $ssh_port" $ssh_user@$address:$sync_dir | wc -l)
	[ $changed_files -le 0 ] && return 0

	ssh -y -i $ssh_key -p $ssh_port $ssh_user@$address mkdir -p $DIRS
	rsync -a --relative $FILES -e "ssh -y -i $ssh_key -p $ssh_port" $ssh_user@$address:$sync_dir

	unset DIRS FILES
}

ha_sync_receive() {
	local cfg=$1
	local ssh_pubkey
	local auth_file=/etc/dropbear/authorized_keys

	config_get ssh_pubkey $cfg ssh_pubkey
	[ -z "$ssh_pubkey" ] && return 0

	if ! grep -q "$ssh_pubkey" "$auth_file"; then
		echo "$ssh_pubkey" >> "$auth_file"
		sed -i '$!N; /^\(.*\)\n\1$/!P; D' "$auth_file"
	fi

	/etc/init.d/keepalived-inotify enabled || /etc/init.d/keepalived-inotify enable
	/etc/init.d/keepalived-inotify running || /etc/init.d/keepalived-inotify start
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


LOCK=/var/run/keepalived_rsync.lock

lock -n $LOCK > /dev/null 2>&1 || exit 0
config_load keepalived
config_foreach ha_sync vrrp_instance
lock -u $LOCK

exit 0
