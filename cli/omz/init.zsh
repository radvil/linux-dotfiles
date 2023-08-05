#!/usr/bin/env zsh

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

plugins=(npm node aws colored-man-pages)
source_file "$HOME/.oh-my-zsh/oh-my-zsh.sh" --silent

