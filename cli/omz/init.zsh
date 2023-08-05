#!/usr/bin/env zsh

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

plugins=(vi-mode npm node aws colored-man-pages)
source_file "$HOME/.oh-my-zsh/oh-my-zsh.sh" --silent

