#!/bin/bash

set -eo pipefail

# Strip ANSI codes, convert to lowercase, and trim
output=$(kscreen-doctor -o | grep -m1 "HDR" | cut -d: -f2 | sed 's/\x1B\[[0-9;]*[mGK]//g' | tr '[:upper:]' '[:lower:]' | xargs)

if [ "$output" = "disabled" ]; then
	echo "Enabling HDR"
	kscreen-doctor output.1.hdr.enable
	kscreen-doctor output.1.brightness.100
	kscreen-doctor output.1.mode.3
	kdialog --passivepopup "HDR enabled" 4
else
	echo "Disabling HDR"
	kscreen-doctor output.1.hdr.disable
	kscreen-doctor output.1.brightness.70
	kscreen-doctor output.1.mode.1
	kdialog --passivepopup "HDR disabled" 4
fi
