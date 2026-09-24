#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/waybar/scripts/menu.rasi"

battery=$(upower -e | grep '/battery_' | head -1)

if [ -z "$battery" ]; then
    notify-send "Battery" "Battery not found"
    exit 1
fi

info=$(upower -i "$battery")

percentage=$(printf '%s\n' "$info" | awk '/percentage:/ {print $2}')
state=$(printf '%s\n' "$info" | awk '/state:/ {print $2}')
time=$(printf '%s\n' "$info" | awk '/time to (empty|full):/ {$1=$2=""; sub(/^  /,""); print}')

choice=$(printf '%s\n' \
    "󰁹  $percentage — $state" \
    "󰥔  $time" \
    | rofi -dmenu -i -p "Battery" -theme "$ROFI_THEME")

exit 0
