
#!/bin/sh

# Copyright (c) 2016, prpl Foundation
# Copyright  ANNO DOMINI  2024  Jan Chren (rindeal)  <dev.rindeal(a)gmail.com>
#
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without
# fee is hereby granted, provided that the above copyright notice and this permission notice appear
# in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE
# FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
# ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# Author: Nils Koenig <openwrt@newk.it>

set -o pipefail

SCRIPT="$0"
LOCKFILE=/tmp/wifi_schedule.lock
LOGFILE=/tmp/log/wifi_schedule.log
LOGGING=0 #default is off
PACKAGE=wifi_schedule
GLOBAL=${PACKAGE}.@global[0]


_arith_is() { [ "$1" -ne "0" ] ;}

_join_by_char()
{
    local IFS="$1"
    shift
    printf "%s" "$*"
}

_log()
{
    [ "${LOGGING}" -eq 1 ] || return
    local ts=$(date)
    echo "$ts $@" >> "${LOGFILE}"
}

_exit()
{
    local rc=$1
    lock -u "${LOCKFILE}"
    exit ${rc}
}

_get_uci_value_raw() { uci get "$1" 2> /dev/null ;}

_get_uci_value()
{
    _get_uci_value_raw "$1"
    local rc=$?
    if [ ${rc} -ne 0 ]; then
        _log "Could not determine UCI value '$1'"
    fi
    return ${rc}
}

_cfg_global_is_enabled()
{
    local enabled=$(_get_uci_value "${GLOBAL}.enabled")
    test "${enabled}" -eq 1
}

_cfg_global_is_unload_modules_enabled()
{
    local unload_modules=$(_get_uci_value_raw "${GLOBAL}.unload_modules") || return 1
    test "${unload_modules}" -eq 1
}

_cfg_list_entries()
{
    uci show "${PACKAGE}" 2> /dev/null | awk -F= '$2 == "entry"' | cut -s -d. -f2 | cut -d= -f1
}

_cfg_entry_is_enabled()
{
    local enabled=$(_get_uci_value "${PACKAGE}.${entry}.enabled")
    test "${enabled}" -eq 1
}

_cfg_entry_is_now_within_timewindow()
{
    local entry=$1
    local starttime=$( _get_uci_value "${PACKAGE}.${entry}.starttime" ) || return 1
    local stoptime=$(  _get_uci_value "${PACKAGE}.${entry}.stoptime"  ) || return 1
    local daysofweek=$(_get_uci_value "${PACKAGE}.${entry}.daysofweek") || return 1

    # check if day of week matches today
    echo "$daysofweek" | grep -q "$(date +%A)" || return 1

    local nowts=$(  date -u +%s -d "$(date "+%H:%M")")
    local startts=$(date -u +%s -d "$starttime")
    local stopts=$( date -u +%s -d "$stoptime")
    # add a day if stopts goes past midnight
    stopts=$(( stopts < startts ? stopts + 86400 : stopts ))

    _arith_is $(( nowts >= startts && nowts < stopts ))
}

_cfg_can_wifi_run_now()
{
    local entry
    for entry in $(_cfg_list_entries)
    do
        test -n "${entry}" || continue
        _cfg_entry_is_enabled "${entry}" || continue
        _cfg_entry_is_now_within_timewindow "$entry" && return 0
    done
    return 1
}

_cron_restart() { service cron restart > /dev/null ;}

_crontab_add_entry_raw() { (crontab -l ; printf "%s\n" "$1") | crontab - ;}

_crontab_rm_script_entries_by_arg()
{
    # this loop will create regexp that looks like this:
    #
    #     ^\b${SCRIPT}\b\s+\b${@}\b
    #
    local regex="(:?^|[[:space:]])${SCRIPT}"
    local arg
    for arg in "$@"
    do
        regex="${regex}[[:space:]]{1,}${arg}"
    done
    regex="${regex}(:?$|[[:space:]])"

    crontab -l | awk -v cmd_field_n=6 -v regex="${regex}" '
        {
            is_blank_or_comment = $0 ~ /^[[:space:]]*(:?#.*)?$/
            is_env_var = $0 ~ /^[[:space:]]*[a-zA-Z_]{1,}[a-zA-Z0-9_]{0,}[[:space:]]*=.*$/
            # find index of cmdline start
            match($0, "[[:space:]]*([^[:space:]]+[[:space:]]+){" cmd_field_n - 1 "}")
            cmdline = substr($0, RLENGTH + 1)
            if ( is_blank_or_comment || is_env_var || cmdline !~ regex )
            {
                print
                next
            }
        }' | crontab -
}

_crontab_format_dow_field()
{
    _join_by_char "," $(printf "%.3s\n" $@)
}

_crontab_add_from_cfg_entry()
{
    local entry=$1
    local starttime=$(    _get_uci_value "${PACKAGE}.${entry}.starttime" ) || return 1
    local stoptime=$(     _get_uci_value "${PACKAGE}.${entry}.stoptime"  ) || return 1
    local daysofweek=$(   _get_uci_value "${PACKAGE}.${entry}.daysofweek") || return 1
    local forcewifidown=$(_get_uci_value "${PACKAGE}.${entry}.forcewifidown")
    local starthh=$(expr substr "$starttime" 1 2) startmm=$(expr substr "$starttime" 4 2)
    local stophh=$( expr substr "$stoptime"  1 2) stopmm=$( expr substr "$stoptime"  4 2)

    local stopmode="stop"
    if [ "$forcewifidown" -eq 1 ]; then
        stopmode="forcestop"
    fi

    local fdow=$(_crontab_format_dow_field $daysofweek)

    if [ "$starttime" != "$stoptime" ]
    then
        _crontab_add_entry_raw "$startmm $starthh * * ${fdow} ${SCRIPT} start ${entry}"
    fi

    _crontab_add_entry_raw "$stopmm $stophh * * ${fdow} ${SCRIPT} ${stopmode} ${entry}"

    return 0
}

_crontab_reset_from_cfg()
{
    _crontab_rm_script_entries_by_arg

    _cfg_global_is_enabled || return

    local entry
    for entry in $(_cfg_list_entries)
    do
        test -n "${entry}" || continue
        _cfg_entry_is_enabled "${entry}" || continue
        _crontab_add_from_cfg_entry "${entry}"
    done
}

get_module_list()
{
    local mod_list
    local _if
    for _if in $(_wifi_get_interfaces)
    do
        local mod=$(basename "$(readlink -f /sys/class/net/${_if}/device/driver)")
        local mod_dep=$(modinfo "${mod}" | awk '$1 ~ /^depends:/ { print $2 }')
        mod_list=$(echo -e "${mod_list}\n${mod},${mod_dep}" | sort -u)
    done
    echo "$mod_list" | tr ',' ' '
}

save_module_list_uci()
{
    local list=$(get_module_list)
    uci set ${GLOBAL}.modules="${list}"
    uci commit "${PACKAGE}"
}

_unload_modules()
{
    local list=$(_get_uci_value "${GLOBAL}.modules")
    local retries=$(_get_uci_value "${GLOBAL}.modules_retries") || return 1
    _log "unload_modules ${list} (retries: ${retries})"
    local i=0
    while [ $i -lt "$retries" -a -n "$list" ]
    do
        : $(( ++i ))
        local mod
        local first=0
        for mod in ${list}
        do
            if [ $first -eq 0 ]; then
                list=""
                first=1
            fi
            rmmod "${mod}" > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                list="$list $mod"
            fi
        done
    done
}

_load_modules()
{
    local list=$(   _get_uci_value "${GLOBAL}.modules") || return 1
    local retries=$(_get_uci_value "${GLOBAL}.modules_retries") || return 1
    _log "load_modules ${list} (retries: ${retries})"
    local i=0
    while [ $i -lt "${retries}" -a -n "${list}" ]
    do
        : $(( ++i ))
        local mod
        local first=0
        for mod in ${list}
        do
            if [ $first -eq 0 ]; then
                list=""
                first=1
            fi
            modprobe "${mod}" > /dev/null 2>&1
            rc=$?
            if [ $rc -ne 255 ]; then
                list="$list $mod"
            fi
        done
    done
}

_uci_wireless_radio_set_disabled_to()
{
    local status=$1
    _arith_is $(( status == 0 || status == 1 )) || return 1
    for radio in $(uci show wireless | awk -F= '$2 == "wifi-device" {print $1}' | awk -F. '{print $2}')
    do
        uci set "wireless.${radio}.disabled=${status}"
    done
    uci commit
    /sbin/wifi
}

_uci_enable_all_radio_devices()  { _uci_wireless_radio_set_disabled_to 0 ;}
_uci_disable_all_radio_devices() { _uci_wireless_radio_set_disabled_to 1 ;}

_wifi_get_interfaces()
{
    iwinfo | grep ESSID | cut -f 1 -d" " -s
}

wifi_disable()
{
    _crontab_rm_script_entries_by_arg "recheck"
    _cron_restart
    _uci_disable_all_radio_devices
    if _cfg_global_is_unload_modules_enabled
    then
        _unload_modules
    fi
}

wifi_soft_disable()
{
    if ! command -v iwinfo 2>/dev/null ; then
        _log "iwinfo not available, skipping"
        return 1
    fi

    local has_assoc=false
    local mac_filter='([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'

    local ignore_stations=$(_get_uci_value_raw "${GLOBAL}.ignore_stations")
    local ignore_stations_filter=$( _join_by_char "|" ${ignore_stations} )

    # check if no stations are associated
    local _if
    for _if in $(_wifi_get_interfaces)
    do
        local stations ignored_stations
        stations=$(iwinfo "${_if}" assoclist | grep -o -E "${mac_filter}")
        if [ -n "${ignore_stations}" ]; then
            local all_stations="$stations"
            stations=$(printf "%s\n" ${stations} | grep -vwi -E "${ignore_stations_filter}")
            ignored_stations="$( printf "%s\n" $all_stations $stations | sort | uniq -u )"
        fi

        test -n "${stations}" || continue

        has_assoc=true

        _log "Clients connected on '${_if}': $(_join_by_char ' ' ${stations})"
        if test -n "${ignored_stations}"
        then
        _log "Clients ignored on   '${_if}': $(_join_by_char ' ' ${ignored_stations})"
        fi
    done

    _crontab_rm_script_entries_by_arg "recheck"

    if [ "$has_assoc" = "false" ]
    then
        if _cfg_can_wifi_run_now
        then
            _log "Do not disable wifi since there is an allow timewindow, skip rechecking."
        else
            _log "No stations associated, disable wifi."
            wifi_disable
        fi
    else
        _log "Could not disable wifi due to associated stations, retrying..."
        local recheck_interval=$(_get_uci_value "${GLOBAL}.recheck_interval")
        if [ -n "${recheck_interval}" -a "${recheck_interval}" -gt 0 ] ; then
            _crontab_add_entry_raw "*/${recheck_interval} * * * * /bin/nice -n 19 ${SCRIPT} recheck"
        fi
    fi

    _cron_restart
}

wifi_enable()
{
    _crontab_rm_script_entries_by_arg "recheck"
    _cron_restart
    if _cfg_global_is_unload_modules_enabled
    then
        _load_modules
    fi
    _uci_enable_all_radio_devices
}

wifi_startup()
{
    _cfg_global_is_enabled || return

    if _cfg_can_wifi_run_now
    then
        _log "enable wifi"
        wifi_enable
    else
        _log "disable wifi"
        wifi_disable
    fi
}

usage()
{
    echo "$0 cron|start|startup|stop|forcestop|recheck|getmodules|savemodules|help"
    echo ""
    echo "    UCI Config File: /etc/config/${PACKAGE}"
    echo ""
    echo "    cron: Create cronjob entries."
    echo "    start: Start wifi."
    echo "    startup: Checks current timewindow and enables/disables WIFI accordingly."
    echo "    stop: Stop wifi gracefully, i.e. check if there are stations associated and if so keep retrying."
    echo "    forcestop: Stop wifi immediately."
    echo "    recheck: Recheck if wifi can be disabled now."
    echo "    getmodules: Returns a list of modules used by the wireless driver(s)"
    echo "    savemodules: Saves a list of automatic determined modules to UCI"
    echo "    help: This description."
    echo ""
}

_cleanup()
{
    lock -u "${LOCKFILE}"
    rm "${LOCKFILE}"
}

###############################################################################
# MAIN
###############################################################################
trap _cleanup EXIT

LOGGING=$(_get_uci_value "${GLOBAL}.logging") || _exit 1
_log "${SCRIPT}" "$@"
lock "${LOCKFILE}"

case "$1" in
    cron)
        _crontab_reset_from_cfg
        _cron_restart
        wifi_startup
    ;;
    start) wifi_enable ;;
    startup) wifi_startup ;;
    forcestop) wifi_disable ;;
    stop) wifi_soft_disable ;;
    recheck) wifi_soft_disable ;;
    getmodules) get_module_list ;;
    savemodules) save_module_list_uci ;;
    help|--help|-h|*) usage ;;
esac

_exit 0

