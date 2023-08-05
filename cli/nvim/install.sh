#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

if confirmed "Install and configure \"Neovim Nightly\" ?"; then
	sudo pacman -S tmux fzf lua luarocks --needed
	yay -S neovim-nightly-bin

	ln -sf "$DOTFILES/cli/nvim/configs/nvmini" "$HOME/.config/nvmini"
	success "\"nvmini\" configuration linked!"

	ln -sf "$DOTFILES/cli/nvim/configs/lazyvim" "$HOME/.config/lazyvim"
	success "\"lazyvim\" configuration linked!"
fi
