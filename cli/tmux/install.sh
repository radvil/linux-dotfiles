#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure \"Tmux\" ?"; then
	sudo pacman -S tmux fzf git --needed
	success "\"Tmux\" installed successfully!"

	setup_link "$DOTFILES/cli/tmux/config.conf" "$HOME/.config/tmux/tmux.conf"
	success "\"Tmux configuration\" linked successfully!"
fi

if confirmed "Install additional tmux plugins ?"; then
	plugins_dir="$HOME/.tmux/plugins"

	if [ ! -d "$plugins_dir" ]; then
		mkdir "$plugins_dir" -p
	fi

	git clone https://github.com/tmux-plugins/tpm "$plugins_dir/tpm"
	git clone https://github.com/radvil/nightmoon-tmux "$plugins_dir/nightmoon-tmux"
	git clone https://github.com/radvil/vim-splits-tmux "$plugins_dir/vim-splits-tmux"

	success "🎉 All tmux plugins successfully installed!"
fi
