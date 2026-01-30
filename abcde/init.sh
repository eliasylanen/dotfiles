#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command abcde || { echo >&2 "abcde is not installed. Aborting."; exit 1; }

ln -sf "$SCRIPT_DIR/.abcde.conf" "$HOME/.abcde.conf";
