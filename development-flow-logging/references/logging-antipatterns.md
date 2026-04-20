# Logging Antipatterns

Use this file when reviewing existing logs.

These are the patterns that create noise, hide causality, or force AI to guess.

## 1. Marker Logs

Bad:

```text
here
got data
x
before call
after call
```

Why it fails:
- no function name
- no step identity
- no data summary
- no failure boundary

Fix:
- replace markers with named checkpoints and structured context

## 2. Generic Failure Logs

Bad:

```text
request failed
db error
deploy failed
worker exception
```

Why it fails:
- symptom only
- no failing function
- no failing step
- no resource or id

Fix:
- include function, step, resource, and exception context

## 3. Giant Object Dumps

Bad:
- dump the full payload or full ORM object at every step

Why it fails:
- hides the useful signal inside noise
- increases token and storage cost
- often leaks secrets or PII

Fix:
- log counts, ids, keys, selected fields, and shape summaries

## 4. Repeated Identical Logs

Bad:
- same message in every loop iteration with no changing fields

Why it fails:
- creates volume without localization
- makes the real failing line harder to spot

Fix:
- log only when the state changes or attach the differentiating fields

## 5. Missing Branch Reason

Bad:

```text
record skipped
fallback used
retrying
```

Why it fails:
- the event is visible but the cause is hidden

Fix:
- log the condition that triggered the branch

## 6. Silent Boundaries

Bad:
- local code logs exist, but external HTTP, DB, cache, queue, file, or subprocess boundaries are silent

Why it fails:
- the failure surface is exactly where the logs disappear

Fix:
- log boundary start, boundary finish, and timeout or failure reason

## 7. Loud Normal Mode

Bad:
- `DEBUG=false` still emits function-level chatter

Why it fails:
- operators stop reading logs because everything is noisy
- important warnings blend into debug chatter

Fix:
- keep detailed path logs behind `DEBUG`

## 8. Weak Exception Context

Bad:

```text
error: timeout
```

Why it fails:
- no function
- no step
- no target
- no attempt count

Fix:
- log exception with current step, target resource, and local identifiers

## 9. Cross-Language Copy-Paste

Bad:
- copy one language's logging style verbatim into a codebase with different conventions

Why it fails:
- breaks consistency
- developers ignore or bypass the new logs

Fix:
- preserve the stack's logger, field names, and formatting style

## 10. Useless Success Logs

Bad:
- success logs with no timing, count, or outcome summary

Why it fails:
- they confirm nothing meaningful

Fix:
- include elapsed time and result summary
