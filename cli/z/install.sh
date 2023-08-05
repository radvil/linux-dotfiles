#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure \"z.lua\" ?"; then
	sudo pacman -S lua --needed
	source_file "$DOTFILES/cli/z/init.zsh"
fi