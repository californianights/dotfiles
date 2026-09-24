#!/usr/bin/env bash

LAT="43.5855"
LON="39.7231"

[[ -z "$OPENWEATHER_API_KEY" ]] && exit 1

WEATHER=$(curl -sf --max-time 10 \
    "https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&appid=${OPENWEATHER_API_KEY}&units=metric&lang=ru") || exit 1

TEMP=$(jq -r '.main.temp' <<< "$WEATHER" | cut -d. -f1)
FEELS=$(jq -r '.main.feels_like' <<< "$WEATHER" | cut -d. -f1)
CONDITION=$(jq -r '.weather[0].description' <<< "$WEATHER")
ID=$(jq -r '.weather[0].id' <<< "$WEATHER")
ICON_CODE=$(jq -r '.weather[0].icon' <<< "$WEATHER")

case "$ID" in
    2*)
        ICON="󰖓" # гроза
        ;;
    3*)
        ICON="󰖖" # морось
        ;;
    5*)
        ICON="󰖖" # дождь
        ;;
    6*)
        ICON="󰖘" # снег
        ;;
    7*)
        ICON="󰖑" # туман
        ;;
    *)
        case "$ICON_CODE" in
            01d)
                ICON="☀"
                ;;
            01n)
                ICON="󰖙"
                ;;
            02d|02n)
                ICON="󰖕"
                ;;
            03d|03n|04d|04n)
                ICON="☁"
                ;;
            *)
                ICON="󰖐"
                ;;
        esac
        ;;
esac

echo "{\"text\":\"${ICON} ${TEMP}°\",\"tooltip\":\"Сочи · ${CONDITION}\\nОщущается как ${FEELS}°\"}"
