#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_ROOT="$(dirname "$CONFIG_DIR")"
APP_NAME="$(basename "$CONFIG_DIR")"
LOG_FILE="$CONFIG_DIR/nvim_check.log"

echo "🔍 Running isolated Neovim check..."
echo "📁 Config dir: $CONFIG_DIR"

rm -f "$LOG_FILE"

if ! NVIM_APPNAME="$APP_NAME" \
XDG_CONFIG_HOME="$CONFIG_ROOT" \
nvim --headless \
  "+qa" 2> "$LOG_FILE"; then
  echo "❌ Errors:"
  cat "$LOG_FILE"
  exit 1
fi

if [ -s "$LOG_FILE" ]; then
  echo "❌ Errors:"
  cat "$LOG_FILE"
  exit 1
fi

echo "✅ OK"