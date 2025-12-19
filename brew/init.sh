#!/bin/bash

set -euo pipefail

if
	command -v brew &> /dev/null &&
	[[ -f "$HOME/.bashrc.d/brew.bashrc" ]]
then
	echo "brew already configured"
	exit 0
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/brew.bashrc" "$HOME/.bashrc.d/brew.bashrc"

echo "brew configured"
