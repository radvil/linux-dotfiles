#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure \"Git Utilities\" ?"; then
	sudo pacman -S git git-delta lazygit --needed
	local config_path="$HOME/.config/lazygit"
	if [ ! -d "$config_path" ]; then
		mkdir "$config_path" -p
	fi
	setup_link "$DOTFILES/cli/git/lazygit-config.yml" "$config_path/config.yml"
fi
