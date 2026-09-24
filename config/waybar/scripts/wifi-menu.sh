#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/waybar/scripts/menu.rasi"

get_networks() {
    nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list \
        | awk -F: '
            $2 != "" {
                icon = ($1 == "*") ? "●" : "○"
                security = ($4 != "") ? "󰌾" : "󰿆"
                printf "%s %s  %s %s\n", icon, $2, $3 "%", security
            }
        '
}

choice=$( {
    get_networks
    printf '%s\n' "󰖪  Disconnect"
    printf '%s\n' "󰒓  Network settings"
} | rofi -dmenu -i -p "Wi-Fi" -theme "$ROFI_THEME" )

case "$choice" in
    "󰒓  Network settings")
        nm-connection-editor
        ;;

    "󰖪  Disconnect")
        nmcli device disconnect wlp0s20f3
        ;;

    *)
        ssid=$(printf '%s' "$choice" | sed -E 's/^[●○] //; s/  [0-9]+%.*$//')

        [ -n "$ssid" ] && nmcli device wifi connect "$ssid"
        ;;
esac
