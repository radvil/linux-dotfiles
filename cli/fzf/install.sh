#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

if confirmed "Install and configure fzf ?"; then
	sudo pacman -S fzf --needed
fi
