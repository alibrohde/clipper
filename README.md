Clipper

A small, deterministic tool for cutting video clips from long-form video using timestamps.

You provide the editorial decisions. Clipper handles the mechanics.

--------------------------------------------------

What this tool does

- Takes a long video file
- Reads a list of clip timestamps from clips.json
- Produces clean, reproducible video clips automatically

--------------------------------------------------

What this tool does NOT do

- Decide which moments are interesting
- Analyze transcripts
- Call an LLM
- Perform editorial judgment

This separation is intentional.

--------------------------------------------------

Requirements

- macOS or Linux
- Homebrew (macOS)
- ffmpeg
- jq

Optional (for YouTube downloads):
- yt-dlp

Install dependencies:

brew install ffmpeg jq yt-dlp

--------------------------------------------------

Usage

Step 1: Provide a source video

This tool operates on a single source video named full_video.mp4.

Option A (recommended): You already have a video file

Place your video in the project root and name it:

full_video.mp4

Option B: Download from YouTube

Use the helper script:

./download_video.sh "https://www.youtube.com/watch?v=VIDEO_ID"

If the downloaded file is not named full_video.mp4, rename it:

mv full_video.* full_video.mp4

--------------------------------------------------

Step 2: Create clips.json

Edit clips.json and specify the clips you want to extract.

Times are in seconds.

Example:

{
  "clips": [
    {
      "clip_title": "Example Clip",
      "start_time": 100,
      "end_time": 180
    }
  ]
}

--------------------------------------------------

Step 3: Cut the clips

Run:

./cut_clips.sh

Clips will be written to the output/ directory.

--------------------------------------------------

Notes

- You can delete all generated clips and rerun the script at any time.
- Editing clips.json and rerunning will regenerate clips.
- This repo is designed to be extended later with AI or transcript tooling, but v1 is intentionally simple and deterministic.

--------------------------------------------------

License

MIT
