#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/waybar/scripts/menu.rasi"

get_powered() {
    bluetoothctl show | awk '/Powered:/ {print $2}'
}

get_devices() {
    declare -A seen

    bluetoothctl devices | while read -r _ mac name; do
        seen["$mac"]=1
        info=$(bluetoothctl info "$mac" 2>/dev/null)

        if printf '%s\n' "$info" | grep -q "Connected: yes"; then
            icon="●"
        else
            icon="○"
        fi

        printf '%s\t%s\t%s\n' "$icon" "$mac" "$name"
    done

    bluetoothctl devices | while read -r _ mac name; do
        info=$(bluetoothctl info "$mac" 2>/dev/null)

        if ! printf '%s\n' "$info" | grep -q "Name:"; then
            continue
        fi

        if printf '%s\n' "$info" | grep -q "Connected: yes"; then
            icon="●"
        else
            icon="○"
        fi

        printf '%s\t%s\t%s\n' "$icon" "$mac" "$name"
    done | sort -u -k2,2
}

while true; do
    powered=$(get_powered)

    if [ "$powered" = "yes" ]; then
        toggle="󰂲  Turn Bluetooth off"

        bluetoothctl --timeout 3 scan on >/dev/null 2>&1 &
        scan_pid=$!

        sleep 2

        devices=$(get_devices)

        kill "$scan_pid" 2>/dev/null

        menu=$( {
            printf '%s\n' "$toggle"
            printf '%s\n' "──────────────"

            printf '%s\n' "$devices" |
                while IFS=$'\t' read -r icon mac name; do
                    printf '%s  %s\n' "$icon" "$name"
                done
        } )
    else
        toggle="󰂯  Turn Bluetooth on"

        menu="$toggle"
    fi

    choice=$(printf '%s\n' "$menu" |
        rofi -dmenu -i -p "Bluetooth" -theme "$ROFI_THEME")

    case "$choice" in
        "󰂲  Turn Bluetooth off")
            bluetoothctl power off >/dev/null
            continue
            ;;

        "󰂯  Turn Bluetooth on")
            bluetoothctl power on >/dev/null
            sleep 1
            continue
            ;;

        "")
            exit 0
            ;;

        *)
            name=$(printf '%s' "$choice" | sed 's/^[●○]  //')

            [ -z "$name" ] && continue

            mac=$(bluetoothctl devices |
                while read -r _ mac device_name; do
                    if [ "$device_name" = "$name" ]; then
                        echo "$mac"
                        break
                    fi
                done)

            [ -z "$mac" ] && continue

            if bluetoothctl info "$mac" 2>/dev/null |
                grep -q "Connected: yes"; then

                bluetoothctl disconnect "$mac" >/dev/null
            else
                bluetoothctl connect "$mac" >/dev/null 2>&1

                if [ $? -ne 0 ]; then
                    bluetoothctl pair "$mac" >/dev/null 2>&1
                    bluetoothctl connect "$mac" >/dev/null 2>&1
                fi
            fi

            sleep 1
            continue
            ;;
    esac
done
