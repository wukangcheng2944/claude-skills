---
name: douyin-creator
description: Self-evolving skill for Douyin Creator Center. Auto-verifies and updates UI selectors on each run. Supports multi-profile management, stealth anti-detection, video/image publishing. Triggers on "发布抖音", "抖音上传", "douyin publish", "抖音创作者中心", "发布视频到抖音", "发布图文到抖音", "切换抖音账号", "抖音多账号".
---

# Douyin Creator Center - Self-Evolving Publishing Skill

Uses **Playwright MCP** with CDP cookie extraction and stealth anti-detection.

## 0. Self-Evolution Protocol

**On every operation, BEFORE performing actions:**

### 0.1 Verify Page Structure
```js
// browser_run_code → verify expected elements exist on publish page
async (page) => {
  const checks = {
    title_input: await page.$('input[placeholder*="添加作品标题"]'),
    desc_area: await page.$('.zone-container'),
    tag_btn: await page.$('text=#添加话题'),
    at_btn: await page.$('text=@好友'),
    cover_btn: await page.$('text=编辑封面'),
    publish_btn: await page.$('button:has-text("发布")'),
    draft_btn: await page.$('button:has-text("暂存离开")'),
    visibility: await page.$('text=谁可以看'),
    schedule: await page.$('text=发布时间'),
    music: await page.$('text=选择音乐'),
    collection: await page.$('text=添加合集'),
    trending: await page.$('text=关联热点'),
  };
  const missing = Object.entries(checks).filter(([k,v]) => !v).map(([k]) => k);
  return { all_ok: missing.length === 0, missing, found: Object.keys(checks).length - missing.length };
}
```

### 0.2 When Elements Are Missing
```
1. Take screenshot + snapshot of current page
2. Compare with expected structure in this skill
3. Retry after 5s (might be loading)
4. If still missing after retry:
   a. Identify what changed (renamed? moved? removed?)
   b. Update the selector in this skill.md
   c. Log change to profiles/changelog.json
   d. Continue operation with new selector
```

### 0.3 Changelog
```json
// profiles/changelog.json — append entry
{ "date": "...", "platform": "douyin", "page": "...", "change": "...", "verified": true }
```

### 0.4 Trigger Conditions
- **Every publish:** Quick verify (key elements only, ~2s)
- **On element-not-found error:** Full re-scan + update
- **Weekly:** Full page structure audit

---

## 1. Profile System (CDP Full Cookie Export/Import)

### VERIFIED: What Works

| Platform | Minimum cookies needed | clearCookies → addCookies → navigate | Result |
|----------|:---------------------:|:------------------------------------:|--------|
| 抖音 | **29** (auth + security chain) | Tested | Login restored |
| 微信视频号 | **2** (sessionid + wxuin) | Tested | Login restored |

**Critical for 抖音:** Must include ALL of these cookie groups:
- Auth: `sessionid`, `sessionid_ss`, `sid_tt`, `uid_tt`, `uid_tt_ss`, `sid_guard`, `sid_ucp_v1`, `ssid_ucp_v1`, `session_tlb_tag`
- Identity: `passport_csrf_token`, `passport_csrf_token_default`, `n_mh`, `d_ticket`, `passport_mfa_token`, `is_staff_user`, `odin_tt`, `ttwid`, `passport_assist_user`
- Security chain: `bd_ticket_guard_client_web_domain`, `bd_ticket_guard_client_data`, `_bd_ticket_crypt_doamin`, `_bd_ticket_crypt_cookie`, `__security_server_data_status`, `__security_mc_1_s_sdk_sign_data_key_web_protect`, `__security_mc_1_s_sdk_cert_key`, `__security_mc_1_s_sdk_crypt_sdk`
- Session: `passport_fe_beating_status`, `csrf_session_id`, `gfkadpd`

**Missing any security chain cookie = login page shown (16 cookies failed, 29 succeeded)**

### Save Profile (after manual login)
```js
// Step 1: browser_run_code → Extract ALL cookies via CDP
async (page) => {
  const client = await page.context().newCDPSession(page);
  const { cookies } = await client.send('Network.getAllCookies');
  await client.detach();
  // Filter by domain, clean for addCookies format
  const target = cookies.filter(c => c.domain.includes('douyin')).map(c => ({
    name: c.name, value: c.value, domain: c.domain, path: c.path,
    expires: c.expires > 0 ? Math.floor(c.expires) : -1,
    httpOnly: c.httpOnly, secure: c.secure, sameSite: c.sameSite || 'Lax'
  }));
  return { count: target.length, cookies: target };
}
// Step 2: Write result.cookies as JSON array to profiles/{name}.cookies.json
// Step 3: Write meta to profiles/{name}.meta.json

// For WeChat: filter by c.domain.includes('weixin') || c.domain.includes('qq.com')
```

### Load Profile (switch account)
```js
// Step 1: Clear cookies for target platform ONLY (preserve other platforms)
// browser_run_code →
async (page) => {
  const client = await page.context().newCDPSession(page);
  const { cookies } = await client.send('Network.getAllCookies');
  for (const c of cookies) {
    if (c.domain.includes('douyin')) {  // or 'weixin' for WeChat
      await client.send('Network.deleteCookies', { name: c.name, domain: c.domain, path: c.path });
    }
  }
  await client.detach();
  return { cleared: true };
}

// Step 2: Read cookies from profiles/{name}.cookies.json

// Step 3: Inject cookies
// browser_run_code →
async (page) => {
  const cookies = COOKIES_FROM_FILE;  // JSON array from .cookies.json
  await page.context().addCookies(cookies);
  return { injected: cookies.length };
}

// Step 4: Navigate and verify
// browser_navigate → target platform URL
// Verify: page shows username (not login page)
```

### IMPORTANT: Platform-Specific Cookie Clearing
```js
// DO NOT use context.clearCookies() — it clears ALL platforms!
// Use CDP Network.deleteCookies to clear only one platform:
// - 抖音: c.domain.includes('douyin')
// - 视频号: c.domain.includes('weixin') || c.domain.includes('qq.com')
// This preserves login state for other platforms during account switching.
```

### Profile Directory
```
~/.claude/skills/douyin-creator/profiles/
├── douyin_n55iw.cookies.json       # 29 cookies (auth + security chain)
├── douyin_n55iw.meta.json
├── douyin_NotFound.meta.json
├── wechat_K1ENTO.cookies.json      # 2 cookies (sessionid + wxuin)
├── wechat_K1ENTO.meta.json
├── wechat_Osipov931.cookies.json   # 2 cookies
├── wechat_Osipov931.meta.json
└── changelog.json
```

### Multi-Platform Support
| Platform | URL | Prefix | Min Cookies | Cookie Domain Filter |
|----------|-----|--------|:-----------:|---------------------|
| 抖音 | creator.douyin.com | douyin_ | 29 | `douyin` |
| 微信视频号 | channels.weixin.qq.com | wechat_ | 2 | `weixin` or `qq.com` |
| 快手 | cp.kuaishou.com | kuaishou_ | TBD | `kuaishou` |
| B站 | member.bilibili.com | bilibili_ | TBD | `bilibili` |
| 小红书 | creator.xiaohongshu.com | xiaohongshu_ | TBD | `xiaohongshu` |

---

## 2. Stealth Anti-Detection

Inject via `browser_evaluate` **after every navigation** (lost on page load):

```js
(() => {
  Object.defineProperty(navigator, 'webdriver', { get: () => false });
  Object.defineProperty(navigator, 'plugins', {
    get: () => [1,2,3,4,5].map(() => ({name:'Chrome PDF Plugin',description:'Portable Document Format',filename:'internal-pdf-viewer',length:1}))
  });
  Object.defineProperty(navigator, 'languages', { get: () => ['zh-CN','zh','en-US','en'] });
  delete window.cdc_adoQpoasnfa76pfcZLmcfl_Array;
  delete window.cdc_adoQpoasnfa76pfcZLmcfl_Promise;
  delete window.cdc_adoQpoasnfa76pfcZLmcfl_Symbol;
  window.chrome = { runtime: {}, loadTimes: () => ({}), csi: () => ({}) };
  const oq = window.navigator.permissions?.query;
  if (oq) window.navigator.permissions.query = (p) => p.name==='notifications' ? Promise.resolve({state:Notification.permission}) : oq(p);
  const gp = WebGLRenderingContext.prototype.getParameter;
  WebGLRenderingContext.prototype.getParameter = function(p) { return p===37445?'Intel Inc.':p===37446?'Intel Iris OpenGL Engine':gp.call(this,p); };
  return { stealth: 'applied' };
})()
```

---

## 3. Human Behavior Warm-up (MANDATORY before publish)

```js
// browser_run_code →
async (page) => {
  const sleep = (ms) => new Promise(r => setTimeout(r, ms + Math.random()*ms*0.5));
  await page.goto('https://creator.douyin.com/creator-micro/home');
  await sleep(2000);
  await page.mouse.move(300+Math.random()*400, 200+Math.random()*300);
  await page.evaluate(() => window.scrollBy(0, 300+Math.random()*500));
  await sleep(1500);
  await page.click('text=数据中心').catch(()=>{});
  await sleep(2500);
  await page.evaluate(() => window.scrollBy(0, 200+Math.random()*300));
  await page.mouse.move(500+Math.random()*300, 400+Math.random()*200);
  await sleep(1000);
  await page.click('text=内容管理').catch(()=>{});
  await sleep(2000);
  await page.click('text=作品管理').catch(()=>{});
  await sleep(1500);
  for (let i=0;i<3;i++) { await page.mouse.move(100+Math.random()*1200, 100+Math.random()*600, {steps:5+Math.floor(Math.random()*10)}); await sleep(500); }
  await page.goto('https://creator.douyin.com/creator-micro/home');
  await sleep(2000);
  return { warmup: 'complete' };
}
```

---

## 4. Publishing Page - Complete Feature Reference

### 4.0 Page URL
```
Upload hub: https://creator.douyin.com/creator-micro/content/upload
  ?default-tab=1  → 发布视频
  ?default-tab=3  → 发布图文
Post form:  https://creator.douyin.com/creator-micro/content/post/video?...
            https://creator.douyin.com/creator-micro/content/post/image?...
```

### 4.1 Section: 基础信息

#### 4.1.1 作品标题 (Title)
```
Element:  textbox "添加作品标题"
Max:      20 characters
Method:   browser_click → ref  →  browser_type → ref, text
Note:     Optional field. If blank, first line of description becomes title in feed.
```

#### 4.1.2 作品描述 (Description)
```
Element:  contenteditable div, CSS class ".zone-container"
Max:      1000 characters
Counter:  "N / 1000" text shows current length
Method:
  browser_evaluate →
  (() => {
    const ed = document.querySelector('.zone-container');
    ed.focus();
    document.execCommand('insertText', false, 'YOUR TEXT');
    return { ok: true, length: ed.innerText.length };
  })()
Note:     NOT a <textarea>. Regular browser_type works but insertText is more reliable.
          Text appears in real-time preview on right panel.
```

#### 4.1.3 话题标签 (#添加话题)
```
Element:  "#添加话题" button inside description area
Max:      5 tags per post
Method per tag:
  1. browser_click → "#添加话题" (inserts # cursor in editor)
  2. Type keyword:
     - Chinese only:  browser_type → ref of "#" span, text, slowly:true
     - English/Mixed: browser_evaluate → document.execCommand('insertText', false, 'AI绘画')
  3. Wait 1-2s for dropdown suggestions (shows topic name + view count like "519.2亿")
  4. browser_click → matching suggestion to confirm
Confirmed tag: Shows as highlighted clickable span (e.g. "#无限符号")
Unconfirmed:   Plain text, does NOT count as a tag
Limit toast:   "最多可添加5个话题" → press Escape
Bug:           pressSequentially drops A-Z chars. ALWAYS use insertText for English.
```

#### 4.1.4 @好友 (Mention)
```
Element:  "@好友" button next to #添加话题
Method:   browser_click → "@好友" → type friend name → select from dropdown
Note:     Searches among followers/following. Selected user gets notification.
```

#### 4.1.5 推荐话题 (Recommended Topics)
```
Element:  Row of clickable topic pills below description area
Example:  "#实况足球手游", "#虚拟现实", "#平面设计"
Method:   browser_click → any recommended topic pill to auto-insert
"+16":    Click to expand more recommendations
Note:     Recommendations are AI-generated based on uploaded content.
```

#### 4.1.6 官方活动 (Official Activities)
```
Element:  Horizontal scrollable cards with activity name + hotness
Example:  "超会玩派对 热度：300", "来场真正的才艺局 热度：201"
"+28":    Click to see all 28+ available activities
Method:   browser_click → activity card to join
Effect:   Adds activity tag to post, may qualify for traffic bonus
Help:     Click "?" icon next to "官方活动" for explanation
```

#### 4.1.7 封面设置 (Cover Settings)
```
Label:    "封面设置"
Display:  Shows current cover thumbnail + "选择一张图片作为封面"
Button:   "编辑封面" (opens cover editor)
Hint:     "提示：优质的封面会极大增加同城曝光"
Method:   browser_click → "编辑封面" → use cover editor modal
Note:     For 图文, first image is default cover. For video, a frame is auto-selected.
```

#### 4.1.8 编辑图片 (Edit Images) — 图文 mode only
```
Label:    "编辑图片"
Display:  Thumbnail grid of uploaded images
Counter:  "已添加N张图片"
Button:   "继续添加" → opens file chooser for more images (max 35)
Method:   browser_click → "继续添加" → browser_file_upload → paths
          Drag thumbnails to reorder (not easily automatable via Playwright)
```

#### 4.1.9 添加合集 (Add to Collection)
```
Label:    "添加合集"
Dropdown1: "合集" (select which collection type)
Dropdown2: "不选择合集" (default, or pick existing collection)
Method:   browser_click → dropdown → select collection from list
Note:     Collections group related posts together (e.g. a series).
```

### 4.2 Section: 扩展信息

#### 4.2.1 选择音乐 (Select Music)
```
Label:    "选择音乐"
Display:  "点击添加合适作品风格音乐" placeholder
Button:   "选择音乐" (opens music picker modal)
Method:   browser_click → "选择音乐" → search/browse music → select track
Effect:   Adds background music to image slideshow or video.
          Preview panel shows music name with marquee animation.
```

#### 4.2.2 添加标签 (Add Labels)
```
Label:    "添加标签"
Type dropdown: "位置" / "游戏手柄" (switches between location and game tags)
Location mode:
  Placeholder: "输入相关位置，让更多人看到你的作品"
  Method: browser_click → location input → type location name → select from results
  Effect: Adds geo-tag, boosts local discovery
Game mode:
  Text: "添加作品同款游戏"
  Method: browser_click → "添加作品同款游戏" → search game → select
  Effect: Links to game page, eligible for gaming traffic pool
Help:   Click "?" icon for explanation
```

#### 4.2.3 关联热点 (Link Trending Topic)
```
Label:    "关联热点"
Input:    "点击输入热点词" with dropdown arrow
Method:   browser_click → input → type trending keyword → select from suggestions
Effect:   Associates post with trending topic for discovery boost
Help:     Click "?" icon for explanation
```

### 4.3 Section: 发布设置

#### 4.3.1 同时发布 (Simultaneous Publish)
```
Options:
  ☑ "不同时发布" (default, checked)
  ☐ "同时发布到" (publish to linked platforms like Toutiao/Xigua)
Method:  browser_click → checkbox ref
Help:    Click "?" icon next to "同时发布"
```

#### 4.3.2 谁可以看 (Visibility)
```
Options:
  ☑ "公开"        (default, everyone can see)
  ☐ "好友可见"    (mutual followers only)
  ☐ "仅自己可见"  (private, for testing)
Method:  browser_click → checkbox ref (e.g. ref for "仅自己可见")
Help:    Click "?" icon next to "谁可以看"
```

#### 4.3.3 保存权限 (Download Permission)
```
Options:
  ☑ "允许"    (default, others can save your content)
  ☐ "不允许"  (disable saving/downloading)
Method:  browser_click → checkbox ref
Help:    Click "?" icon next to "保存权限"
```

#### 4.3.4 发布时间 (Schedule)
```
Options:
  ☑ "立即发布"  (default, publish now)
  ☐ "定时发布"  (schedule for later)
Method:
  browser_click → "定时发布" checkbox
  → Date/time picker appears
  → Select date and time
  → Confirm
Note:   Scheduled posts appear in content management as "待发布"
```

### 4.4 Action Buttons

#### 4.4.1 快速填写 (Quick Fill)
```
Element:  Clickable text "快速填写" above publish buttons
Method:   browser_click → "快速填写"
Effect:   Copies title/description/tags from your last published work
Banner:   "应用已发布作品的信息，快速完成发布填写。"
```

#### 4.4.2 发布 (Publish)
```
Element:  button "发布"
Method:   browser_click → button ref
Effect:   Submits the post. Redirects to success page or shows error.
Pre-check: Always browser_take_screenshot + confirm with user before clicking.
```

#### 4.4.3 暂存离开 (Save Draft & Leave)
```
Element:  button "暂存离开"
Method:   browser_click → button ref
Effect:   Saves current form state as draft. Can resume later via "继续编辑" prompt.
Draft recovery: Next visit shows "你还有上次未发布的图文，是否继续编辑？" with "继续编辑" and "放弃" buttons.
```

### 4.5 Right Panel

#### 4.5.1 预览图文 (Preview)
```
Display:  Phone-shaped preview showing:
  - Uploaded image/video
  - Author name "@username"
  - Description text with tags
  - "展开" button (expand description)
  - Music bar at bottom (if music selected)
  - Tab bar: 首页 / 朋友 / + / 消息 / 我
Note:     Updates in real-time as you fill the form. Use browser_take_screenshot to verify.
```

#### 4.5.2 清空并重新上传 (Clear & Re-upload)
```
Element:  button "清空并重新上传"
Method:   browser_click → button ref
Effect:   Removes all uploaded media, resets form. Returns to upload page.
Warning:  Destructive action, no confirmation dialog.
```

#### 4.5.3 发文助手 (Post Assistant)
```
Label:    "发文助手" (collapsible panel)

Sub-features:
  a) 自主声明 (Self Declaration)
     Button: "添加声明"
     Effect: Add labels like "AI生成内容", "广告", "付费推广" etc.
     Use:    Required for AI-generated content or sponsored posts

  b) 快速检测 (Quick Check)
     Button: "快速检测" / "重新检测"
     Status: "检测中N%" → "作品未见异常" or "作品检测失败"
     Effect: Pre-checks content for policy violations before publishing
     Tip:    "温馨提示: 结果由机器检测提供，请关注发布后的账号状态"

  c) Collapse toggle (arrow icon at top-right of panel)
```

### 4.6 Popups & Dialogs

| Popup | Trigger | Action |
|-------|---------|--------|
| "我知道了" | First visit, feature updates | browser_click → button |
| "最多可添加5个话题" | Adding 6th tag | browser_press_key → Escape |
| "继续编辑" / "放弃" | Draft exists from previous session | Click to resume or discard |
| Location permission | First visit | Click "一律不允许" to dismiss |
| "快速填写" banner | After loading post form | Click X to dismiss, or ignore |
| "应用已发布作品的信息" | Quick fill prompt on right | Click X to dismiss |

---

## 5. Upload Constraints

| Type | Formats | Max Size | Limits |
|------|---------|----------|--------|
| Video | mp4, webm | 16 GB | ≤60min, ≤4K, ≤60fps, ratio 16:9/9:16/3:4/4:3 |
| Image | jpg, png, webp (no gif) | 50 MB/img | ≤35 images, ratio ≤1:2, recommend 3:4/4:3 |
| Tags | — | — | Max 5 |
| Title | — | — | Max 20 chars |
| Description | — | — | Max 1000 chars |

---

## 6. Complete Publishing Sequence

```
Step 0: Warm up (MANDATORY)
  → browser_run_code → human behavior warm-up script

Step 1: Navigate to upload
  → browser_navigate → upload URL
  → browser_evaluate → stealth script
  → browser_wait_for → text "上传视频" or "上传图文"
  → Handle "我知道了" popup if present

Step 2: Select type & upload file
  → browser_click → "发布图文" tab (if not default)
  → browser_wait_for → time: 1 (human pause)
  → browser_click → "上传视频" or "上传图文" button
  → browser_file_upload → paths: [...]
  → browser_wait_for → time: 5

Step 3: Fill description
  → browser_wait_for → time: 2 (human reading)
  → browser_evaluate → insertText into .zone-container

Step 4: Add tags (1-5)
  → For each: click "#添加话题" → type/insertText → wait → click suggestion
  → 0.5-1.5s pause between each tag

Step 5: Optional fields (as needed)
  → Cover: click "编辑封面"
  → Music: click "选择音乐"
  → Location: click location input → type → select
  → Trending: click "点击输入热点词" → type → select
  → Activity: click activity card
  → Collection: select from dropdown
  → Declaration: click "添加声明" if AI content

Step 6: Configure settings (if non-default)
  → Visibility / Save permission / Schedule

Step 7: Review & publish
  → browser_evaluate → scroll down to check settings, scroll back up
  → browser_take_screenshot → confirm with user
  → browser_wait_for → time: 2 (human hesitation)
  → browser_click → "发布" button
```

---

## 7. Architecture Notes

- **SPA (Garfish):** Wait 5-10s for sub-apps. Re-inject stealth after every nav.
- **Editor:** `.zone-container` contenteditable div. Use `insertText`.
- **Tags:** Must click dropdown suggestion. Plain `#text` ≠ tag.
- **Cookies:** Session ~60 days, device tokens ~1 year. CDP `Network.getAllCookies` for full export.
- **CDP:** `page.context().newCDPSession(page)` for low-level access.
- **File upload:** `browser_file_upload` intercepts file chooser. No OS dialog.
