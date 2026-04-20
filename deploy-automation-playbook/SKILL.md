---
name: deploy-automation-playbook
description: Build and harden automatic deployment workflows for apps and servers, especially self-hosted CI/CD, server-side pull/build deploys, rollback-capable deploy scripts, database backup and restore, branch safety rules, and high-availability guardrails. Use when Codex needs to design, review, or modify deployment automation, GitHub or GitLab self-hosted runners, release branches, health checks, failure rollback, or operational runbooks.
---

# Deploy Automation Playbook

## Quick Start

1. Determine the network topology before writing any CI/CD code.
   - If the target server can reach the source repo, prefer server-side pull and build.
   - If the target server cannot reach the repo but a local machine can, put a self-hosted runner on the reachable machine and let it SSH into the target.
   - Do not put a runner on a server that cannot reach the source of truth and then expect `git fetch` to work.

2. Separate branch roles.
   - Keep one deployment branch such as `deploy` for automatic rollout.
   - Keep `main` and `master` as storage branches unless the user explicitly wants live deployment from them.
   - Require explicit confirmation before pushing any branch that is known to auto-deploy or has production significance.

3. Keep the workflow thin and put deployment intelligence in repo scripts.
   - CI should mostly validate, check out code, and call a repo-owned deploy script.
   - Put backup, rollback, health checks, and service restarts in the server-side deploy script.

## Workflow

### 1. Validate reachability

Check these paths first:
- source control to runner
- runner to target server over SSH
- target server to source control if the server must pull code
- target server to dependency mirrors or registries if images or wheels are built there

When any leg is broken, redesign the topology instead of adding retries.

### 2. Make deploys idempotent

Implement deploy scripts so rerunning the same version is safe:
- back up the current state before mutation
- fetch or check out the target ref deterministically
- build auxiliary wheels or artifacts in a temp location and swap them in only on success
- rebuild only the images or services that need to change
- restart the exact service set you intend to refresh

### 3. Add automatic rollback

A production-grade deploy script should:
- capture the current commit before updating code
- back up PostgreSQL before schema changes can happen
- back up SQLite or any file-backed state before service restart
- trap deployment failures and restore both code and database state
- rebuild and restart the old version after restoring the backups
- expose a forced-failure switch for rollback drills

Prefer restoring a full database backup instead of attempting ad hoc reverse migrations during incident handling.

### 4. Add health gates

Treat container startup as necessary but not sufficient.
Use all of these when possible:
- `docker compose ps` or equivalent service-state checks
- one lightweight HTTP health endpoint
- one smoke endpoint that touches real application data or the database
- bounded retry loops with clear timeout

A deploy is successful only after all health gates pass.

### 5. Handle self-hosted SSH safely

For Windows self-hosted runners, try connection methods in this order:
1. SSH alias already known to work on the machine
2. user-profile key such as `~/.ssh/id_rsa`
3. secret-injected temporary key

When using a temporary key:
- disable password fallback with `BatchMode=yes`
- set a connect timeout
- lock the file down before use
- on Windows service accounts, grant key access by SID instead of account name strings
- clean up the temp file after the deploy attempt

Do not let a bad SSH key hang a deployment indefinitely.

### 6. Protect business side effects

Deployment and restart logic must not trigger duplicate business actions.
Examples:
- scheduled push workers must not replay already due slots just because the container restarted
- dashboards must show operational timestamps in the business timezone, not the browser timezone
- notification or report dispatch should be recorded so retries remain idempotent

## Red Flags

Do not:
- mutate schema before backups exist
- rely on GitHub-hosted runners for private network access unless that path is proven
- treat branch pushes and deploy approvals as the same thing
- depend on container start alone as proof of application health
- leave rollback untested

## Repo-Specific Guidance

When the repo already contains deployment scripts, extend those instead of splitting logic across CI YAML and ad hoc shell snippets.
For the RedFi pattern used here:
- GitHub `deploy` is the automatic deployment branch
- GitHub and GitLab `main` or `master` are storage branches by default
- `ma_club` `master` requires explicit confirmation before push
- scheduler code must preserve Beijing-time behavior and avoid duplicate pushes after restart

## References

Read `references/redfi-self-hosted-github.md` for the self-hosted GitHub pattern used in this environment.
Read `references/rollback-ha-checklist.md` when adding rollback, health checks, and high-availability guardrails.

