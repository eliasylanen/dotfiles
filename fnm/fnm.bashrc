#!/bin/bash

# fnm
FNM_PATH="/home/elias/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  if [[ ":$PATH:" != *":$FNM_PATH:"* ]]; then
    export PATH="$FNM_PATH:$PATH"
  fi

  eval "$(fnm env --use-on-cd --shell bash)"
  eval "$(fnm completions --shell bash)"
fi
