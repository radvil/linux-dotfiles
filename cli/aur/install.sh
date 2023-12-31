#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

# Install AUR Helper
if confirmed "Install \"AUR Utils\" ?"; then
	if ! has_installed yay; then
		log "Installing \"yay\" as \"AUR Helper\" alternative"
		DOWNLOAD_PATH="$HOME/Downloads/Programs"
		mkdir "$DOWNLOAD_PATH" -p
		git clone https://aur.archlinux.org/yay.git "$DOWNLOAD_PATH/yay"
		pushd "$DOWNLOAD_PATH/yay" || exit
		makepkg -si
		popd || exit
		rm -rf "$DOWNLOAD_PATH/yay"
		success "\"yay\" installed successfully!"
	else
		log "\"yay\" has already installed. Skipping..."
	fi
fi

# enable color on pacman
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
