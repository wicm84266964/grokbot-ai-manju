# Design — grokbot-ai-manju

## Positioning
**Grok Bot 全流程接管** AI 漫剧。README 以「复制提示词给 Grok Bot」为主路径；命令行文档仅给开发者。

## Beginner UX
- Humans should not learn ComfyUI graphs or long shell recipes.
- Install / first episode / troubleshoot = copy-paste prompts in `prompts/`.
- Grok Bot operates the user PC (ComfyUI API + FFmpeg + project files).

## Engines
- ComfyUI HTTP API — MiniMax H3 video
- FFmpeg — stitch / normalize / export
