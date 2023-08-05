#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure \"Oh My ZSH\" ?"; then
	if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
		log "\"Oh My Zsh\" has already installed. skipping.."
	else
		log "Installing \"Oh My Zsh\"..."

		INSTALL_SCRIPT="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
		DOWNLOAD_DIR="$HOME/Downloads/Programs/oh-my-zsh"
		mkdir "$DOWNLOAD_DIR" -p
		pushd "$DOWNLOAD_DIR" || exit
		wget "$INSTALL_SCRIPT"
		chmod +x "$DOWNLOAD_DIR/install.sh"
		echo "./install.sh --skip-chsh --keep-zshrc" | sh
		popd || exit
		rm -rf "$DOWNLOAD_DIR"

		success "\"Oh My Zsh\" installed successfully!"
	fi
fi
