#!/bin/bash

DIR="$HOME/Pictures/wallpapers"

choice=$(find "$DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    -printf "%f\n" |
    sort |
    rofi -dmenu -i -p "Wallpaper" -theme "$HOME/.config/waybar/scripts/wallpaper.rasi")

[ -z "$choice" ] && exit 0

hyprctl hyprpaper wallpaper "eDP-1,$DIR/$choice"

echo "$FILE" > "$HOME/.config/hypr/current-wallpaper"

hyprctl hyprpaper preload "$FILE"
hyprctl hyprpaper wallpaper "eDP-1,$FILE"
