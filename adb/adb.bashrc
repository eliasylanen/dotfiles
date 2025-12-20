#!/bin/bash

if [[ ":$PATH:" != *":$HOME/platform-tools:"* ]]; then
	export PATH="$HOME/platform-tools:$PATH";
fi
