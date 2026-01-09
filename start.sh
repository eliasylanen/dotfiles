#!/bin/bash

set -euo pipefail;

echo "The automation requires that the following packages are installed:"
echo "coreutils"
echo "git"
echo "keychain"
echo "tealdeer"
echo "python"
echo "unzip"
echo "zip"

read -p "Have you installed all the required packages? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Please install the required packages before proceeding."
  exit 1
fi

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
