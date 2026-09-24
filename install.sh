#!/usr/bin/env bash

set -e

DOTFILES="$HOME/.dotfiles"

link() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        rm "$target"
    elif [ -e "$target" ]; then
        echo "ERROR: $target already exists and is not a symlink"
        echo "Move or remove it manually."
        exit 1
    fi

    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"

    echo "Linked: $target -> $source"
}

echo "Installing dotfiles..."

link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/config/hypr" "$HOME/.config/hypr"
link "$DOTFILES/config/nvim" "$HOME/.config/nvim"
link "$DOTFILES/config/waybar" "$HOME/.config/waybar"
link "$DOTFILES/config/wezterm" "$HOME/.config/wezterm"

echo "Done."
