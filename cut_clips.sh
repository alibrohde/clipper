#!/usr/bin/env bash
set -euo pipefail

VIDEO_FILE="full_video.mp4"
CLIPS_FILE="clips.json"
OUTPUT_DIR="output"

if [[ ! -f "$VIDEO_FILE" ]]; then
  echo "❌ Missing $VIDEO_FILE"
  echo "Place your video in the repo root and name it full_video.mp4"
  exit 1
fi

if [[ ! -f "$CLIPS_FILE" ]]; then
  echo "❌ Missing $CLIPS_FILE"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Validate JSON
jq . "$CLIPS_FILE" >/dev/null

echo "🎬 Cutting clips..."

jq -c '.clips[]' "$CLIPS_FILE" | while read -r clip; do
  title=$(echo "$clip" | jq -r '.clip_title')
  start=$(echo "$clip" | jq -r '.start_time')
  end=$(echo "$clip" | jq -r '.end_time')

  duration=$((end - start))
  safe_title=$(echo "$title" | tr ' ' '_' | tr -cd '[:alnum:]_')

  ffmpeg -y \
    -ss "$start" \
    -i "$VIDEO_FILE" \
    -t "$duration" \
    -c:v libx264 \
    -c:a aac \
    -movflags +faststart \
    "$OUTPUT_DIR/${safe_title}.mp4"

done

echo "✅ Done. Clips written to $OUTPUT_DIR/"
