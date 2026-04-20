---
name: browser
description: This skill should be used for browser automation tasks using Chrome DevTools Protocol (CDP). Triggers when users need to launch Chrome with remote debugging, navigate pages, execute JavaScript in browser context, capture screenshots, or interactively select DOM elements. No MCP server required. Optimize outputs for the next agent by naming the most relevant tab, selector, DOM state, console signal, or script target to inspect next.
---

# Browser Automation

## Agent-First Output Rule

Browser automation output should reduce the next agent's search space.

Do not return only raw DOM data or screenshots when the real need is diagnosis or navigation.

When the task involves investigation, end with:
- `suspected_scope`
- `strongest_evidence`
- `next_best_action`
- `next_target`
- `confidence`

Examples:

```md
suspected_scope=settings page save button
strongest_evidence=button exists in DOM but remains disabled after valid input event sequence
next_best_action=inspect DOM and event handler
next_target=document selector for save button and attached listener path
confidence=medium
```

Minimal Chrome DevTools Protocol (CDP) helpers for browser automation without MCP server setup.

## Setup

Install dependencies before first use:

```bash
npm install --prefix ~/.claude/skills/browser/browser ws
```

## Scripts

All scripts connect to Chrome on `localhost:9222`.

### start.js - Launch Chrome

```bash
scripts/start.js              # Fresh profile
scripts/start.js --profile    # Use persistent profile (keeps cookies/auth)
```

### nav.js - Navigate

```bash
scripts/nav.js https://example.com        # Navigate current tab
scripts/nav.js https://example.com --new  # Open in new tab
```

### eval.js - Execute JavaScript

```bash
scripts/eval.js 'document.title'
scripts/eval.js '(() => { const x = 1; return x + 1; })()'
```

Use single expressions or IIFE for multiple statements.

### screenshot.js - Capture Screenshot

```bash
scripts/screenshot.js
```

Returns `{ path, filename }` of saved PNG in temp directory.

### pick.js - Visual Element Picker

```bash
scripts/pick.js "Click the submit button"
```

Returns element metadata: tag, id, classes, text, href, selector, rect.

## Workflow

1. Launch Chrome: `scripts/start.js --profile` for authenticated sessions
2. Navigate: `scripts/nav.js <url>`
3. Inspect: `scripts/eval.js 'document.querySelector(...)'`
4. Capture: `scripts/screenshot.js` or `scripts/pick.js`
5. Return gathered data
6. If the task is diagnostic, summarize the smallest failing browser scope and the next best target

## Key Points

- All operations run locally - credentials never leave the machine
- Use `--profile` flag to preserve cookies and auth tokens
- Scripts return structured JSON for agent consumption
