update_system_pkgs() {
    if [ -f /etc/fedora-release ]; then
        echo "Detected Fedora. Updating with dnf..."
        sudo dnf update -y
    elif [ -f /etc/debian_version ]; then
        echo "Detected Debian/Ubuntu. Updating with apt..."
        sudo apt update && sudo apt full-upgrade -y
    fi
}

update_flatpaks() {
    if grep -qEi "(Microsoft|WSL)" /proc/version; then
        echo "WSL detected. Skipping flatpak update."
    else
        flatpak update
    fi
}

alias update_all="brew update && brew upgrade && update_flatpaks && curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell && update_system_pkgs";

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
