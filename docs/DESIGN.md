# manju-conductor design (v0)

## Principles
1. ComfyUI is a headless engine (HTTP API). Operators should not need the node graph daily.
2. FFmpeg is the default finisher (concat / trim / normalize). CapCut drafts are optional later.
3. Grok Bot is the UX: chat commands map to CLI / library calls on the user PC.
4. Open-source core stays generic; personal show data stays in gitignored `shows/`.

## Shot queue schema (YAML)
See `templates/episode.example.yaml`.

## ComfyUI
- Default base URL: http://127.0.0.1:8188
- Workflow templates live in `workflows/` (API-format JSON)
- Dual GPU: start with one card; optional second-card text-encoder offload later

## FFmpeg
- Prefer stream copy when codecs match; re-encode only when normalizing
- Emit `list.txt` then `ffmpeg -f concat -safe 0 -i list.txt -c copy out.mp4`
