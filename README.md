# claude-skills

Mirror of local Codex/Claude skills from this machine.

This repository is kept in sync from the local skill roots below:

- `D:\workspace\.agents\skills`
- `C:\Users\EDY\.codex\skills`
- `C:\Users\EDY\.agents\skills`

The sync order is intentional:

1. Workspace skill directories win first.
2. Installed Codex skills win next.
3. Legacy `.agents` skills fill the rest.

Duplicate directory names are de-duplicated by that precedence order. Hidden/system skill folders such as `.system` are skipped.

Secret-like local artifacts are also excluded from sync, including `Zone.Identifier`, cookies, storage/session files, `.env`, token files, and private keys.

## Manual Sync

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\sync-local-skills.ps1
```

## Auto Sync

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\install-sync-task.ps1
```

That installs a local watcher which listens for file changes in the configured skill roots and pushes updates to GitHub automatically.

## Install All Skills Locally

```bash
./install.sh
```

## Synced Skill Directories

| Skill | Source Root |
|-------|-------------|
| [academic-review-skill](./academic-review-skill) | %USERPROFILE%\.codex\skills |
| [adapt](./adapt) | %USERPROFILE%\.codex\skills |
| [agent-memory](./agent-memory) | %USERPROFILE%\.codex\skills |
| [animate](./animate) | %USERPROFILE%\.codex\skills |
| [architecture-diagram](./architecture-diagram) | %USERPROFILE%\.codex\skills |
| [artifacts-builder](./artifacts-builder) | %USERPROFILE%\.codex\skills |
| [audit](./audit) | %USERPROFILE%\.codex\skills |
| [bolder](./bolder) | %USERPROFILE%\.codex\skills |
| [browser](./browser) | %USERPROFILE%\.codex\skills |
| [caveman](./caveman) | %USERPROFILE%\.codex\skills |
| [caveman-commit](./caveman-commit) | %USERPROFILE%\.codex\skills |
| [caveman-compress](./caveman-compress) | %USERPROFILE%\.codex\skills |
| [caveman-review](./caveman-review) | %USERPROFILE%\.codex\skills |
| [changelog-generator](./changelog-generator) | %USERPROFILE%\.codex\skills |
| [clarify](./clarify) | %USERPROFILE%\.codex\skills |
| [codeagent](./codeagent) | %USERPROFILE%\.codex\skills |
| [colorize](./colorize) | %USERPROFILE%\.codex\skills |
| [content-research-writer](./content-research-writer) | %USERPROFILE%\.codex\skills |
| [critique](./critique) | %USERPROFILE%\.codex\skills |
| [darwin-skill](./darwin-skill) | D:\workspace\.agents\skills |
| [deep-research](./deep-research) | %USERPROFILE%\.codex\skills |
| [delight](./delight) | %USERPROFILE%\.codex\skills |
| [deploy-automation-playbook](./deploy-automation-playbook) | %USERPROFILE%\.codex\skills |
| [dev](./dev) | %USERPROFILE%\.codex\skills |
| [developer-growth-analysis](./developer-growth-analysis) | %USERPROFILE%\.codex\skills |
| [development-flow-logging](./development-flow-logging) | %USERPROFILE%\.codex\skills |
| [distill](./distill) | %USERPROFILE%\.codex\skills |
| [douyin-creator](./douyin-creator) | %USERPROFILE%\.codex\skills |
| [fact-checker](./fact-checker) | %USERPROFILE%\.codex\skills |
| [flow-interview](./flow-interview) | %USERPROFILE%\.codex\skills |
| [frontend-art-director](./frontend-art-director) | %USERPROFILE%\.codex\skills |
| [frontend-design](./frontend-design) | %USERPROFILE%\.codex\skills |
| [github-kb](./github-kb) | %USERPROFILE%\.codex\skills |
| [harden](./harden) | %USERPROFILE%\.codex\skills |
| [huashu-nuwa](./huashu-nuwa) | D:\workspace\.agents\skills |
| [icon-finder](./icon-finder) | %USERPROFILE%\.codex\skills |
| [impeccable](./impeccable) | %USERPROFILE%\.codex\skills |
| [karpathy-guidelines](./karpathy-guidelines) | %USERPROFILE%\.codex\skills |
| [lark-base](./lark-base) | %USERPROFILE%\.codex\skills |
| [lark-calendar](./lark-calendar) | %USERPROFILE%\.codex\skills |
| [lark-contact](./lark-contact) | %USERPROFILE%\.codex\skills |
| [lark-doc](./lark-doc) | %USERPROFILE%\.codex\skills |
| [lark-drive](./lark-drive) | %USERPROFILE%\.codex\skills |
| [lark-event](./lark-event) | %USERPROFILE%\.codex\skills |
| [lark-im](./lark-im) | %USERPROFILE%\.codex\skills |
| [lark-mail](./lark-mail) | %USERPROFILE%\.codex\skills |
| [lark-minutes](./lark-minutes) | %USERPROFILE%\.codex\skills |
| [lark-openapi-explorer](./lark-openapi-explorer) | %USERPROFILE%\.codex\skills |
| [lark-shared](./lark-shared) | %USERPROFILE%\.codex\skills |
| [lark-sheets](./lark-sheets) | %USERPROFILE%\.codex\skills |
| [lark-skill-maker](./lark-skill-maker) | %USERPROFILE%\.codex\skills |
| [lark-task](./lark-task) | %USERPROFILE%\.codex\skills |
| [lark-vc](./lark-vc) | %USERPROFILE%\.codex\skills |
| [lark-whiteboard](./lark-whiteboard) | %USERPROFILE%\.codex\skills |
| [lark-wiki](./lark-wiki) | %USERPROFILE%\.codex\skills |
| [lark-workflow-meeting-summary](./lark-workflow-meeting-summary) | %USERPROFILE%\.codex\skills |
| [lark-workflow-standup-report](./lark-workflow-standup-report) | %USERPROFILE%\.codex\skills |
| [layout](./layout) | %USERPROFILE%\.agents\skills |
| [lead-research-assistant](./lead-research-assistant) | %USERPROFILE%\.codex\skills |
| [llm-prompt-optimizer](./llm-prompt-optimizer) | %USERPROFILE%\.codex\skills |
| [nuwa-skill](./nuwa-skill) | %USERPROFILE%\.codex\skills |
| [optimize](./optimize) | %USERPROFILE%\.codex\skills |
| [overdrive](./overdrive) | %USERPROFILE%\.codex\skills |
| [polish](./polish) | %USERPROFILE%\.codex\skills |
| [quieter](./quieter) | %USERPROFILE%\.codex\skills |
| [redfi-kb](./redfi-kb) | %USERPROFILE%\.codex\skills |
| [shape](./shape) | %USERPROFILE%\.codex\skills |
| [skill-creator](./skill-creator) | %USERPROFILE%\.codex\skills |
| [test-cases](./test-cases) | %USERPROFILE%\.codex\skills |
| [theme-factory](./theme-factory) | %USERPROFILE%\.codex\skills |
| [typeset](./typeset) | %USERPROFILE%\.codex\skills |
| [us-a-share-signal-executor](./us-a-share-signal-executor) | %USERPROFILE%\.codex\skills |
| [us-a-share-signal-optimizer](./us-a-share-signal-optimizer) | %USERPROFILE%\.codex\skills |
| [us-signal-autoresearch-optimizer](./us-signal-autoresearch-optimizer) | %USERPROFILE%\.codex\skills |
| [web-access](./web-access) | %USERPROFILE%\.codex\skills |
| [webapp-testing](./webapp-testing) | %USERPROFILE%\.codex\skills |
| [wechat-channels](./wechat-channels) | %USERPROFILE%\.codex\skills |
| [wecomcli-contact](./wecomcli-contact) | %USERPROFILE%\.codex\skills |
| [wecomcli-doc](./wecomcli-doc) | %USERPROFILE%\.codex\skills |
| [wecomcli-meeting](./wecomcli-meeting) | %USERPROFILE%\.codex\skills |
| [wecomcli-msg](./wecomcli-msg) | %USERPROFILE%\.codex\skills |
| [wecomcli-schedule](./wecomcli-schedule) | %USERPROFILE%\.codex\skills |
| [wecomcli-todo](./wecomcli-todo) | %USERPROFILE%\.codex\skills |
| [writing-clearly-and-concisely](./writing-clearly-and-concisely) | %USERPROFILE%\.codex\skills |
| [writing-dev-server-tests](./writing-dev-server-tests) | %USERPROFILE%\.codex\skills |
| [writing-structured-todos](./writing-structured-todos) | %USERPROFILE%\.codex\skills |

The README is regenerated by `tools/sync-local-skills.ps1` on every sync.

