#!/bin/env bash
#shellcheck disable=2181

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/utils.sh"

git_purge_branch() {
	branch="$1"
	dot push -d origin "$branch"
	dot branch -D "$branch"
	if [ ! $? -eq 0 ]; then
		warn " failed to remove branch $branch"
	else
		success " branch $branch removed"
	fi
}

## @ref https://stackoverflow.com/questions/10312521/how-do-i-fetch-all-git-branches
git_sync_all() {
	git branch -r | grep -v '\->' | sed "s,\x1b\[[0-9;]*[a-za-z],,g" | while read -r remote; do git branch --track "${remote#origin/}" "$remote"; done
	git fetch --all
	git pull --all
}

# changing dir on lazygit exited
lazygit_with_cwd_switch() {
	ensure_exec "lazygit"
	cache_dir="$HOME/.cache/lazygit/cwd_newdir"
	[ ! -d "$cache_dir" ] && mkdir --parents "$cache_dir"
	lazygit "$@"
	if [ -f "$cache_dir" ]; then
		"cd $(cat "$cache_dir")" || exit
		rm -f "$cache_dir >/dev/null"
	fi
}

alias lg="lazygit"
alias lgs="lazygit_with_cwd_switch"