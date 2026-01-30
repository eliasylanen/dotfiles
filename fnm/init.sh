#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command fnm || curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell


mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/fnm.bashrc" "$HOME/.bashrc.d/fnm.bashrc"

echo "fnm configured"
