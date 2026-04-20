---
name: wechat-channels
description: Self-evolving skill for WeChat Channels (视频号助手). Auto-verifies and updates UI selectors on each run. Supports video/image publishing, data analysis, and multi-profile management. Triggers on "视频号", "视频号助手", "wechat channels", "发布视频号", "视频号上传", "视频号数据", "视频号直播", "视频号图文".
---

# WeChat Channels (视频号助手) - Self-Evolving Publishing Skill

Uses **Playwright MCP** with CDP cookie management.

---

## 0. Self-Evolution Protocol

**On every operation, BEFORE performing actions:**

### 0.1 Verify Page Structure
```js
// browser_run_code → verify expected elements exist
async (page) => {
  const checks = {
    upload_btn: await page.$('button:has-text("上传时长")') || await page.$('button:has-text("发布图片动态")'),
    desc_area: await page.$('text=添加描述'),
    topic_btn: await page.$('text=#话题'),
    publish_btn: await page.$('button:has-text("发表")'),
    draft_btn: await page.$('button:has-text("保存草稿")'),
    location: await page.$('text=位置'),
    schedule: await page.$('text=定时发表'),
  };
  const missing = Object.entries(checks).filter(([k,v]) => !v).map(([k]) => k);
  return { all_ok: missing.length === 0, missing, timestamp: new Date().toISOString() };
}
```

### 0.2 When Elements Are Missing
```
1. browser_take_screenshot → capture current page state
2. browser_snapshot → get full accessibility tree
3. Compare with expected structure in this skill
4. Identify what changed (renamed? moved? new element?)
5. Verify the change is real (not a loading issue) by retrying after 5s
6. If confirmed: update this skill.md with new selectors/structure
7. Log change to profiles/changelog.json
```

### 0.3 Changelog Format
```json
// profiles/changelog.json
[
  {
    "date": "2026-03-24",
    "platform": "wechat",
    "page": "post/create",
    "change": "图文标题 field max chars changed from 22 to 25",
    "old_selector": "textbox placeholder '填写标题, 22个字符内'",
    "new_selector": "textbox placeholder '填写标题, 25个字符内'",
    "verified": true
  }
]
```

### 0.4 When to Trigger Self-Evolution
- **Every publish operation:** Quick check (verify key elements exist)
- **Weekly or on error:** Full scan (snapshot entire page, compare all selectors)
- **After platform update notices:** Full re-scan all pages

---

## 1. Profile System

Profiles stored in: `~/.claude/skills/douyin-creator/profiles/wechat_{name}.cookies.json`

### VERIFIED: Only 2 cookies needed (tested with K1ENTO ↔ Osipov931 switching)

| Cookie | Domain | httpOnly | Expiry |
|--------|--------|:--------:|--------|
| `sessionid` | channels.weixin.qq.com | No | ~1 year |
| `wxuin` | channels.weixin.qq.com | No | ~1 year |

Login: WeChat mobile QR scan only. No phone/password option.

### Save Profile
```js
// browser_run_code →
async (page) => {
  const client = await page.context().newCDPSession(page);
  const { cookies } = await client.send('Network.getAllCookies');
  await client.detach();
  return cookies.filter(c => c.domain.includes('weixin') || c.domain.includes('qq.com'))
    .map(c => ({ name:c.name, value:c.value, domain:c.domain, path:c.path,
      expires: c.expires>0 ? Math.floor(c.expires) : -1,
      httpOnly:c.httpOnly, secure:c.secure, sameSite:c.sameSite||'Lax' }));
}
// Write result as JSON array to profiles/wechat_{name}.cookies.json
```

### Switch Account (load different profile)
```js
// Step 1: Clear ONLY weixin cookies (preserve douyin etc.)
// browser_run_code →
async (page) => {
  const client = await page.context().newCDPSession(page);
  const { cookies } = await client.send('Network.getAllCookies');
  for (const c of cookies) {
    if (c.domain.includes('weixin') || c.domain.includes('qq.com')) {
      await client.send('Network.deleteCookies', { name: c.name, domain: c.domain, path: c.path });
    }
  }
  await client.detach();
  return { cleared: true };
}

// Step 2: Inject target profile cookies
// browser_run_code →
async (page) => {
  await page.context().addCookies(COOKIES_FROM_FILE);
  return { injected: true };
}

// Step 3: Navigate and verify
// browser_navigate → https://channels.weixin.qq.com/platform
// Check: page shows target nickname (not login QR)
```

### CRITICAL: Use CDP deleteCookies, NOT context.clearCookies()
`context.clearCookies()` clears ALL platforms. Use CDP `Network.deleteCookies` filtered by domain to preserve other platform sessions.

### Current Profiles
```
wechat_K1ENTO.cookies.json    → K1ENTO (sphHeS9MvIp4wpN, 2 videos, 3 followers)
wechat_Osipov931.cookies.json → Osipov931 (sphSRj9EczYBTxe, 1 video, 4 followers)
```

---

## 2. Site Map

| Page | URL |
|------|-----|
| Login | `channels.weixin.qq.com/login.html` |
| Home | `channels.weixin.qq.com/platform` |
| **Publish Video** | `channels.weixin.qq.com/platform/post/create` |
| **Publish Image** | `channels.weixin.qq.com/platform/post/finderNewLifeCreate` |
| Video list | `channels.weixin.qq.com/platform/post/list` |
| Image list | `channels.weixin.qq.com/platform/post/finderNewLifePostList` |
| Live data | `channels.weixin.qq.com/platform/statistic/live` |

### Sidebar Navigation
```
首页
内容管理 → 视频, 图文, 音乐, 音频, 草稿箱, 主页, 活动
互动管理 → 评论, 弹幕, 私信
直播 → (expandable)
收入与服务 → (expandable)
带货中心
数据中心 → 关注者数据, 视频数据, 图文数据, 直播数据, 带货数据
设置
```

---

## 3. Video Publish Page

URL: `channels.weixin.qq.com/platform/post/create`

### 3.1 Upload Area
```
Button:  "上传时长8小时内，大小不超过20GB，建议分辨率720p及以上，码率10Mbps以内，格式为MP4/H.264格式"
Method:  browser_click → button → browser_file_upload → paths
Limits:  ≤8h, ≤20GB, ≥720p, ≤10Mbps, MP4/H.264
```

### 3.2 视频描述
```
Placeholder: "添加描述"
Method:      browser_click → placeholder → browser_type slowly / insertText
Buttons:     "#话题" (add topic), "@视频号" (mention channel)
```

### 3.3 位置
```
Default:  Auto-detected (e.g. "华盛顿")
Method:   browser_click → dropdown → search → select
```

### 3.4 添加到合集
```
Default:  "选择合集"
Method:   browser_click → dropdown → select/create
```

### 3.5 链接
```
Default:  "选择链接"
Method:   browser_click → dropdown → paste URL / select saved
```

### 3.6 活动
```
Default:  "不参与活动"
Method:   browser_click → dropdown → select activity
```

### 3.7 定时发表
```
Options:  ● 不定时 (default) ○ 定时
Method:   browser_click → "定时" radio → date picker
```

### 3.8 短标题
```
Placeholder: "概括视频主要内容，字数建议6-16个字符"
Method:      browser_type → textbox ref
```

### 3.9 Buttons
```
保存草稿  → saves draft
手机预览  → QR code for mobile preview
发表      → publish
```

---

## 4. Image (图文) Publish Page

URL: `channels.weixin.qq.com/platform/post/finderNewLifeCreate`
Entry: 内容管理 → 图文 → "发表图文" button

### 4.1 Upload Area
```
Button:  "发布图片动态，可上传最多18张图片，单张不超过20MB，支持常见图片格式。"
Method:  browser_click → button → browser_file_upload → paths (multiple)
Limits:  ≤18 images, ≤20MB/image, jpg/png/webp
```

### 4.2 图文标题 (Video page does NOT have this!)
```
Placeholder: "填写标题, 22个字符内"
Method:      browser_type → textbox ref
Max:         22 characters
```

### 4.3 图文描述
```
Placeholder: "添加描述, 1000个字符内"
Method:      browser_click → placeholder → browser_type / insertText
Buttons:     "#话题", "@视频号"
Max:         1000 characters
```

### 4.4 音乐 (Video page does NOT have this!)
```
Default:  "选择背景音乐"
Method:   browser_click → dropdown → search/select music
```

### 4.5 Other fields (same as video)
位置, 添加到合集, 链接, 活动, 定时发表 — identical to video page.

### 4.6 Buttons (same as video)
保存草稿, 手机预览, 发表

---

## 5. Video vs Image Comparison

| Feature | 视频发布 | 图文发布 |
|---------|---------|---------|
| URL | /post/create | /post/finderNewLifeCreate |
| Upload | ≤20GB, MP4/H.264, ≤8h | ≤18 images, ≤20MB each |
| 标题 | 短标题 (6-16 chars) | 图文标题 (≤22 chars) |
| 描述 | 添加描述 (no char limit shown) | 添加描述, 1000字符内 |
| 音乐 | No | Yes ("选择背景音乐") |
| 位置 | Yes | Yes |
| 合集 | Yes | Yes |
| 链接 | Yes | Yes |
| 活动 | Yes | Yes |
| 定时发表 | Yes | Yes |

---

## 6. Publishing Sequences

### 6.1 Video Publish
```
Step 0: Warm up (visit homepage, data center ~15s)
Step 1: browser_navigate → /platform/post/create
Step 2: browser_run_code → verify page structure (self-evolution check)
Step 3: browser_click → upload area → browser_file_upload → video.mp4
Step 4: browser_wait_for → time: 10 (processing)
Step 5: Fill description (insertText or type slowly)
Step 6: Add topics via "#话题"
Step 7: Optional: location, collection, link, activity, schedule
Step 8: Fill 短标题 (6-16 chars)
Step 9: browser_take_screenshot → confirm
Step 10: browser_click → "发表"
```

### 6.2 Image Publish
```
Step 0: Warm up
Step 1: browser_navigate → /platform/post/finderNewLifeCreate
        OR: 内容管理 → 图文 → "发表图文"
Step 2: browser_run_code → verify page structure
Step 3: browser_click → upload area → browser_file_upload → image(s)
Step 4: browser_wait_for → time: 5
Step 5: Fill 图文标题 (≤22 chars)
Step 6: Fill 图文描述 (insertText, ≤1000 chars)
Step 7: Add topics via "#话题"
Step 8: Optional: music, location, collection, link, activity, schedule
Step 9: browser_take_screenshot → confirm
Step 10: browser_click → "发表"
```

---

## 7. Data Analysis Features

### Homepage Stats
```
Navigate: /platform
Elements: 昨日数据 → 净增关注, 新增播放, 新增点赞, 新增评论
          最近视频 → per-video stats (播放/点赞/评论/转发/收藏)
```

### Data Center Navigation
```
Sidebar hover JS fallback (menu disappears before click):
  document.querySelectorAll('a').forEach(a => a.textContent.includes('直播数据') && a.click());
```

### Live Data Dashboard
```
Single session → click "数据详情"
Trend dashboard → click "前往数据趋势大屏"
Tabs: 概览, 商品, 画像, 主播
```

---

## 8. Architecture Notes

- **iframe micro-frontend:** Content in iframes, longer load times
- **Low bot detection:** Less aggressive than Douyin, stealth optional
- **Simple cookies:** Only 2 needed, valid ~1 year
- **QR-only login:** Cannot automate, user must scan with WeChat app
- **Sidebar hover trick:** Sub-menus appear on hover, use JS click fallback
