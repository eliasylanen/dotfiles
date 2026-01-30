#!/bin/bash

install_system_package() {
	local packages=("$@")

	if [ ${#packages[@]} -gt 0 ]; then
		echo "Installing packages: ${packages[*]}..."
		if [ -f /etc/fedora-release ]; then
			sudo dnf update -y && sudo dnf install "${packages[@]}"
		elif [ -f /etc/debian_version ]; then
			sudo apt update && sudo apt install "${packages[@]}"
		fi
		echo "Installation complete"
	fi
}
