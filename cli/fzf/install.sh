#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure fzf ?"; then
	sudo pacman -S fzf --needed
	source_file "$DOTFILES/cli/fzf/init.zsh"
fi
