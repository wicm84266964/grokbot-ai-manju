# Changelog

本项目版本记录遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/)，版本号遵循 [SemVer](https://semver.org/lang/zh-CN/)。

## [0.0.1] - 2026-09-06

### 新增
- MIT 开源脚手架：README、LICENSE、prompts/、skills/、docs/LAYOUT.md、人物模板
- Skill ai-manju-pipeline：整本小说优先 → 系列圣经 + episode_map → 按集生产；含质检/返工/发行包装约定
- 冻结 I/O 目录契约：成片只从 shows/<show>/epXX/export/ 出口
- 本机辅助脚本：scripts/check_wan.ps1、scripts/wait_wan_dl.ps1
- 本地烟雾链路验证：ComfyUI HTTP API + Wan 2.1 T2V 1.3B → FFmpeg mp4

### 约定
- 外部开源引擎落在工作区 _external/ComfyUI
- 本机 tools/（ffmpeg/wheels）留在仓库内但 gitignore，不进 Git
- 零额外付费视频/语音 API；优先本机双卡 ComfyUI

### 已知限制
- MiniMax H3 带声 reference-to-video 与正式调度 CLI 尚未合入本版本
- 口型与台词节奏仍为浅层约定
- shows/ 媒体默认不发布到 Git

[0.0.1]: https://github.com/wicm84266964/grokbot-ai-manju/releases/tag/v0.0.1
