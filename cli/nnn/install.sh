#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure \"nnn file manager\""; then
	sudo pacman -S nnn --needed
	source_file "$DOTFILES/nnn/deps.sh"
fi
