# RedFi Self-Hosted GitHub Pattern

Use this reference when the deployment topology is:
- GitHub as the deploy trigger
- a local Windows machine as the self-hosted runner
- a remote Linux server that pulls `deploy` and builds locally

## Current RedFi flow

1. Push to `origin/deploy`.
2. GitHub Actions runs validation on `ubuntu-latest`.
3. GitHub Actions runs deploy on the local self-hosted Windows runner.
4. The deploy job checks out the repo and calls `scripts/run_self_hosted_deploy.ps1`.
5. That script auto-detects the SSH execution path:
   - `ALi3` alias if it works
   - user-profile key if available
   - GitHub secret key fallback if alias and profile key are unavailable
6. The script SSHes to ALi3 and runs `scripts/deploy_server.sh deploy`.
7. The server-side script performs backup, git sync, build, restart, health checks, and rollback on failure.

## Files to inspect first

- `.github/workflows/deploy-ali3.yml`
- `scripts/run_self_hosted_deploy.ps1`
- `scripts/deploy_server.sh`
- `main.py`
- `frontend/src/utils/format.ts`

## Windows self-hosted runner notes

- `deploy` jobs that call repo scripts must include `actions/checkout` in the deploy job itself.
- Windows PowerShell 5 does not reliably expose `$IsWindows`; use `OS=Windows_NT` for OS checks.
- Service accounts may use virtual identities with a trailing `$`; use the current SID for key-file ACLs.
- Always set `BatchMode=yes` and `ConnectTimeout=15` for SSH in automation.

## Repo behavior that must be preserved

- restarting `schedule` must not replay already due push slots
- push times shown in the UI must stay pinned to `Asia/Shanghai`
- deployment should not re-send user pushes as a side effect of restart

## Useful validation commands

- `gh run view <run-id> --log-failed`
- `ssh ALi3 "cd /var/www/redfi-invest-agent && bash scripts/deploy_server.sh deploy"`
- `ssh ALi3 "cd /var/www/redfi-invest-agent && DEPLOY_FORCE_FAIL_AFTER_RESTART=1 bash scripts/deploy_server.sh deploy"`
- `ssh ALi3 "curl -fsS http://127.0.0.1:8009/api/health"`
- `ssh ALi3 "curl -fsS http://127.0.0.1:8009/api/hot-topics/us-signal/raw"`

