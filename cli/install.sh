#!/usr/bin/env sh

cd ..

DOTFILES=$(pwd -P)
USERNAME=$(whoami)

sudo chown -R "$USERNAME" "$DOTFILES"

set -e

printf "Initialize dotfiles at %s$DOTFILES...\n"

\. "$DOTFILES/utils.sh"

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
	setup_link "$DOTFILES/env.zsh" "$HOME/.zshenv"

	# ensure reload zshenv
	so-zsh
}

main
