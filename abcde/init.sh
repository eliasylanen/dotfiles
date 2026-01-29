set -euo pipefail

# only install abcde if not already installed
if ! command -v abcde &> /dev/null; then
	echo "Installing abcde..."
	if [ -f /etc/fedora-release ]; then
		sudo dnf update -y && sudo dnf install abcde;
	elif [ -f /etc/debian_version ]; then
		sudo apt update && sudo apt install abcde;
	fi
else
	echo "abcde is already installed"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf "$SCRIPT_DIR/.abcde.conf" "$HOME/.abcde.conf"
