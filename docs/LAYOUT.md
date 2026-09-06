# 目录契约 LAYOUT（冻结）

目标：用户少摸中间文件。所有读写只落在契约路径；**成片只从 epXX/export/ 取**。

## 硬规则（防散落）

1. **禁止**在 LBJ-workspace/ 根目录、桌面、用户主目录落地本项目临时文件。
2. 引擎原始输出（如 ComfyUI/output）拷完立刻进 shows/<show>/epXX/raw/。
3. 本机工具二进制放 tools/（gitignore），不进 Git。
4. ComfyUI / 模型权重装在仓库外旁路目录（如 ../ComfyUI）。
5. 一次性下载/轮询日志放 shows/<show>/epXX/raw/ops/（已 gitignore）。

## 仓库根（进 Git）

| 路径 | 用途 |
|------|------|
| prompts/ | 复制给 Grok Bot 的提示词 |
| skills/ | Skill 正文备份（与 Bot 双写） |
| docs/LAYOUT.md | 本文件 |
| templates/ | 空模板 |
| workflows/ | ComfyUI 工作流模板（无权重） |
| scripts/ | 本机辅助脚本（下载检查等） |
| src/ | 薄调度代码 |
| shows/ | 剧集工作区（默认 gitignore） |
| tools/ | 本机 ffmpeg / wheels（不进 Git） |

## 剧工作区 shows/<show_id>/（默认不进 Git）

`	ext
source/novel/           # 整本拆章
bible/                  # 系列圣经
characters/<char_id>/   # 人设+三视图+声线（全剧唯一）
plan/                   # episode_map 等
_shared/                # 可选：公用片头尾/BGM
epXX/                   # 单集
  briefs/ script/ dialogue/ storyboard/
  prompts/ keyframes/ raw/ audio/
  raw/ops/              # 一次性 API/下载日志（可选）
  export/               # 唯一成片出口
  qc.md ledger.yaml
`

## 输入落点

| 输入 | 落点 |
|------|------|
| 整本小说 | source/novel/ |
| 角色参考图 | characters/<id>/views/ref_portrait.png |
| 角色试音 | characters/<id>/voice/sample.wav |
| 做第 N 集 | 只写 epXX/ + 更新 bible/continuity.md |

## 输出落点

| 产物 | 落点 |
|------|------|
| 规划 | bible/ plan/ |
| 剧本分镜台词 | epXX/script|storyboard|dialogue/ |
| 原始镜头 | epXX/raw/ |
| **成片** | **epXX/export/ only** |

## 禁令补充

1. 仓库根不放临时媒体
2. 不在工作区根写 smoke_*.json / wait_*.log / check_*.ps1
3. 人物不放仓库根；sandbox 用 shows/sandbox/
4. 废片进 _trash/ 或删除

模板：templates/character/
