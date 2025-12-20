#!/bin/bash

set -eo pipefail

# Strip ANSI codes, convert to lowercase, and trim
output=$(kscreen-doctor -o | grep -m1 "Scale" | cut -d: -f2 | sed 's/\x1B\[[0-9;]*[mGK]//g' | tr '[:upper:]' '[:lower:]' | xargs)

if [ "$output" = "1" ]; then
	kscreen-doctor output.1.scale.2.5
else
	kscreen-doctor output.1.scale.1
fi
