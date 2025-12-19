#!/bin/bash

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

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

mkdir -p "$HOME/.bashrc.d"

for rc in "$HOME/.bashrc.d"/*; do
	if [ -f "$rc" ]; then
	. "$rc"
	fi
done
unset rc

if [ -f "$HOME/.bash_aliases" ]; then
	. "$HOME/.bash_aliases"
fi
