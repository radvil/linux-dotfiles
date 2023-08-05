#!/usr/bin/env sh

USERNAME=$(whoami)
DOTFILES="$HOME/.dotfiles"

source "$HOME/.dotfiles/utils.sh"

sudo chown -R "$USERNAME" "$DOTFILES"

set -e

printf "Initialize dotfiles at %s$DOTFILES...\n"

main() {
	if confirmed "Upgrade all packages ?"; then
		sudo pacman -Syyu
	fi

	install_from_file "$DOTFILES/cli/deps.txt"

	source_file "$DOTFILES/cli/git/install.sh"
	source_file "$DOTFILES/cli/aur/install.sh"
	source_file "$DOTFILES/cli/font/install.sh"
	source_file "$DOTFILES/cli/starship/install.sh"
	source_file "$DOTFILES/cli/omz/install.sh"
	source_file "$DOTFILES/cli/nvm/install.sh"
	source_file "$DOTFILES/cli/nnn/install.sh"
	source_file "$DOTFILES/cli/fzf/install.sh"
	source_file "$DOTFILES/cli/tmux/install.sh"
	source_file "$DOTFILES/cli/nvim/install.sh"
	source_file "$DOTFILES/cli/z/install.sh"

	# replace zsh environements with customs
	setup_link "$DOTFILES/cli/zshenv" "$HOME/.zshenv"

	# ensure reload zshenv
	sudo chsh -s /bin/zsh
	log "zsh has been set as the default shell"
	zsh
}

main
