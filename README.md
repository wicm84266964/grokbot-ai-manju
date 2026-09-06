# grokbot-ai-manju

**Grok Bot 全流程接管 AI 漫剧：文案 · 分镜 · 出图 · 本机生视频 · 成片拼接**

Grok Bot takes over the AI 漫剧 pipeline end-to-end. You chat in one place; the bot drives local **ComfyUI (MiniMax H3)** for video and **FFmpeg** for episode assembly.

> 面向搜索：AI漫剧 / Grok Bot / 全流程 / ComfyUI / 本地图生视频 / MiniMax H3

## Why this name
Most repos sell “ComfyUI nodes” or “又一短剧工作室”. This one sells **Grok Bot as the production desk** — full-pipeline takeover with local engines underneath.

## Architecture

```
You  →  Grok Bot (scripts / storyboards / images / commands)
              ↓
     grokbot-ai-manju (shot queue · ComfyUI API · FFmpeg)
              ↓
     Local ComfyUI :8188  →  clips  →  episode MP4
```

## What it is / isn’t
- **Is:** a thin conductor Grok Bot can operate on your PC
- **Isn’t:** a cloud video API wrapper, or a node-graph you must learn daily

## Layout
| Path | Role |
|------|------|
| `src/grokbot_ai_manju/` | Python package + CLI |
| `workflows/` | ComfyUI H3 workflow templates |
| `templates/` | episode / shot queue schemas |
| `shows/` | local show media (gitignored) |
| `docs/` | design + Grok Bot operating notes |

## Quick start (planned)
```bash
pip install -e .
manju init --show demo --episode 01
manju run --show demo --episode 01
manju stitch --show demo --episode 01
```

## Topics (GitHub)
`grok-bot` `ai-manju` `ai-drama` `comfyui` `minimax-h3` `ffmpeg` `local` `pipeline`

## License
MIT
