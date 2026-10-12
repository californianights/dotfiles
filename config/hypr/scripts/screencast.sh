#!/usr/bin/env bash

set -e

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

# Stop existing recording
if pgrep -f '^gpu-screen-recorder' >/dev/null; then
    pkill -INT -f '^gpu-screen-recorder'
    exit 0
fi

MODE="${1:-screen}"

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
OUTPUT="$OUTPUT_DIR/recording-$TIMESTAMP.mp4"

case "$MODE" in
    screen)
        gpu-screen-recorder \
            -w eDP-1 \
            -f 60 \
            -q high \
            -o "$OUTPUT"
        ;;

    region)
        REGION=$(slurp) || exit 0

        read -r POS SIZE <<< "$REGION"

        X="${POS%,*}"
        Y="${POS#*,}"

        gpu-screen-recorder \
            -w region \
            -region "${SIZE}+${X}+${Y}" \
            -f 60 \
            -q high \
            -o "$OUTPUT"
        ;;

    *)
        echo "Usage: $0 {screen|region}"
        exit 1
        ;;
esac
