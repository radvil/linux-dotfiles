#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

if confirmed "Install and configure \"Tmux\" ?"; then
	sudo pacman -S tmux fzf git --needed
	success "\"Tmux\" installed successfully!"

	if [ ! -d "$HOME/.config/tmux" ]; then
		mkdir "$HOME/.config/tmux" -p
	fi

	setup_link "$DOTFILES/cli/tmux/config.conf" "$HOME/.config/tmux/tmux.conf"
	success "\"Tmux configuration\" linked successfully!"

	if confirmed "Install additional tmux plugins ?"; then
		plugins_dir="$HOME/.config/tmux/plugins"

		if [ ! -d "$plugins_dir" ]; then
			mkdir "$plugins_dir" -p
		fi

		git clone https://github.com/tmux-plugins/tpm "$plugins_dir/tpm"
		git clone https://github.com/radvil/nightmoon-tmux "$plugins_dir/nightmoon-tmux"
		git clone https://github.com/radvil/vim-splits-tmux "$plugins_dir/vim-splits-tmux"

		success "Tmux plugins successfully installed! 🎉"
	fi
fi
