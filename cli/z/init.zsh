#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

Z_FILE="$DOTFILES/cli/z/config.lua"
[ -f "$Z_FILE" ] || warn "file $Z_FILE was not found"
eval "$(lua $Z_FILE --init zsh)"
