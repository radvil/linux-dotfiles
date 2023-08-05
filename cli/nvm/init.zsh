#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

# should setup NVM before anything else
source_file "$HOME/.nvm/nvm.sh" --silent
source_file "$HOME/.nvm/bash_completion" --silent
