---
name: writing-structured-todos
description: Use this skill whenever the user asks to write, add, update, append, or restructure an entry in a project's running TODO file (typically `.llm/todo.md` or similar). Triggers on phrases like "写 todo", "加 todo", "更新 todo", "todo 里面加一条", "写 todo.md", "append to todo", "write a todo entry", "add this to the todo", "plan this in todo", "记一下这个任务". Also use when the user describes a future task, research direction, bug fix, or architectural decision and wants it persisted as a plan item rather than executed immediately. Do NOT use for checkbox-style `TodoWrite`/`TaskCreate` tool tracking — those are for in-session task state; this skill is for persistent, context-rich plan documents that survive across sessions.
---

# Writing Structured TODOs

## Overview

This skill captures a specific, battle-tested style for writing long-form project TODO entries in `.llm/todo.md` files. The style treats each entry as a **mini design doc** — background, goal, concrete steps with real file paths and commands, honest cost estimates, verification steps, and cited evidence — not as a one-line reminder. The format has been iterated on across multi-month projects where the TODO file is the single source of truth that bridges sessions.

## When to Use

Use this skill when:
- The user says "write/add/update/append a todo" (in Chinese or English)
- The user describes a direction, idea, or problem and asks to persist it ("记一下", "plan this", "write it down")
- The user wants the existing `.llm/todo.md` restructured or a stale entry updated
- After completing a major piece of work, the user wants a "status" section added to the corresponding TODO entry
- Starting a new research direction that needs a living document to track discoveries

Do NOT use for:
- Short-lived, in-session task tracking (use `TaskCreate` / `TodoWrite` for that)
- Checkbox todo lists (`- [ ]` format) — those belong in the `markdown-tasks` skill
- Writing commit messages or PR descriptions
- Writing user-facing documentation or README files

## The Core Rule

**Every entry is a mini design doc, not a reminder.** If a todo entry could have been written in one line, it doesn't belong in `.llm/todo.md` — it belongs in the task tracker. Entries in this file must carry enough context that a new Claude instance (or the user two weeks from now) can pick up the work without re-asking questions.

## Workflow

1. **Read first**: Before writing or appending, read the existing `.llm/todo.md` (or project equivalent). Understand the existing section numbering, priority markers, and any "状态 YYYY-MM-DD" date stamps. New entries must match the file's existing cadence.
2. **Find the right insertion point**: New P0 items go near the top. Status updates on existing entries go inline with a `### 状态 YYYY-MM-DD` subheader. Completed work moves under an `### 已完成` subsection of its parent entry — don't delete it.
3. **Draft the entry offline** (in your head or scratch): think through background → goal → steps → verification → cost before writing a single line into the file.
4. **Write with the anatomy below.**
5. **Convert any relative dates to absolute**: "今天" → `2026-04-09`, "下周" → `2026-04-16`. The file outlives the conversation.
6. **Match the file's language**: If the existing file mixes Chinese and English technical terms (very common), do the same. Don't translate existing terms into English just because you're writing a new entry.

## Section Header Grammar

Entries use a strict `## <emoji> <priority> · <title>` grammar. The emoji categorizes the entry type; the priority marker sets urgency; the `·` separator is always a middle-dot (U+00B7), never a hyphen or colon.

| Emoji | Meaning | Example |
|---|---|---|
| 🔥 | P0 — top priority, blocking, doing now | `## 🔥 P0 · 稳定可播放 URL` |
| 📇 | P0 — specific feature/data source | `## 📇 P0 · 通过视频号名片抓取整个 profile` |
| 🔒 | P0 — filtering, security, correctness gate | `## 🔒 P0 · 只处理用户聊天收到的视频` |
| 🎯 | Current focus / incremental targets | `## 🎯 当前分支下的增量需求` |
| 🌿 | New branch / new exploration direction | `## 🌿 新会话 · 新分支：CDN 直链研究` |
| 🧭 | Roadmap / high-level navigation | `## 🧭 Roadmap (high-level)` |
| 🦀 | Strategic / tech stack decision | `## 🦀 后续技术栈决定：切 Rust` |
| ✅ | Completed (historical, kept for reference) | `## ✅ 已完成 · Phase 1 keystream hook` |

Optional status suffix: `— 状态 2026-04-09 晚` on entries that are actively in flight. Remove the suffix once the entry is fully done and move it under an `### 已完成` subsection.

## Entry Anatomy

Every non-trivial entry has this skeleton. Short trivial entries can skip some sections, but complex/multi-day entries must hit every one.

```markdown
## <emoji> <priority> · <title> — 状态 YYYY-MM-DD <morning|晚|夜>

**背景**: 1-3 sentences explaining what the user/project hit that made
this a todo. Cite prior context: "用户 2026-04-09 澄清", "从 mem dump
A/B 对比", "继承自 Phase 2 的 decoder 限制".

**目标**: 1-2 sentences stating the concrete outcome. Not "improve X"
but "返回 X-encflag=0 明文 mp4 而不是 X-encflag=1 加密首 128KB".

### 已确认约束 / 已知事实

Bulleted list of things that have been measured or verified, with
concrete values. e.g.:
- 咖姐 profile 显示 504 条原创内容
- DOM 初始只渲染 ~45 个 `.object-card`
- iOS token 有效期 20+ 小时

### 关键发现 (optional, for research entries)

Numbered list of non-obvious findings from static/dynamic probing,
each with the exact binary offset, file path, or command that
produced the evidence.

### 实现路径 / 剩余工作

Numbered list (1. 2. 3.), not bullet list. Each step should be
small enough that a fresh agent can pick it up without context. Use
absolute file paths (`D:/workspace/finder-catch/capture_profile.py`)
and, where relevant, include a code block showing the exact
signature or selector.

### 用法 (if the entry is about a tool)

Literal bash/powershell commands the user can paste:

```bash
python capture_profile.py --username "v2_..." --limit 10
```

### 验证

Copy-pasteable verification commands with expected output. e.g.:

```bash
sqlite3 finder_catch.db "SELECT count(*) FROM captures WHERE status='done';"
# expected: ≥ 1 after a successful run
```

### 风险 / 注意 / 成本 vs 收益

Brutal honesty about cost and risk. Use tables for tradeoffs with
3+ dimensions. Quote concrete numbers: "4-8 小时全量抓", "12 GB
OSS", "每次更新可能动 protobuf schema", "WXWork 2-4 周版本 TTL".

### 临时替代方案 (optional)

If there's a working workaround while the "real" fix is being
built, document it here with a one-liner command.
```

## Writing Rules

1. **Concrete numbers, always.** Never write "fast" — write "35 秒". Never write "a lot of memory" — write "66 GB". Never write "soon" — write "2-4 周" or an absolute date.
2. **Absolute file paths.** `D:/workspace/finder-catch/capture_profile.py`, not `capture_profile.py` and not `the profile capture script`.
3. **Cite evidence.** When stating a fact, say where it came from: "参见 chatmsg_windows/*.bin 的 8KB 窗口", "从 mem dump A/B 对比得出", "iOS 样本 request.txt 里的 token".
4. **Bold key phrases, not whole sentences.** `**唯一变量是 token**`, `**不**下载视频`, `**没有** eid 属性`. Bold is for the one phrase you want the reader to pause on.
5. **Tables for 3+ dimensions.** If you're comparing approaches across 2 columns it's a bullet list; across 3+ columns (like `tool | cost | benefit | risk`), it's a table.
6. **Tag code blocks.** `` ```python ``, `` ```bash ``, `` ```sql ``, `` ```proto `` — never untagged `` ``` ``.
7. **Mark in-flight work.** Use `— 状态 YYYY-MM-DD` on the heading, or an inline `### 状态 YYYY-MM-DD <what changed>` subsection. When the entry is fully done, move it under an `### 已完成` subsection rather than deleting it — the history is valuable.
8. **Keep Chinese/English mixed if the file already does.** Don't translate.
9. **No "I'll implement this now" narration.** The todo file is a plan, not a journal. Narration like "I'll go ahead and start by..." belongs in chat, not in the file.
10. **No checkbox lists.** `- [ ] scrape comments` is a code smell — if it belongs in a checkbox, it doesn't belong in this file. Use numbered steps under `### 实现路径`.

## Examples

Four production-quality entries covering different categories live in `references/example_entries.md`. **Read that file before writing a new entry if it exists** — it shows the exact cadence and depth to match.

**⚠️ 如果 `references/example_entries.md` 不存在，使用下方内联示例作为正面范例：**

```markdown
## 🔥 P0 · 评论解析器重写 — 状态 2026-04-10 晚

**背景**: 用户 2026-04-09 反馈评论抓取返回空列表。排查发现 DOM 结构
在 2026-04-08 版本更新后变化，`.comment-item` 选择器失效。

**目标**: 恢复评论抓取功能，输出包含 `author / text / timestamp / likes`
四字段的结构化 JSON，覆盖 ≥95% 的评论格式。

### 已确认约束 / 已知事实
- 新 DOM 用 `[data-comment-id]` 属性标识评论节点
- 嵌套回复最多 3 层，用 `.reply-container` 包裹
- 每页默认加载 20 条，需滚动触发懒加载

### 实现路径 / 剩余工作
1. 修改 `D:/workspace/finder-catch/parsers/comment_parser.py:L45`
   选择器从 `.comment-item` 改为 `[data-comment-id]`
2. 新增嵌套回复提取逻辑，递归解析 `.reply-container`
3. 添加滚动加载等待：`await page.wait_for_selector('[data-comment-id]', timeout=5000)`

### 验证
```bash
python -m pytest tests/test_comment_parser.py -v
# expected: 3 passed, 0 failed
```

### 风险 / 成本 vs 收益
| 维度 | 值 |
|------|-----|
| 工时 | 2-3 小时 |
| 风险 | DOM 可能再次变化，建议加选择器版本检测 |
| 收益 | 恢复核心功能，解除用户阻塞 |
```

## Anti-Patterns

From the non-example section of `references/example_entries.md`:

**Too vague** — no cost, no code, no refs:
```markdown
## TODO: comments
We should probably scrape comments at some point. Might be tricky
because of the DOM. Look into it.
```

**Wrong format** — checkbox list belongs in `markdown-tasks`:
```markdown
## TODO
- [ ] scrape comments
- [ ] add LLM integration
```

**Mixing narration with plan**:
```markdown
## 🔥 P0 · 评论抓取
I'll go ahead and implement this now by first clicking the comment
button and then...
```

If tempted to write one of these, stop and re-read the anatomy section above.

## Updating Existing Entries (not just appending new ones)

When the user says "update the X entry" or asks you to add status to existing work:

1. **Find the target entry** — grep `.llm/todo.md` for the section header or a distinctive phrase
2. **Decide: status update or restructure?**
   - Status update: add a `### 状态 YYYY-MM-DD` subsection under the entry with what changed, what was verified, what's still blocking
   - Restructure: the entry has drifted from reality — rewrite the 目标, update the 已知事实 with new measurements, keep the 背景 unchanged (it's history)
3. **Move completed work into `### 已完成`** within the entry, don't delete it. Future agents need to know the failed paths as much as the working ones.
4. **Bump the status date** on the entry heading itself (`— 状态 2026-04-09` → `— 状态 2026-04-15`) to signal the entry was touched.

## After Writing

After writing or updating a `.llm/todo.md` entry:

1. **Do not commit** unless the user explicitly asks. Leave the file dirty so the user can review with `git diff .llm/todo.md`.
2. **Report the section header you wrote** back to the user in one line so they can search for it. e.g. "Added `## 🔥 P0 · 新评论解析器 — 状态 2026-04-09`".
3. **Do not summarize the entry content** — the user will read it. Summarizing the very thing you just wrote is noise.

## References

- `references/example_entries.md` — 4 full real-world entries copied verbatim from a production `.llm/todo.md`, with per-example "key things to notice" callouts. Read this before writing a new entry.
