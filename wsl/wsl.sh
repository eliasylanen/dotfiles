#!/bin/bash

curl -sL https://raw.githubusercontent.com/wslutilities/wslu/master/extras/scripts/wslu-install | bash

windowsUserFolder=$(wslpath "$(wslvar USERPROFILE)");

cp "../common/sources/.gitconfig" "$windowsUserFolder/";
cp "../sources/scoop.json" "$windowsUserFolder/Desktop/";
cp "../sources/update-startup.lnk" "$windowsUserFolder/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/";
cp "../sources/WindowsTerminalSettings.json" "$windowsUserFolder/Desktop/";
cp "../sources/winget.json" "$windowsUserFolder/Desktop/";

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.bashrc.d"
ln -sf "$SCRIPT_DIR/wsl.bashrc" "$HOME/.bashrc.d/wsl.bashrc"

echo "HINT: after installing 1password and op.exe CLI on the Windows side, soft-link op.exe to /usr/local/bin in WSL";
