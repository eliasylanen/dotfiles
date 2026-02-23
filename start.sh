#!/bin/bash

set -euo pipefail;

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/util/install_system_package.sh"
install_system_package abcde coreutils git tealdeer python3 unzip zip

dirs=($(find . -type f -name "init.sh" -printf "%h\n" | sort))

for dir in "${dirs[@]}"; do
  echo "Running $dir/init.sh..."
  source "$dir/init.sh"
done

kernel_info=$(uname -a);
if [[ "$kernel_info" == *"microsoft"* ]]; then
  echo "Running WSL init script...";
  source ./wsl/wsl.sh;
fi

echo "Done, please source .bashrc to complete the setup.";
