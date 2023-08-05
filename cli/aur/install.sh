#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

# Install AUR Helper
if ! has_installed yay; then
	if confirmed "Install \"AUR Utils\" ?"; then
		log "Installing \"yay\" as \"AUR Helper\" alternative"
		DOWNLOAD_PATH="$HOME/Downloads/Programs"
		mkdir "$DOWNLOAD_PATH" -p
		git clone https://aur.archlinux.org/yay.git "$DOWNLOAD_PATH/yay"
		pushd "$DOWNLOAD_PATH/yay" || exit
		makepkg -si
		popd || exit
		rm -rf "$DOWNLOAD_PATH/yay"
		success "\"yay\" installed successfully!"
	fi
else
	log "\"yay\" has already installed. Skipping..."
fi

# toggle color options into pacman
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
