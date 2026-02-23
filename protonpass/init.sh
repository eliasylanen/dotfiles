#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command pass-cli || curl -fsSL https://proton.me/download/pass-cli/install.sh | bash

if ! pass-cli test &>/dev/null; then
		pass-cli login
		pass-cli settings set default-vault --vault-name Personal
fi

mkdir -p "$HOME/.ssh"

pass-cli inject --in-file "$SCRIPT_DIR/ssh-config.tpl" --out-file "$HOME/.ssh/config" --file-mode 0644
pass-cli inject --in-file "$SCRIPT_DIR/.gitconfig.tpl" --out-file "$HOME/.gitconfig" --file-mode 0644

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/protonpass.bashrc" "$HOME/.bashrc.d/protonpass.bashrc"

echo "Proton Pass CLI configured"
