#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/scripts.bashrc" "$HOME/.bashrc.d/scripts.bashrc"

echo "scripts configured"
