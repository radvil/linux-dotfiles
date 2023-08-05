#!/usr/bin/env bash
# shellcheck disable=SC2046,2086,SC2181,1090

export DOTFILES_UTILS_LOADED="true"

log() {
	printf "[\033[00;34m🚀LOG\033[0m] %s$1\n"
}

warn() {
	printf "[\033[0;33m⚠ WARN\033[0m] %s$1\n"
}

success() {
	printf "\033[2K[\033[00;32m✔ SUCCESS\033[0m] %s$1\n"
}

confirmed() {
	read -r -p "[❓] $1 [Y/n] >> " answer
	answer=${answer,,} # tolower
	if [[ $answer =~ ^(y| ) ]] || [[ -z $answer ]]; then
		return 0
	else
		return 1
	fi
}

setup_link() {
	local src="$1" dst="$2"
	if [ -d "$src" ]; then
		if [ ! -d "$dst" ]; then
			ln -s "$src" "$dst"
			success "linked dir \"$1\" >> \"$2\""
		else
			if confirmed "\"$dst\" already exists, do you wanna replace it ?"; then
				rm -rf "$dst"
				ln -s "$src" "$dst"
				success "linked \"$1\" >> \"$2\""
			else
				warn "\"$1\" to \"$2\" [skipped]"
			fi
		fi
	else
		if [ ! -f "$dst" ]; then
			ln -s "$src" "$dst"
			success "linked file \"$1\" >> \"$2\""
		else
			if confirmed "\"$dst\" already exists, do you wanna replace it ?"; then
				rm -rf "$dst"
				ln -s "$src" "$dst"
				success "linked \"$1\" >> \"$2\""
			else
				warn "\"$1\" to \"$2\" [skipped]"
			fi
		fi
	fi
}

source_file() {
	if [ -s "$1" ]; then
		#shellcheck source=/dev/null
		[[ "$2" == "--verbose" ]] && log "sourcing $1"
		source "$1"
	else
		warn "file $1 doesn't exist! [skipped]"
	fi
}

has_installed() {
	cmdname="$(command -v "$1" 2>/dev/null)"
	[[ -x "$cmdname" ]]
}

regpath() {
	if [[ -z "$1" ]]; then
		warn "PATH : missing argument"
		return 1
	fi

	if [[ ! -d "$1" ]]; then
		warn "PATH: \"$1\" is not a directory"
		return 1
	fi

	if [[ -z "$PATH" ]]; then
		export PATH="$1"
	else
		if [[ ":$PATH:" != *":$1:"* ]]; then
			# echo "adding $1 to PATH"
			export PATH="$1:$PATH"
		fi
		# export path alias
		[[ -n "$2" ]] && export "$2"="$1"
	fi
}

install_from_file() {
	local filename="$1"
	if confirmed "Install packages from file \"$filename\" ?"; then
		sudo pacman -S $(cat $filename) --needed
		if [[ ! $? -eq 0 ]]; then
			warn "Failed during packages installation!"
		else
			success "All packages installed successfully!"
		fi
	fi
}
