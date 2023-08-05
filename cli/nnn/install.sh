#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

if confirmed "Install and configure \"nnn file manager\""; then
	sudo pacman -S nnn --needed
	source_file "$DOTFILES/cli/nnn/deps.sh"
fi
