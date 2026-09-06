# grokbot-ai-manju

**Grok Bot full-pipeline takeover · AI manju / short-drama factory** (MIT)

[English](./README.md) | [中文](./README.zh-CN.md)

Build vertical AI manju with natural language and a full novel. Grok Bot drives your Windows PC through series planning → character three-views / voice → script & storyboard → keyframes → local ComfyUI video (Wan smoke / MiniMax H3 with audio) → FFmpeg export. You mostly talk, drop files, and veto aesthetics.

> Keywords / Topics: `ai-manju` `ai-drama` `comfyui` `grok-bot` `minimax-h3` `wan21` `ffmpeg` `storyboard` `character-bible` `local-ai-video` `chinese-donghua` `open-source`

**Current release:** [v0.0.1](https://github.com/wicm84266964/grokbot-ai-manju/releases/tag/v0.0.1)

---

## What you get

| Capability | Detail |
|------|------|
| Full-novel intake | World / factions / locations / continuity + `episode_map` |
| Episode production | Script, dialogue, storyboard, keyframes, video, final cut |
| Character consistency | `characters/<id>/` three-views + voice profile; chat-drop refs to create cards |
| Local render | ComfyUI HTTP API (no node UI required); H3 can emit video with reference timbre |
| Single export path | Only look at `shows/<show>/epXX/export/` |
| One-shot prompts | Copy prompt A to Grok Bot: install Skill + deps |

Built for AI practitioners / creators who want vertical manju without a pile of scattered project folders.

---

## Full pipeline (Skill `ai-manju-pipeline`)

1. **Series:** full novel → `bible/` + `plan/episode_map.yaml`
2. **Characters:** refs → three-views + `voice/profile.yaml` (optional `sample.wav`)
3. **Episode:** script → dialogue → storyboard → keyframes → local video → (H3 audio / subtitle placeholder) → FFmpeg
4. **QC / rework:** `qc.md`; re-render one shot by `shot_id`
5. **Release pack:** cover, title bar, blurb, vertical safe area

Folder contract: [docs/LAYOUT.md](./docs/LAYOUT.md).

---

## 5-minute start

1. Install **Grok Bot** with local PC control
2. Clone this repo into your workspace project folder
3. Paste [prompts/01-install-all.txt](./prompts/01-install-all.txt) (prompt A) to Grok Bot
4. Drop a **full novel**, or paste [prompts/02-first-episode.txt](./prompts/02-first-episode.txt)

Prompt index: [prompts/README.md](./prompts/README.md)

---

## Architecture

```
You → Grok Bot (Skill-driven)
         ↓
grokbot-ai-manju (folder contract + thin scheduler)
         ↓
Local ComfyUI (Wan / H3) + FFmpeg → shows/<show>/epXX/export/
```

- Third-party engine lives under workspace `_external/ComfyUI` (not in this repo)
- Local ffmpeg / wheels live under repo `tools/` (gitignored)
- Model weights stay out of Git

---

## In repo / not in repo

**Included:** README (EN/ZH), `CHANGELOG.md`, `prompts/`, `skills/`, `docs/`, `templates/`, `workflows/` templates, `scripts/`, `src/` CLI scaffold, MIT License

**Gitignored by default:** `shows/` episode media, `tools/` binaries, models, venv, secrets

---

## License

[MIT](./LICENSE) — free to use commercially and modify; keep the copyright notice.

---

## Status (v0.0.1)

- Open-source scaffold and I/O contract frozen
- Skill `ai-manju-pipeline`: full-novel-first + QC / rework / release design
- Local smoke: Wan 2.1 T2V 1.3B vertical one-shot path verified (API → webp → FFmpeg mp4)
- Native H3 audio path and production scheduler CLI still in progress
