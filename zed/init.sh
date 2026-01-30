#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command zed || curl -f https://zed.dev/install.sh | sh

ln -sf "$SCRIPT_DIR/config" "$HOME/.config/zed"

echo "zed configured"
