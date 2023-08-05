#!/usr/bin/env bash

[[ -z $DOTFILES ]] && DOTFILES="$HOME/.dotfiles"
source "$DOTFILES/utils.sh"

source_file "$DOTFILES/cli/starship/init.sh"
source_file "$DOTFILES/cli/git/init.sh"
source_file "$DOTFILES/cli/omz/init.sh"
source_file "$DOTFILES/cli/nvm/init.sh"
source_file "$DOTFILES/cli/fzf/init.sh"
source_file "$DOTFILES/cli/nnn/init.sh"
source_file "$DOTFILES/cli/nvim/init.sh"
source_file "$DOTFILES/cli/z/init.sh"

# setup aliases
source_file "$DOTFILES/alias.zsh"
