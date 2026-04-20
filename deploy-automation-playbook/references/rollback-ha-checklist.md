# Rollback and High-Availability Checklist

## Before deploy

- verify the target server can reach every dependency it must pull during deploy
- verify the runner can SSH to the target with a non-interactive key path
- capture the current git commit on the target
- dump PostgreSQL before any service restart can trigger migrations
- back up SQLite or file-backed state before stopping services
- keep previous vendor wheels or generated artifacts until replacements succeed

## During deploy

- update code deterministically to the target ref
- build in temp directories where possible
- restart only the intended services
- wait for service readiness instead of assuming immediate availability
- run at least one HTTP health endpoint and one DB-backed smoke check

## On failure

- stop app services before DB restore
- restore PostgreSQL backup
- restore SQLite or file-backed data backup
- restore the previous commit in the worktree
- rebuild the previous image version
- restart the previous service set
- rerun health checks and report whether rollback is healthy

## Rollback drills

Use a forced-failure switch to test rollback safely:
- keep the target ref equal to the current deployed ref when possible
- force a failure after restart so rollback restores the same commit and DB state
- confirm services are healthy after rollback
- check that no duplicate scheduled pushes or user notifications were sent during the drill

## High-availability rules of thumb

- prefer idempotent deploys over clever one-shot scripts
- keep branch safety rules explicit and separate from deployment rules
- protect auto-live branches from casual pushes
- keep health checks fast, real, and deterministic
- test rollback regularly, not only after a production incident
- pin operational timestamps to the business timezone when operators or users read them

