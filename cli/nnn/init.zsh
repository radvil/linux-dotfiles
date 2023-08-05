#!/usr/bin/env bash

export NNN_TRASH=1
export NNN_COLORS="2136"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_ZLUA="$DOTFILES/cli/z/config.lua"
export NNN_PLUG="f:fzopen;v:preview-tui;e:-!sudo -E nvim '$nnn'*;g:-!lazygit;p:mocq;z:autojump;"

