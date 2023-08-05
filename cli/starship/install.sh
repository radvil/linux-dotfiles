#!/usr/bin/env zsh

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

if confirmed "Install and configure starship prompt ?"; then
	sudo pacman -S starship --needed
fi
