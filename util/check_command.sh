#!/bin/bash

set -euo pipefail

check_command() {
	if command -v "$1" >/dev/null 2>&1; then
		echo "$1 already installed"
		return 0
	else
		echo "$1 not found"
		return 1
	fi
}
