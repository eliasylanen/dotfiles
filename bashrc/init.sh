#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to safely link files
link_file() {
	local source="$1"
	local target="$2"

	# If target is already the correct symlink, do nothing
	if
		[ -L "$target" ] &&
		[ "$(readlink -f "$target")" == "$source" ]
	then
		return
	fi

	# If target exists and is NOT a symlink, back it up
	if
		[ -e "$target" ] &&
		[ ! -L "$target" ]
	then
		echo "Backing up existing $target to $target.bak"
		mv "$target" "$target.bak"
	fi

	# Create the symlink
	ln -sf "$source" "$target"
	echo "Linked $target -> $source"
}

link_file "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
link_file "$SCRIPT_DIR/.bash_aliases" "$HOME/.bash_aliases"

mkdir -p "$HOME/.bashrc.d"
link_file "$SCRIPT_DIR/prompt.bashrc" "$HOME/.bashrc.d/prompt.bashrc"

echo "bashrc configured"
