#!/bin/bash

set -euo pipefail

if
	command -v fnm &> /dev/null &&
	[[ -f "$HOME/.bashrc.d/fnm.bashrc" ]]
then
	echo "fnm already configured"
	exit 0
fi

curl -fsSL https://fnm.vercel.app/install | bash -s --skip-shell

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/fnm.bashrc" "$HOME/.bashrc.d/fnm.bashrc"

echo "fnm configured"
