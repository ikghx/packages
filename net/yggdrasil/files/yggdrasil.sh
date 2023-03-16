#!/bin/sh


[ -n "$INCLUDE_ONLY" ] || {
	. /lib/functions.sh
	. ../netifd-proto.sh
	init_proto "$@"
}

proto_yggdrasil_init_config() {
	proto_config_add_string "private_key"
	available=1
}

proto_yggdrasil_setup_peer_if_non_interface() {
	local peer_config="$1"
	local peer_address
	local peer_interface
	config_get peer_address "${peer_config}" "address"
	config_get peer_interface "${peer_config}" "interface"
	if [ -z ${peer_interface} ]; then
		json_add_string "" ${peer_address}
	fi;
}

proto_yggdrasil_dump_peer_interface() {
	local peer_config="$1"
	local peer_interface

	config_get peer_interface "${peer_config}" "interface"

	if [ ! -z ${peer_interface} ]; then
		peer_interfaces="${peer_interfaces}\n${peer_interface}"
	fi;
}

proto_yggdrasil_setup_peer_if_interface() {
	local peer_config="$1"
	local peer_address
	local peer_interface
	config_get peer_interface "${peer_config}" "interface"
	if [ "${peer_interface}" = "${peer_interface_filter}" ]; then
		config_get peer_address "${peer_config}" "address"
		json_add_string "" ${peer_address}
	fi;
}

proto_yggdrasil_append_to_interface_regex() {
	if [ -z "${regex}" ]; then
		regex="$1"
	else
		regex="${regex}|$1";
	fi;
}

proto_yggdrasil_setup_multicast_interface() {
	local interface_config="$1"
	local beacon
	local listen
	local port=0
	local regex=""

	config_get beacon "${interface_config}" "beacon"
	config_get listen "${interface_config}" "listen"
	config_get port "${interface_config}" "port"

	json_add_object ""
	json_add_boolean "Beacon" $beacon
	json_add_boolean "Listen" $listen
	if [ ! -z ${port} ]; then
		json_add_int "Port" $port
	else
		json_add_int "Port" 0
	fi;

	config_list_foreach "${interface_config}" interface proto_yggdrasil_append_to_interface_regex

	json_add_string "Regex" "^(${regex})\$"

	json_close_object
}

proto_yggdrasil_add_string() {
	json_add_string "" $1
}

proto_yggdrasil_setup() {
	local config="$1"
	local device="$2"
	local ygg_dir="/tmp/yggdrasil"
	local ygg_cfg="${ygg_dir}/${config}.conf"
	local ygg_sock="unix://${ygg_dir}/${config}.sock"


	local private_key
	local public_key
	local mtu
	local listen_addresses
	local whitelisted_keys
	local node_info
	local node_info_privacy

	config_load network
	config_get private_key "${config}" "private_key"
	config_get public_key "${config}" "public_key"
	config_get mtu "${config}" "mtu"
	config_get node_info "${config}" "node_info"
	config_get node_info_privacy "${config}" "node_info_privacy"

	# Generate config file
	umask 077
	mkdir -p "${ygg_dir}"

	json_init
	json_add_string "IfName" ${config}
	json_add_string "AdminListen" ${ygg_sock}

	json_add_string "PrivateKey" ${private_key}
	json_add_string "PublicKey" ${public_key}

	if [ ! -z $mtu ]; then
		json_add_int "IfMTU" ${mtu}
	fi;

	if [ ! -z $node_info ]; then
		json_add_string "NodeInfo" "%%_YGGDRASIL_NODEINFO_TEMPLATE_%%"
	fi;

	json_add_boolean "NodeInfoPrivacy" ${node_info_privacy}

	# Peers
	json_add_array "Peers"
	config_foreach proto_yggdrasil_setup_peer_if_non_interface "yggdrasil_${config}_peer"
	json_close_array

	local peer_interfaces
	peer_interfaces=""
	config_foreach proto_yggdrasil_dump_peer_interface "yggdrasil_${config}_peer"
	peer_interfaces=$(echo -e ${peer_interfaces} | sort | uniq)

	json_add_object "InterfacePeers"
	for peer_interface_filter in ${peer_interfaces}; do
		json_add_array "${peer_interface_filter}"
		config_foreach proto_yggdrasil_setup_peer_if_interface "yggdrasil_${config}_peer"
		json_close_array
	done
	json_close_object

	json_add_array "AllowedPublicKeys"
	config_list_foreach "$config" allowed_public_key proto_yggdrasil_add_string
	json_close_array

	json_add_array "Listen"
	config_list_foreach "$config" listen_address proto_yggdrasil_add_string
	json_close_array

	json_add_array "MulticastInterfaces"
	config_foreach proto_yggdrasil_setup_multicast_interface "yggdrasil_${config}_interface"
	json_close_array

	json_dump > "${ygg_cfg}.1"
	awk -v s='"%%_YGGDRASIL_NODEINFO_TEMPLATE_%%"' -v r="${node_info}" '{gsub(s, r)} 1' "${ygg_cfg}.1" > ${ygg_cfg}
	rm "${ygg_cfg}.1"

	proto_run_command "$config" /usr/sbin/yggdrasil -useconffile "${ygg_cfg}"
	proto_init_update "$config" 1
	proto_add_ipv6_address "$(yggdrasil -useconffile "${ygg_cfg}" -address)"
	proto_add_ipv6_prefix "$(yggdrasil -useconffile "${ygg_cfg}" -subnet)"
	proto_add_ipv6_route "200::" "7"
	proto_send_update "$config"
}

proto_yggdrasil_teardown() {
	local interface="$1"
	proto_kill_command "$interface"
}

[ -n "$INCLUDE_ONLY" ] || {
	add_protocol yggdrasil
}