#!/usr/bin/env zsh

Z_FILE="$DOTFILES/cli/z/config.lua"
[ -f "$Z_FILE" ] || warn "file $Z_FILE was not found"
eval "$(lua $Z_FILE --init zsh)"
