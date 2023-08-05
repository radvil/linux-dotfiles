#!/usr/bin/env zsh

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure starship prompt ?"; then
	sudo pacman -S starship --needed
fi
