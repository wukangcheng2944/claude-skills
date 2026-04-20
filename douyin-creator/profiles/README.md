# Browser Profiles

Each profile stores login session for one account on one platform.

## File Structure
```
{platform}_{nickname}.cookies.json   - Browser cookies (JSON array)
{platform}_{nickname}.storage.json   - localStorage snapshot
{platform}_{nickname}.meta.json      - Account metadata
```

## Supported Platforms
- douyin (抖音)
- wechat (微信视频号)
- kuaishou (快手)
- bilibili (B站)
- xiaohongshu (小红书)

## Usage
1. Login manually in Playwright browser
2. Run "save profile" to capture cookies
3. Next time, run "load profile" to auto-login
