#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/waybar/scripts/menu.rasi"

choice=$(printf '%s\n' \
    "󰌾  Lock" \
    "󰍃  Logout" \
    "󰜉  Reboot" \
    "󰐥  Shutdown" \
    | rofi -dmenu -i -p "Power" -theme "$ROFI_THEME")

case "$choice" in
    "󰌾  Lock")
        loginctl lock-session
        ;;
    "󰍃  Logout")
        loginctl terminate-session "$XDG_SESSION_ID"
        ;;
    "󰜉  Reboot")
        systemctl reboot
        ;;
    "󰐥  Shutdown")
        systemctl poweroff
        ;;
esac
