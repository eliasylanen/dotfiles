#!/bin/bash

set -euo pipefail


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command brew ||/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/brew.bashrc" "$HOME/.bashrc.d/brew.bashrc"

echo "brew configured"
