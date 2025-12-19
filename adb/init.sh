#!/bin/bash

set -euo pipefail

if
	command -v adb &> /dev/null &&
	[[ -f "$HOME/.bashrc.d/adb.bashrc" ]]
then
	echo "adb already configured"
	exit 0
fi

command -v python >/dev/null 2>&1 || { echo >&2 "python is not installed. Aborting."; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo >&2 "unzip is not installed. Aborting."; exit 1; }

curl -fsSLO https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip -q platform-tools-latest-linux.zip -d "$HOME/"
rm platform-tools-latest-linux.zip

python -m ensurepip --upgrade

pip install --user --upgrade BetterADBSync

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/adb.bashrc" "$HOME/.bashrc.d/adb.bashrc"

echo "adb configured"
