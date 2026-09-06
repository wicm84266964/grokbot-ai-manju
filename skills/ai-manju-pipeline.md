---
name: ai-manju-pipeline
description: >-
  Use for AI manhua/drama with frozen I/O folder contract under
  shows/<show_id>/; full-novel-first series bible + episode production; local
  ComfyUI/H3/FFmpeg; dual-write skill to repo.
---
# AI漫剧生产流水线（零额外视频 API）

目标：整本小说 → 系列圣经 → 分集规划 → 单集生产 → 质检返工 → 发行包装。用户少碰文件；**所有读写必须落在下方唯一目录契约内**，禁止在仓库根或桌面散落中间文件。

**交互：先引导，再接指令。**

## 唯一目录契约（冻结）

### 仓库根（进 Git，给小白复制）
```text
grokbot-ai-manju/
  README.md
  prompts/                 # 仅提示词文本
  skills/                  # Skill 正文备份（与 Bot 双写）
  docs/LAYOUT.md           # 本契约说明
  templates/               # 空模板（bible/episode/character）
  workflows/               # ComfyUI 工作流模板（无权重）
  src/                     # 薄调度代码
  shows/                   # 默认 gitignore：剧集工作区
```

### 单部剧工作区（不进 Git / 用户可整个删档重来）
```text
shows/<show_id>/
  source/novel/            # 整本拆章：ch001.md ...
  bible/
    series.yaml            # 画幅、时长预算、平台、尺度
    world.md
    factions.md
    locations.md
    continuity.md
    glossary.md
  characters/<char_id>/
    profile.yaml
    views/{ref_portrait,front,side,back}.png
    sheets/turnaround.png
    voice/{profile.yaml,sample.wav?}
  plan/
    season_outline.md
    episode_map.yaml       # ep ↔ 章节范围 ↔ 秒数/镜数上限
  _shared/                 # 可选：公用 BGM、片头尾素材
  epXX/
    briefs/
    script/
    dialogue/
    storyboard/
    prompts/               # 本集 API JSON / 提示词
    keyframes/
    raw/                   # 引擎原始镜头
    audio/                 # 本集对白/BGM 中间件
    export/                # 唯一给用户看的成片出口
    qc.md
    ledger.yaml
```

### 输入 → 落点（强制）
| 用户输入 | 落点 |
|---|---|
| 整本小说文件 | `source/novel/`（助手拆章） |
| 角色参考图 | `characters/<id>/views/ref_portrait.png` |
| 角色试音 | `characters/<id>/voice/sample.wav` |
| 「做第 N 集」 | 只读写 `epXX/` + 更新 `bible/continuity.md` |

### 输出 → 落点（强制）
| 产物 | 落点 |
|---|---|
| 系列规划 | `bible/` + `plan/` |
| 分镜/剧本/台词 | `epXX/{storyboard,script,dialogue}/` |
| 关键帧 | `epXX/keyframes/` |
| 原始视频 | `epXX/raw/` |
| **成片（用户要找的）** | **仅** `epXX/export/` |
| 质检 | `epXX/qc.md` |

### 反杂乱规则
1. 仓库根禁止新增临时 png/mp4/json（除文档与代码）。
2. ComfyUI 输出必须立刻拷到 `epXX/raw/`，不让用户去 ComfyUI/output 翻找。
3. 同一角色全剧只用一个 `char_id` 目录；禁止每集复制人物树。
4. 废弃文件进 `epXX/_trash/` 或直接删，不留 `final_final_v3`。
5. 烟雾测试用 `shows/smoke/`，与正式剧隔离。
6. 引擎/模型装在仓库外（如 `../ComfyUI`），本仓库只保存路径配置。

## 标准输入
首选整本小说 → 圣经 + episode_map → 按集拍。单章仅烟雾/补拍。聊天丢参考图 → 更新 characters。

## 声音
H3：参考音色+三视图直出带声；无样本可用默认声线描述。Wan 烟雾：字幕或后置 TTS。

## 单集阶段
0 episode_map 切片 → 0.5 新角色/地点 → 1 剧本 → 1.5 台词 → 2 分镜 → 3 关键帧 → 4 视频 → 4.5 声音 → 5 FFmpeg → 6 质检 → 7 返工（按 shot_id）→ 8 发行包装到 export/

## 多集连续
开集读 continuity + 上集 qc；变更写回 bible。

## 仓库自举
`prompts/01-install-all.txt`：装 Skill + 依赖。

## 约束
零额外付费 API；本机 ComfyUI；FFmpeg；NO_PROXY 本机；多卡避让；暂停下载立刻停。

## 检查清单
全书与 episode_map；bible/characters；本集引用 id；export 唯一成片；qc/ledger；continuity 写回；无根目录垃圾文件。
