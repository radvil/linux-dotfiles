#!/usr/bin/env bash

alias v="NVIM_APPNAME=nvmini nvim"
alias vi="NVIM_APPNAME=nvmini nvim"
alias lzv="NVIM_APPNAME=lazyvim nvim"

function nvim-select() {
  items=("nvmini lazyvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Nvim Select  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing was selected"
    return 0
  elif [[ $config == "Default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^e "nvim-select\n"
