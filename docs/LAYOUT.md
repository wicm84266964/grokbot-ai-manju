# 目录契约 LAYOUT（冻结）

目标：用户几乎不用整理文件。助手所有读写只落在约定路径；**成片只从 `epXX/export/` 取**。

## 仓库根（进 Git）

| 路径 | 用途 |
|------|------|
| `prompts/` | 复制给 Grok Bot 的提示词 |
| `skills/` | Skill 正文备份（与 Bot 双写） |
| `docs/LAYOUT.md` | 本文件 |
| `templates/` | 空模板 |
| `workflows/` | ComfyUI 工作流模板（无权重） |
| `src/` | 薄调度代码 |
| `shows/` | 剧集工作区（默认 gitignore） |

ComfyUI、模型、venv 装在仓库外。

## 单部剧 `shows/<show_id>/`（默认不进 Git）

```text
source/novel/           # 整本拆章
bible/                  # 系列圣经
characters/<char_id>/   # 人物+三视图+声线（全剧唯一）
plan/                   # episode_map 等
_shared/                # 可选公用片头尾/BGM
epXX/                   # 单集
  briefs/ script/ dialogue/ storyboard/
  prompts/ keyframes/ raw/ audio/
  export/               # 唯一成片出口
  qc.md ledger.yaml
```

## 输入落点

| 输入 | 落点 |
|------|------|
| 整本小说 | `source/novel/` |
| 角色参考图 | `characters/<id>/views/ref_portrait.png` |
| 角色试音 | `characters/<id>/voice/sample.wav` |
| 做第 N 集 | 只动 `epXX/` + 更新 `bible/continuity.md` |

## 输出落点

| 产物 | 落点 |
|------|------|
| 规划 | `bible/` `plan/` |
| 剧本分镜台词 | `epXX/script|storyboard|dialogue/` |
| 原始镜头 | `epXX/raw/` |
| **成片** | **`epXX/export/` only** |

## 反杂乱

1. 仓库根不堆临时媒体  
2. ComfyUI/output 用完即拷到 `raw/`  
3. 人物不按集复制  
4. 烟雾用 `shows/smoke/`，与正式剧隔离  
5. 废弃进 `_trash/` 或删除  

历史遗留：`shows/_cast/` 应迁入对应剧的 `characters/`，迁移后删除 `_cast`。


## 人物与声音文件规范

### 人物目录（每角色唯一）
shows/<show_id>/characters/<char_id>/
- profile.yaml
- iews/ref_portrait.png ront.png side.png ack.png
- sheets/turnaround.png
- oice/profile.yaml
- oice/sample.wav（可选）

### 声音落点
| 文件 | 位置 |
|------|------|
| 角色定妆声线描述 | characters/<id>/voice/profile.yaml |
| 角色试音/H3参考音 | characters/<id>/voice/sample.wav |
| 本集对白/BGM中间件 | pXX/audio/ |
| 成片 | pXX/export/ only |

模板：	emplates/character/

试验场：shows/sandbox/（韩立在 characters/han_li）
