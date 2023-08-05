#!/usr/bin/env bash

[[ -z $DOTFILES ]] && DOTFILES="$HOME/.dotfiles"
source "$DOTFILES/utils.sh"

source_file "$DOTFILES/cli/starship/init.zsh"
source_file "$DOTFILES/cli/git/init.zsh"
source_file "$DOTFILES/cli/omz/init.zsh"
source_file "$DOTFILES/cli/nvm/init.zsh"
source_file "$DOTFILES/cli/fzf/init.zsh"
source_file "$DOTFILES/cli/nnn/init.zsh"
source_file "$DOTFILES/cli/nvim/init.zsh"
source_file "$DOTFILES/cli/z/init.zsh"

# setup aliases
source_file "$DOTFILES/alias.zsh"
