#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/cli/utils.sh"

set -e

if confirmed "Install and configure additional fonts (including Nerd+Emoji fonts) ?"; then
	deps_file="$DOTFILES/cli/font/deps.txt"

	log "Selecting $(cat "$deps_file") to be installed!"
	log "Installing additional fonts..."

	install_from_file "$deps_file"
	success "Extra fonts installed successfully!"

    [[ -d /etc/fonts ]] || sudo mkdir /etc/fonts -p
    [[ -f /etc/fonts/local.conf ]] || sudo touch /etc/fonts/local.conf

	echo '<?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
  <alias>
  <family>sans-serif</family>
  <prefer>
  <family>Noto Sans</family>
  <family>Noto Color Emoji</family>
  <family>Noto Emoji</family>
  <family>DejaVu Sans</family>
  </prefer> 
  </alias>

  <alias>
  <family>serif</family>
  <prefer>
  <family>Noto Serif</family>
  <family>Noto Color Emoji</family>
  <family>Noto Emoji</family>
  <family>DejaVu Serif</family>
  </prefer>
  </alias>

  <alias>
  <family>monospace</family>
  <prefer>
  <family>Noto Mono</family>
  <family>Noto Color Emoji</family>
  <family>Noto Emoji</family>
  <family>DejaVu Sans Mono</family>
  </prefer>
  </alias>
  </fontconfig>
  ' | sudo tee -a /etc/fonts/local.conf >/dev/null

	# reload font cache
    if has_installed fc-cache; then
	    fc-cache
    fi

	success "Noto Emoji Font installed successfully"
	warn "It is recommended to restart applications that are currenly opened!"
fi
