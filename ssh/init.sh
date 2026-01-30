#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command keychain || { echo >&2 "keychain is not installed. Aborting."; exit 1; }

# check that ~/.ssh directory exists
[[ -d "$HOME/.ssh" ]] || { echo >&2 "directory ~/.ssh does not exist. Aborting."; exit 1; }

# Check that SSH key exists
[[ -f "$HOME/.ssh/id_rsa" ]] || { echo >&2 "~/.ssh/id_rsa does not exist"; exit 1; }
[[ -f "$HOME/.ssh/id_rsa.pub" ]] || { echo >&2 "~/.ssh/id_rsa.pub does not exist"; exit 1; }
[[ -f "$HOME/.ssh/config" ]] || { echo >&2 "~/.ssh/config does not exist"; exit 1; }

chmod 600 "$HOME/.ssh/id_rsa"
chmod 644 "$HOME/.ssh/id_rsa.pub"
chmod 644 "$HOME/.ssh/config"


mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/keychain.bashrc" "$HOME/.bashrc.d/keychain.bashrc"

echo "SSH keychain configured"
