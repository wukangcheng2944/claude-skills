# Deploy Agent Handoff

Use this contract when a deployment review, failure summary, rollback summary, or incident note needs to guide the next agent directly.

## Goal

The output should let the next agent move immediately to the most likely failing deploy boundary.

A valid handoff must answer:
- what is the smallest plausible failing scope
- what target is implicated
- what evidence supports that scope
- what should be checked next
- what the rollback state is

## Required Fields

- `suspected_scope`
- `target`
- `strongest_evidence`
- `next_best_action`
- `next_target`
- `rollback_state`
- `confidence`

## Field Guidance

### `suspected_scope`

Smallest plausible deploy boundary.

Examples:
- `preflight -> repo reachability`
- `checkout -> git fetch origin deploy`
- `migrate -> alembic upgrade head`
- `restart -> docker compose up api`
- `healthcheck -> smoke endpoint`
- `rollback -> restore PostgreSQL backup`

### `target`

The concrete deployment object implicated.

Examples:
- `ALi3`
- `api service on ALi3`
- `target_ref=deploy@c21bc65`
- `database=redfi`
- `backup_id=pg-20260420-074655`

### `strongest_evidence`

Best current evidence from logs or structure.

Examples:
- DNS resolve failed before any SSH negotiation started
- migration step failed after backup succeeded and before restart began
- rollback restored code but DB restore never reached `ok`

### `next_best_action`

Single highest-value next move.

Allowed shapes:
- `open code`
- `inspect remote logs`
- `rerun one probe`
- `verify backup artifact`
- `compare deployed ref`
- `check service state`
- `check DB state`

### `next_target`

Concrete place to inspect next.

Examples:
- `scripts/deploy_server.sh::run_migrations`
- `ALi3:/var/www/redfi-invest-agent/logs/deploy.log`
- `docker compose ps api`
- `pg backup pg-20260420-074655`

### `rollback_state`

One of:
- `not_needed`
- `pending`
- `started`
- `code_restored`
- `db_restored`
- `completed`
- `failed`
- `unknown`

### `confidence`

One of:
- `high`
- `medium`
- `low`

## Compact Example

```md
suspected_scope=migrate -> alembic upgrade head
target=ALi3 database=redfi target_ref=deploy@c21bc65
strongest_evidence=backup completed and migrate failed before any restart step
next_best_action=open code
next_target=scripts/deploy_server.sh::run_migrations
rollback_state=pending
confidence=high
```

## Rules

1. keep the scope as small as the evidence allows
2. name one best next action unless blocked
3. rollback state must be explicit, never implied
4. if confidence is low, say which missing log or probe would raise it
