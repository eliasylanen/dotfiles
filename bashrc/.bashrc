#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source bash completion
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi


case ":$PATH:" in
	*:"$HOME/.local/bin":*) ;;
	*) PATH="$HOME/.local/bin:$HOME/bin:$PATH" ;;
esac
export PATH

if [ ! -d "$HOME/.bashrc.d" ]; then
	mkdir -p "$HOME/.bashrc.d"
fi


# User specific functions
if [ -d "$HOME/.bashrc.d" ]; then
	for rc in "$HOME/.bashrc.d"/*; do
			if [ -f "$rc" ]; then
				. "$rc"
			fi
	done
fi
unset rc

# User specific aliases
if [ -f "$HOME/.bash_aliases" ]; then
	. "$HOME/.bash_aliases"
fi
