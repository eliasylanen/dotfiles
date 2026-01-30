#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../util/check_command.sh"

check_command adb && exit 0;
check_command python || { echo >&2 "python is not installed. Aborting."; exit 1; }
check_command unzip || { echo >&2 "unzip is not installed. Aborting."; exit 1; }

curl -fsSLO https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip -q platform-tools-latest-linux.zip -d "$HOME/"
rm platform-tools-latest-linux.zip

python -m ensurepip --upgrade

pip install --user --upgrade BetterADBSync

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/adb.bashrc" "$HOME/.bashrc.d/adb.bashrc"

echo "adb configured"
