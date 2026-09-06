# grokbot-ai-manju

**Grok Bot 全流程接管 AI 漫剧**  
文案 · 分镜 · 出图 · 本机生视频 · 成片拼接 —— 尽量只在一个 Grok Bot 窗口完成。

你不需要学会 ComfyUI 画节点，也不需要跟一长串命令行较劲。  
**把下面的提示词复制给 Grok Bot，让它在你的电脑上装好依赖、搭好项目。**

---

## 这是什么

面向想做 **AI 漫剧 / AI 短剧** 的创作者：

| 你在 Grok Bot 里做的事 | 本机自动跑的事 |
|---|---|
| 写故事、分镜、出关键帧图 | ComfyUI + MiniMax H3 生视频 |
| 下口令：「出第 3 镜」「合成这一集」 | FFmpeg 拼接成片、归档 |

开源仓库只放「调度层」；你的剧集素材放本机 `shows/`（默认不进 Git）。

---

## 小白上手（推荐只做这一步）

1. 安装并打开 **Grok Bot**（能操控你这台电脑的那个助手）。
2. 打开本仓库，复制下面整段提示词。
3. 粘贴发给 Grok Bot，等它说「装好了」。
4. 以后只在同一个窗口里继续下命令出片。

### 提示词 A · 一键安装本机依赖（复制整段）

```text
请按开源项目 grokbot-ai-manju 的约定，在我这台 Windows 电脑上完成 AI 漫剧本机环境安装。目标：我以后只在 Grok Bot 里下命令，不自己点 ComfyUI、不自己敲复杂命令。

请你直接操作我的电脑完成，并在关键步骤用中文简短汇报进度：

1) 确认工作区：若已有 C:\saveproject\LBJ-workspace\grokbot-ai-manju 就用它；否则按该路径克隆/创建项目。
2) 安装或检测 FFmpeg，并保证终端里能运行 ffmpeg -version。
3) 安装或检测 ComfyUI（优先官方/常用 Windows 方式），监听 http://127.0.0.1:8188；装好后能用 HTTP API 访问。
4) 准备 MiniMax H3 所需模型与工作流目录（按项目 docs / workflows 说明）；若下载很大，先给出体积与磁盘要求，再开始下。
5) 在项目里创建 Python 虚拟环境并 pip install -e .
6) 写一份本机就绪检查：ComfyUI 是否可访问、ffmpeg 是否可用、项目 CLI 是否可用。
7) 不要让我学习节点连线；需要我登录/确认下载的地方，用一句话清楚告诉我点哪里。

完成后用三句话告诉我：怎么启动 ComfyUI、怎么在 Grok Bot 里下第一条出片命令、素材放哪个文件夹。
```

### 提示词 B · 从零做第一集（复制整段）

```text
我已经装好 grokbot-ai-manju 本机环境。请你作为制作中枢，带我用最少操作做出第一集样片：

1) 在 shows/ 下建一个演示剧集目录和分镜队列。
2) 我负责在对话里定故事和关键帧图（需要出图时你直接生成或告诉我贴哪）。
3) 你负责把镜头提交给本机 ComfyUI（H3），再用 FFmpeg 拼成一集。
4) 全程用中文短句同步进度；除非必须，不要让我打开 ComfyUI 界面。
```

更多可复制提示词见 [`prompts/`](./prompts/)。

---

## 架构（给想了解的人）

```
你  →  Grok Bot（一个窗口：文案 / 图 / 调度口令）
            ↓
   grokbot-ai-manju（镜头队列 · ComfyUI API · FFmpeg）
            ↓
   本机 ComfyUI :8188 → 分镜 MP4 → 成片 MP4
```

---

## 仓库结构

| 路径 | 用途 |
|------|------|
| `prompts/` | 给 Grok Bot 的可复制提示词（安装 / 出片 / 排障） |
| `src/grokbot_ai_manju/` | 调度代码与 CLI |
| `workflows/` | ComfyUI 工作流模板 |
| `templates/` | 分集 YAML 示例 |
| `shows/` | 本机剧集（gitignore） |
| `docs/` | 设计说明 |

---

## 给开发者（可跳过）

```bash
cd grokbot-ai-manju
python -m venv .venv
.venv\Scripts\activate
pip install -e .
manju --help
```

本机需：Windows、较充足显存（推荐 24GB 级）、已运行的 ComfyUI、PATH 中的 FFmpeg。

---

## License

MIT
