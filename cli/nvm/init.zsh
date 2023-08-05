#!/usr/bin/env bash

[[ -z $DOTFILES ]] && source "$HOME/.dotfiles/utils.sh"

# should setup NVM before anything else
source_file "$HOME/.nvm/nvm.sh" --silent
source_file "$HOME/.nvm/bash_completion" --silent
