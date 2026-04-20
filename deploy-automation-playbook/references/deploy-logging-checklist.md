# Deploy Logging Checklist

Use this reference when writing or reviewing deploy scripts, CI jobs, or rollback handlers.

## Goal

A deploy log stream should let an AI or engineer answer these questions immediately:

1. Which deployment is this?
2. Which phase is running now?
3. Which exact step failed?
4. What target ref, host, service, or database was involved?
5. What rollback point is available?
6. Did rollback start, succeed, or fail?

## Minimum Log Contract

Each deploy step should log these fields when possible:

- `deploy_id`
- `phase`
- `step`
- `status`
- `target_ref`
- `host`
- `service`
- `elapsed_ms`
- `summary`

Recommended optional fields:

- `database`
- `backup_id`
- `migration`
- `attempt`
- `retry_limit`
- `exit_code`
- `http_status`
- `artifact`

## Required Phase Coverage

At minimum, emit logs for:

1. `preflight`
   - config load
   - parameter validation
   - network checks
   - permission checks

2. `backup`
   - code rollback point capture
   - PostgreSQL dump or snapshot
   - SQLite or file-state backup

3. `checkout`
   - remote fetch
   - ref resolution
   - exact target commit checkout

4. `build`
   - dependency install
   - image build
   - artifact packaging

5. `migrate`
   - migration plan
   - schema change start
   - schema change finish

6. `restart`
   - service stop
   - service start
   - compose or process status check

7. `healthcheck`
   - lightweight health endpoint
   - smoke endpoint
   - retry loop outcome

8. `rollback`
   - trigger reason
   - code restore
   - database restore
   - restart after restore
   - final status

## Example Log Shape

```text
INFO deploy_id=20260420-074655 phase=backup step=pg_dump status=start database=redfi summary="start PostgreSQL backup"
INFO deploy_id=20260420-074655 phase=backup step=pg_dump status=ok backup_id=pg-20260420-074655 elapsed_ms=4210 summary="PostgreSQL backup completed"
ERROR deploy_id=20260420-074655 phase=migrate step=alembic-upgrade status=fail migration=20260420_add_signal_cache exit_code=1 summary="migration failed on apply"
WARN deploy_id=20260420-074655 phase=rollback step=restore-code status=start target_ref=c21bc65 summary="restoring previous commit"
INFO deploy_id=20260420-074655 phase=rollback step=restore-db status=ok backup_id=pg-20260420-074655 elapsed_ms=6120 summary="database restored"
```

## Common Failures to Expose Explicitly

Always log these as dedicated steps, not generic exceptions:

- SSH alias not found
- DNS resolve failure
- remote host timeout
- git fetch failure
- branch/ref mismatch
- image build failure
- migration failure
- service start failure
- health endpoint timeout
- smoke check data error
- rollback restore failure

## Anti-Patterns

Do not:

- emit only one final `deploy failed`
- hide the failing command or phase
- overwrite the original failure reason during rollback
- omit which backup or commit is being restored
- print secrets just to get more detail
