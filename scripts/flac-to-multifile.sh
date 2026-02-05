#!/bin/bash

process_cue() {
  local cue_file="$1"
  echo "CUE: $cue_file"

  # Replace extension .cue with .flac
  local flac_file="${cue_file%.cue}.flac"

  if [ -f "$flac_file" ]; then
    echo "FLAC: $flac_file"
  else
    echo "FLAC not found for: $cue_file"
    exit 1
  fi

  # Create output directory based on cue filename
  local base_name=$(basename "$cue_file" .cue)
  local output_dir="$HOME/Downloads/rip/$base_name"

  mkdir -p "$output_dir"
  echo "Created directory: $output_dir"

  echo "Splitting..."
  shnsplit -f "$cue_file" -o flac "$flac_file" -t "%n-%t" -d "$output_dir"

  echo "\n"

}

export -f process_cue

search_dir="${1:-.}"

# Find all files ending in .cue from within the search directory
# -print0 and -0 are used to handle filenames with spaces correctly
find "$search_dir" -type f -name "*.cue" -print0 | xargs -0 -I {} bash -c 'process_cue "$@"' _ {}
