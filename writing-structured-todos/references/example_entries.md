# Example TODO entries

Real examples copied verbatim from a production `.llm/todo.md`.
Reference these for formatting, tone, and section depth when
writing new entries.

---

## Example 1: P0 entry with code-heavy steps

```markdown
## 🔥 P0 · 稳定可播放 URL（两个方向并行）

用户刚提出：需要两种可播放 URL 同时存在，都是第一优先级。

### P0-1: l2t `/stream/<key>` 代理 endpoint（短期，1-2 天）

**目标**：一个永远有效的稳定 URL，点开就 302 到新鲜签名的 OSS URL。
OSS 里躺的是解密后的 mp4，直接能播。每次点击 = 新 24h 签名，文档
不会因为 24h 过期而失效。

`‌``
https://hot.redfiai.com/api/v1/l2t/stream/62535648188d4495bcd2061dc0376398.mp4
  ↓ GET (server looks up key, re-signs)
  ↓ 302 Location: https://pmoss.xincaitong.com/redfi/upload/...?sec=<fresh_24h_sig>
  ↓ client follows redirect
  ↓ plays
`‌``

**Server 改动** (`D:/workspace/l2t`):
1. 新文件 `l2t/service/api/stream.py` 或加到现有 api/jobs.py：
   `‌``python
   @router.get('/stream/{oss_key:path}')
   def stream(oss_key: str):
       if not _is_known_oss_key(oss_key):
           raise HTTPException(404)
       from l2t.oss import generate_signed_url
       fresh = generate_signed_url(oss_key, expires=86400)
       return RedirectResponse(fresh, status_code=302)
   `‌``
2. 不需要新表 / migration — `transcript_results.oss_key` 已经是
   stable reference。
3. Router 挂到 `/api/v1/l2t/stream/<oss_key>`.

**Client 改动** (`finder-catch`):
1. `l2t_pipeline.upload()` 返回的 dict 增加 `stable_url` 字段
2. `finder_auto._l2t()` 把 stable_url 加到 `extra_urls`
3. `db.py captures` 表：新 nullable 列 `stable_url`

**验证**：
- `curl -I https://hot.redfiai.com/api/v1/l2t/stream/<key>` 应返回 302 + Location
- 打开返回的 Location，MP4 头部应是 `00000020 66747970` ftyp magic
```

Key things to notice:
- Starts with `## 🔥 P0 ·` marker (top priority)
- Bold **目标** opening line
- Uses a diagram to show the request flow
- Code blocks tagged `python`
- Explicit file paths `D:/workspace/l2t/l2t/service/api/stream.py`
- Numbered server + client changes separately
- Final verification commands with expected outputs

---

## Example 2: Multi-week RE task with honest cost estimate

```markdown
### P0-2: iOS token mmtls RE (中长期，2-4 周)

**目标**：反编译 WXWork 的 mmtls finder RPC，构造 iOS 风格的 token
请求，让 finder.video.qq.com 直接返回 `X-encflag=0` 明文响应。

**已知事实**（参见 "方向 A" 章节的验证结果）:
- iOS 样本 request.txt 里的 token 有效期 20+ 小时
- iOS UA + iOS token → 明文
- PC UA + iOS token → 明文（token 决定）
- iOS UA + PC token → 加密（token 决定）
- 结论：**唯一变量是 token**，token 是 finder 后端下发的，绑定
  客户端类型

**RE 路径**：

**Step 1 — 抓 WXWork 发给 finder 的 token 请求**
用 Frida 挂 WXWork.exe，hook `mmnet.dll` / `wxwork.dll` 里的网络
发送函数（类似 `mm::http::SendRequest`），dump outgoing 请求的
URL + body。过滤 `videoservice` / `FinderGet*` 相关的 cgi path。

**Step 2 — 定位发送者结构**
WXWork 使用 mmtls（WeChat 的自定义 TLS），payload 是 protobuf。
需要看 protobuf schema 里的 `client_type` / `device_type` 字段。
估计有类似 `enum DeviceType { PC=1, IOS=2, ANDROID=3 }` 的枚举。

**Step 3 — Patch 或重放**
两种路径：
- **Frida patch**：hook 请求构造函数，把 device_type=PC 改成
  device_type=IOS
- **离线重放**：完全脱离 WXWork，用 Python 自己实现 mmtls 握手 +
  protobuf 请求。难度最高但最干净。

**Step 4 — 验证**
`‌``python
r = requests.get(new_url, headers={'User-Agent': 'AppleCoreMedia/...'})
assert r.headers['X-encflag'] == '0'
`‌``

**参考资料**：
- 公众项目 `WeChatFerry` / `wx_inject` (mmtls 协议层通用)
- `request.txt` 里的 iOS 样本：`D:/workspace/request.txt`
- `worker_release.js` 里的客户端代码

**成本 vs 收益**:
- 成本：2-4 周，需要 IDA Pro + Frida + 协议分析
- 收益：直接 Tencent 域名播放，永久有效
- 风险：WXWork 每次更新可能动 mmtls / protobuf schema
```

Key things to notice:
- Starts with numeric time estimate in the heading
- **已知事实** list cites prior verification results with specific
  HTTP header values
- Step-by-step RE path with tool names (Frida, IDA Pro, mmtls)
- Multiple options listed per step with comparative notes
- Verification code shows the exact assertion
- **参考资料** links to absolute paths in the local filesystem
- **成本 vs 收益** is explicit about weeks, not "TBD"

---

## Example 3: Phase entry inside roadmap

```markdown
## 🧭 Roadmap (high-level)

Current state: 视频号 capture → decrypt → transcribe → 飞书 doc →
SQLite DB. Stable and runnable via `start_finder_monitor.ps1`.

Next phases (roughly in order):

| Phase | What | Depends on | Notes |
|---|---|---|---|
| 2 | Comment panel extraction | nothing | selectors already probed |
| 2' | ChatMessage outer decode | nothing | see sister section |
| 3 | LLM integration + auto-reply | Phase 2 + 2' | multi-backend adapter |
| 4 | Multi-platform ingress | nothing | l2t already supports |
| 5 | Rust + wasmtime | nothing | removes "must play" constraint |

### Phase 3: LLM 集成 + 自动回复 (architect notes)

**Inputs already available at LLM time:**
- video title + author + transcript (from existing DB)
- full comment thread (from Phase 2)
- the original finder.video.qq.com URL

**LLM adapter** — single `llm.py` module with a pluggable backend:

`‌``python
class LLMClient:
    def __init__(self, backend: str = None):  # auto from env
        ...
    def summarize(self, transcript: str, max_tokens=200) -> str: ...
    def draft_reply(self, video_title, transcript,
                    parent_comment: str, style: str) -> str: ...
`‌``

Backends to support:
- **Claude** (Anthropic API)
- **OpenAI / Azure**
- **Qwen** (DashScope — l2t already has the key)
- **Doubao** (Volc)

Backend selection via env: `LLM_BACKEND=claude|openai|qwen|doubao`.

**Safety rails:**
- Manual approval queue by default
- Rate limit (≤1 reply per video per hour)
- Opt-out list of authors / keywords
- Never reply to your own comments
- Log every drafted + sent reply to a `llm_actions` table
```

Key things to notice:
- Opens with the whole-project status in one sentence
- Phase table has `Depends on` column for ordering
- Sub-section `### Phase 3:` is heavily detailed because it's
  complex; shorter phases don't need this depth
- Code block shows the Python API signature, not the impl
- Bulleted backend list with parenthetical notes on what's
  already available
- **Safety rails** enumerated, not hand-waved

---

## Example 4: Strategic decision (tech stack)

```markdown
## 🦀 后续技术栈决定：切 Rust

协议稳定后将核心 pipeline 迁到 Rust。理由与路线：

**动机**：
- 当前 Python + CDP hook 的最大硬约束是「必须播放视频才能拿到
  keystream」——因为 `p` 是 worker 里的闭包变量，`p.decryptor_array`
  读不到，只能通过 hook `Uint8Array.prototype.set` 被动拦截。
- Rust 可以用 `wasmtime` 直接加载并执行 `worker_release.js` 里那
  段 WxIsaac64 的 wasm，**只要有 seed 就能离线生成 keystream**。

**为什么不是 C++**：

| 维度 | Rust | C++ |
|---|---|---|
| CDP 客户端 | `chromiumoxide` 成熟 | 无主流 lib |
| 跑 wasm 取 keystream | `wasmtime` 开箱即用 | 要 embed v8 或手写 ISAAC |
| fmp4 / ISO BMFF | `mp4parse`（Mozilla） | libav C API，风险高 |
| HTTP + token URL | `reqwest` | libcurl |
| 部署 | 单个 static exe | 依赖 CRT/DLL |

**迁移分阶段**：
1. **当下**：Python 继续，协议抠清楚再说
2. **方向 A 完全打通后**：Rust crate
   - `wasmtime` 加载 WxIsaac64 wasm → seed 直出 keystream
   - `reqwest` 用 iOS UA 直接下载 `finder.video.qq.com` URL
3. **方向 2（自动点击企微聊天窗口）**：Rust + `windows` crate
```

Key things to notice:
- `🦀` emoji indicates strategic/architectural decision
- `**动机**` explains the driving problem with a technical detail
  (closure-scoped `p` variable)
- Comparison table has 5 dimensions (not just 2)
- Migration is split into numbered phases with conditions
- Bolded **当下** / **方向 A 完全打通后** make phase boundaries
  scannable

---

## Non-example: what NOT to write

Bad — vague, no cost, no code, no references:

```markdown
## TODO: comments

We should probably scrape comments at some point. Might be
tricky because of the DOM. Look into it.
```

Bad — checkbox format (belongs in markdown-tasks skill):

```markdown
## TODO
- [ ] scrape comments
- [ ] add LLM integration
- [ ] multi-platform support
```

Bad — mixing implementation with TODO:

```markdown
## 🔥 P0 · 评论抓取

I'll go ahead and implement this now by first clicking the
comment button and then...
```

Good version of the same item (see Example 1 of the finder-catch
todo.md for a full example): heading marker, bold **目标**, numbered
implementation steps with real selectors from a DOM probe, and
honest cost estimate.
