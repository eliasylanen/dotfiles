#!/bin/bash

set -euo pipefail

if
	command -v zed &> /dev/null &&
	[[ -L "$HOME/.config/zed" ]]
then
	echo "zed already configured"
	exit 0
fi

curl -f https://zed.dev/install.sh | sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf "$SCRIPT_DIR/config" "$HOME/.config/zed"

echo "zed configured"
