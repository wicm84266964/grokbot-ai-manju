# grokbot-ai-manju

**Grok Bot 全流程接管 · AI 漫剧工厂**（MIT 开源）

用自然语言 + 整本小说，让 Grok Bot 在你的 Windows 本机完成：系列规划 → 人物三视图/声线 → 剧本分镜 → 关键帧 → 本机 ComfyUI 生视频（Wan 烟雾 / MiniMax H3 带声）→ FFmpeg 成片。你尽量只说话、丢文件、做审美否决。

> Keywords / Topics: `ai-manju` `ai-drama` `comfyui` `grok-bot` `minimax-h3` `wan21` `ffmpeg` `storyboard` `character-bible` `local-ai-video` `chinese-donghua` `open-source`

---

## 你能用它干什么

| 能力 | 说明 |
|------|------|
| 整本小说入库 | 建世界观/势力/地点/伏笔表 + 分集地图 `episode_map` |
| 按集生产 | 一集一集出：剧本、台词、分镜、关键帧、视频、成片 |
| 人物一致性 | `characters/<id>/` 三视图 + 声线档案；聊天丢参考图即可建卡 |
| 本机出片 | ComfyUI HTTP API（不必学节点）；H3 可参考音色直出带声视频 |
| 成片出口唯一 | 只看 `shows/<show>/epXX/export/` |
| 一键提示词 | 复制提示词 A 给 Grok Bot：装 Skill + 装依赖 |

适合：AI 从业者/创作者想做竖屏漫剧，但不想维护一堆散乱工程。

---

## 全链路（Skill `ai-manju-pipeline`）

1. **系列层**：整本小说 → `bible/` + `plan/episode_map.yaml`
2. **人物层**：参考图 → 三视图 + `voice/profile.yaml`（可选 `sample.wav`）
3. **单集层**：剧本 → 台词 → 分镜 → 关键帧 → 本机视频 →（H3 带声 / 字幕占位）→ FFmpeg
4. **质检/返工**：`qc.md`；可按 `shot_id` 只重渲一镜
5. **发行包装**：封面、标题条、简介、竖屏安全区

目录契约详见 [`docs/LAYOUT.md`](./docs/LAYOUT.md)。

---

## 5 分钟上手

1. 安装能控制本机的 **Grok Bot**
2. 克隆本仓库到本机（建议 `C:\saveproject\LBJ-workspace\grokbot-ai-manju`）
3. 复制 [`prompts/01-install-all.txt`](./prompts/01-install-all.txt)（提示词 A）整段发给 Grok Bot
4. 再丢**整本小说**或复制 [`prompts/02-first-episode.txt`](./prompts/02-first-episode.txt)

提示词索引：[`prompts/README.md`](./prompts/README.md)

---

## 架构

```
你 → Grok Bot（Skill 驱动）
       ↓
grokbot-ai-manju（目录契约 + 薄调度）
       ↓
本机 ComfyUI（Wan / H3）+ FFmpeg → shows/<show>/epXX/export/
```

引擎与模型装在仓库外（如旁路 `ComfyUI/`），权重不进 Git。

---

## 仓库里有什么 / 没有什么

**有：** README、`prompts/`、`skills/`、`docs/`、`templates/`、`workflows/` 模板、`src/` CLI 脚手架、MIT License

**默认没有（gitignore）：** `shows/` 剧集媒体、模型、venv、密钥

---

## License

[MIT](./LICENSE) — 开源，可商用、可修改，保留版权声明即可。

---

## 状态

本地烟雾：Wan 2.1 T2V 1.3B 一镜竖屏已跑通（API → webp → FFmpeg mp4）。正式 H3 带声链与调度 CLI 仍在增强中；Skill 已覆盖完整流程设计。
