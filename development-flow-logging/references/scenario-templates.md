# Scenario Templates

Use these on top of the language templates.

Each scenario defines the extra checkpoints that make failures obvious in that kind of flow.

## 1. Generic Function Flow

Use when the code is mostly local logic.

Required checkpoints:
- entry
- input summary
- branch decision
- transformation summary
- exit
- exception

Minimal shape:

```text
DEBUG function=<name> step=entry status=start
DEBUG function=<name> step=branch branch=<chosen-path> status=ok
DEBUG function=<name> step=transform record_count=<n> status=ok
INFO  function=<name> status=ok elapsed_ms=<n>
ERROR function=<name> status=fail step=<failing-step> error=<message>
```

## 2. Web or API Request Flow

Use for controllers, routes, handlers, and API middleware boundaries.

Required checkpoints:
- request entry
- caller or auth summary
- validated payload summary
- outbound dependency call
- response status
- exception with request id

Recommended fields:
- `request_id`
- `path`
- `method`
- `caller`
- `http_status`

Minimal shape:

```text
DEBUG function=<handler> step=request-entry request_id=<id> path=<path> method=<method> status=start
DEBUG function=<handler> step=validate-payload request_id=<id> status=ok
DEBUG function=<handler> step=call-dependency request_id=<id> resource=<service> status=start
INFO  function=<handler> request_id=<id> http_status=<code> status=ok elapsed_ms=<n>
ERROR function=<handler> request_id=<id> step=<failing-step> status=fail error=<message>
```

## 3. Worker or Queue Consumer Flow

Use for async jobs, consumers, background processors, and retry loops.

Required checkpoints:
- dequeue
- job payload summary
- dependency or mutation step
- ack or completion
- retry or dead-letter decision
- terminal failure

Recommended fields:
- `job_id`
- `message_id`
- `attempt`
- `queue`
- `retry`

Minimal shape:

```text
DEBUG function=<worker> step=dequeue queue=<queue> job_id=<id> attempt=<n> status=start
DEBUG function=<worker> step=process job_id=<id> status=start
DEBUG function=<worker> step=retry-decision job_id=<id> retry=<true|false> status=ok
INFO  function=<worker> step=ack job_id=<id> status=ok elapsed_ms=<n>
ERROR function=<worker> step=<failing-step> job_id=<id> attempt=<n> status=fail error=<message>
```

## 4. Scheduler or Cron Flow

Use for timed jobs, dispatch windows, polling loops, and idempotent scheduled tasks.

Required checkpoints:
- trigger start
- run window calculation
- dedup or replay prevention
- dispatch summary
- completion summary
- failure summary

Recommended fields:
- `run_id`
- `window_start`
- `window_end`
- `dispatch_count`
- `skipped_count`

Minimal shape:

```text
DEBUG function=<job> step=trigger run_id=<id> status=start
DEBUG function=<job> step=compute-window run_id=<id> window_start=<ts> window_end=<ts> status=ok
DEBUG function=<job> step=dedup run_id=<id> skipped_count=<n> status=ok
INFO  function=<job> run_id=<id> dispatch_count=<n> status=ok elapsed_ms=<n>
ERROR function=<job> run_id=<id> step=<failing-step> status=fail error=<message>
```

## 5. DB Write or Migration Flow

Use for transaction-heavy writes, schema changes, and persistence paths.

Required checkpoints:
- transaction or migration start
- statement or migration identity
- changed row or object count
- commit
- rollback
- terminal failure

Recommended fields:
- `database`
- `transaction_id`
- `migration`
- `row_count`

Minimal shape:

```text
DEBUG function=<name> step=begin-transaction database=<db> status=start
DEBUG function=<name> step=apply-change database=<db> row_count=<n> status=ok
INFO  function=<name> step=commit database=<db> status=ok elapsed_ms=<n>
WARN  function=<name> step=rollback database=<db> status=start
ERROR function=<name> step=<failing-step> database=<db> status=fail error=<message>
```

## 6. External HTTP or RPC Call Flow

Use for service-to-service calls, SDK boundaries, and flaky dependency paths.

Required checkpoints:
- outbound request intent
- sanitized target summary
- retry or fallback decision
- response status or timeout
- final success or failure

Recommended fields:
- `resource`
- `target`
- `attempt`
- `http_status`
- `timeout_ms`

Minimal shape:

```text
DEBUG function=<name> step=outbound-start target=<target> resource=<resource> attempt=<n> status=start
DEBUG function=<name> step=retry-decision target=<target> attempt=<n> retry=<true|false> status=ok
INFO  function=<name> step=outbound-finish target=<target> http_status=<code> status=ok elapsed_ms=<n>
ERROR function=<name> step=outbound-fail target=<target> attempt=<n> status=fail error=<message>
```

## How To Use These

1. copy the matching language template
2. add the checkpoints from the chosen scenario
3. rename fields to match repo conventions
4. validate that `DEBUG=false` stays concise
5. validate that `DEBUG=true` exposes the exact failing step
