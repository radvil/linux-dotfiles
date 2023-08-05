#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "../utils.sh"

if confirmed "Install \"z.lua\" as directory jumper ?"; then
	sudo pacman -S lua --needed
fi
