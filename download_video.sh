#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: ./download_video.sh <youtube_url>"
  exit 1
fi

yt-dlp -f "bv*+ba/b" -o "full_video.%(ext)s" "$1"

echo "✅ Download complete"
echo "If the file is not named full_video.mp4, rename it before cutting."
