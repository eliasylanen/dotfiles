#!/bin/bash

set -eo pipefail

FILE="$1";

if [ -z "$FILE" ]; then
	echo "Missing target file";
	echo "Usage: $0 <file> <author>"
	exit 1
fi

AUTHOR="$2";

if [ -z "$AUTHOR" ]; then
	echo "Missing author";
	echo "Usage: $0 <file> <author>"
	exit 1
fi

EXTENSION=$(echo "$FILE" | rev | cut -d '.' -f 1 | rev)

ARTIST=$(ffprobe -loglevel error -show_entries format_tags=album_artist -of default=noprint_wrappers=1:nokey=1 "$FILE");
DATE=$(ffprobe -loglevel error -show_entries format_tags=date -of default=noprint_wrappers=1:nokey=1 "$FILE");
ALBUM=$(ffprobe -loglevel error -show_entries format_tags=album -of default=noprint_wrappers=1:nokey=1 "$FILE");
TITLE=$(ffprobe -loglevel error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$FILE");

YEAR=$(echo "$DATE" | cut -d '-' -f 1)

FORMAT="$ARTIST - ($YEAR) $ALBUM - $TITLE";
DESTINATION="/mnt/moekki/bangerforce/$AUTHOR";
SAVEPATH="$DESTINATION/$FORMAT.$EXTENSION";

echo "Copying to $SAVEPATH";
mkdir -p "$DESTINATION";
cp "$FILE" "$SAVEPATH.untagged";

ffmpeg -loglevel error -i "$SAVEPATH.untagged" -c copy -metadata REQUESTED_BY="$AUTHOR" "$SAVEPATH"

chmod +x "$SAVEPATH";

rm "$SAVEPATH.untagged";
