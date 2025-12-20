#!/bin/bash

if [[ ":$PATH:" != *":$HOME/git/dotfiles/scripts:"* ]]; then
	export PATH="$HOME/git/dotfiles/scripts:$PATH";
fi
