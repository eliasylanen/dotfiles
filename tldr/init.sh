#!/bin/bash

set -euo pipefail;

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../util/check_command.sh"
check_command tldr || { echo >&2 "tldr is not installed. Aborting."; exit 1; }

tldr --update
tldr --seed-config
