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

	source_file "$DOTFILES/cli/git/install.zsh"
	source_file "$DOTFILES/cli/aur/install.zsh"
	source_file "$DOTFILES/cli/font/install.zsh"
	source_file "$DOTFILES/cli/starzship/install.zsh"
	source_file "$DOTFILES/cli/omz/install.zsh"
	source_file "$DOTFILES/cli/nvm/install.zsh"
	source_file "$DOTFILES/cli/nnn/install.zsh"
	source_file "$DOTFILES/cli/fzf/install.zsh"
	source_file "$DOTFILES/cli/tmux/install.zsh"
	source_file "$DOTFILES/cli/nvim/install.zsh"
	source_file "$DOTFILES/cli/z/install.zsh"

	# replace zsh environements with customs
	setup_link "$DOTFILES/env.zsh" "$HOME/.zshenv"

	# ensure reload zshenv
    sudo chsh -s /bin/zsh
    log "zsh has been set as the default shell"
    zsh
}

main
