#!/bin/bash

set -euo pipefail;

command -v tldr >/dev/null 2>&1 || { echo >&2 "tldr is not installed. Aborting."; exit 1; }

tldr --update
tldr --seed-config
