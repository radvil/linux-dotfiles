#!/usr/bin/env zsh

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

export STARSHIP_CONFIG="$DOTFILES/cli/starship/config.toml"
eval $(starship init zsh)

