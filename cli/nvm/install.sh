#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

if confirmed "Install and configure \"node version manager\" ?"; then
	## Node Version Manager
	if [ ! -d "$HOME/.nvm" ]; then
		NVM_DIR="$HOME/.nvm"
		log "Installing \"Node Version Manager\"..."
		git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
		pushd "$NVM_DIR" || exit
		git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
		popd || exit

		source_file "$NVM_DIR/nvm.sh"
		success "\"Node Version Manager\" installed successfully!"

		# Install nodejs packages globally
		log "Installing global npm modules..."
		nvm install v14
		nvm alias default 14
		npm install -g @angular/cli@13 yarn
		nvm install --lts
		nvm use --lts
		npm install -g @angular/cli@next yarn nx

		success "Global node modules installed successfully!"
	else
		log "\"Node Version Manager\" has already installed. Skipping..."
	fi
fi
