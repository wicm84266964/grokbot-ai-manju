# manju-conductor

Grok Bot ↔ local ComfyUI (MiniMax H3) ↔ FFmpeg conductor for AI 漫剧 production.

**Local engines:** ComfyUI (video) + FFmpeg (stitch / export).  
**Brain:** Grok Bot (scripts, storyboards, images, job scheduling).  
**Goal:** cut handoff cost — you command the bot; the bot drives your PC.

> Status: scaffolding. Core CLI + API client under active build.

## Architecture

```
Grok Bot (chat)
    │  commands / shot queue
    ▼
manju-conductor (this repo)
    ├── project/     episode · shot · asset ledger
    ├── comfyui/     submit / poll / download via HTTP API
    └── ffmpeg/      concat · trim · normalize · burn-in
    ▼
ComfyUI :8188  →  clip MP4s  →  episode MP4
```

## Repo layout

| Path | Role |
|------|------|
| `src/manju_conductor/` | Python package (CLI + library) |
| `workflows/` | ComfyUI workflow JSON templates (H3 I2V / Ref2VA) |
| `templates/` | shot queue · episode YAML schemas |
| `shows/` | **local only** — per-show assets (gitignored) |
| `scripts/` | setup helpers for Windows dual-GPU boxes |
| `docs/` | design notes · Grok Bot skill recipe |

## Quick start (planned)

```bash
# 1) ComfyUI + MiniMax H3 running on http://127.0.0.1:8188
# 2) ffmpeg on PATH
pip install -e .
manju init --show demo --episode 01
manju enqueue --show demo --episode 01 --shot 001 --image path\to\keyframe.png
manju run --show demo --episode 01
manju stitch --show demo --episode 01
```

## License

MIT — see `LICENSE`.

## Note on shows/

`shows/` holds production media and is gitignored. Keep the open-source repo thin; keep your episodes local.
