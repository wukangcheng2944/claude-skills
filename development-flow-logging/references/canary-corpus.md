# Canary Corpus

Use a fixed canary corpus to test whether revised logging actually improves diagnosis.

## Corpus Row Format

Each canary case should capture:

- `id`
- `language`
- `scenario`
- `symptom`
- `why_baseline_failed`
- `expected_localization`
- `minimum_must_log`

## Starter Canary Cases

### CANARY-001

- `language`: Python
- `scenario`: API request parsing
- `symptom`: request returns 500 after partial payload validation
- `why_baseline_failed`: only "request failed" was logged
- `expected_localization`: parser function, invalid field name, validation branch
- `minimum_must_log`: handler entry, payload summary, validation step, branch reason, exception context

### CANARY-002

- `language`: TypeScript
- `scenario`: queue worker dedup skip
- `symptom`: job silently skipped and user thinks it never ran
- `why_baseline_failed`: worker only logged start and finish
- `expected_localization`: dedup function, cache key, skip reason
- `minimum_must_log`: job id, dedup checkpoint, key summary, skip branch, final status

### CANARY-003

- `language`: Go
- `scenario`: outbound HTTP timeout
- `symptom`: downstream enrichment is empty but process exits successfully
- `why_baseline_failed`: timeout hidden behind generic warning
- `expected_localization`: client call, remote resource, timeout boundary, fallback branch
- `minimum_must_log`: request target, timeout config, retry count, fallback decision, elapsed time

### CANARY-004

- `language`: Java
- `scenario`: scheduler window bug
- `symptom`: job runs at the wrong time after timezone conversion
- `why_baseline_failed`: only "job started" was logged
- `expected_localization`: schedule calculation function, timezone input, computed window
- `minimum_must_log`: scheduler trigger time, source timezone, normalized timezone, selected window

### CANARY-005

- `language`: Rust
- `scenario`: retry loop overcompensates
- `symptom`: same external call repeats too many times and hides root cause
- `why_baseline_failed`: retries logged without per-attempt reason
- `expected_localization`: retry controller, attempt number, stop condition, terminal error
- `minimum_must_log`: attempt counter, retry predicate, last error class, final stop reason

### CANARY-006

- `language`: C
- `scenario`: file write partial success
- `symptom`: output file exists but content is truncated
- `why_baseline_failed`: success inferred from file open only
- `expected_localization`: write call, expected bytes, actual bytes, fail branch
- `minimum_must_log`: file path, bytes requested, bytes written, errno summary, cleanup result

### CANARY-007

- `language`: C++
- `scenario`: wrong branch inside pricing or signal logic
- `symptom`: output looks valid but path chosen was incorrect
- `why_baseline_failed`: values logged, branch reason not logged
- `expected_localization`: decision function, compared values, selected branch reason
- `minimum_must_log`: decision inputs summary, threshold, selected branch, reason

### CANARY-008

- `language`: C#
- `scenario`: DB update reported as success but no row changed
- `symptom`: UI shows saved state but database remains unchanged
- `why_baseline_failed`: only command success was logged
- `expected_localization`: update call, target id, affected rows, no-op branch
- `minimum_must_log`: target entity, mutation summary, affected row count, follow-up decision

### CANARY-009

- `language`: PHP
- `scenario`: cache fallback hides stale data path
- `symptom`: page loads, but data is old and source of truth was not queried
- `why_baseline_failed`: cache hit logged without freshness context
- `expected_localization`: cache read, stale detection branch, fallback suppression reason
- `minimum_must_log`: cache key, age summary, freshness decision, source-of-truth branch

### CANARY-010

- `language`: Shell
- `scenario`: deploy rollback path
- `symptom`: deploy fails and rollback state is unclear
- `why_baseline_failed`: script printed steps but not release id or rollback target
- `expected_localization`: failing step, target release, rollback release, rollback outcome
- `minimum_must_log`: release id, step name, exit code, rollback target, final health result

## Maintenance Rules

Keep the corpus useful:

1. prefer real incidents over invented cases
2. keep each case short and specific
3. replace weak examples when better real failures appear
4. do not let all cases collapse into one language or one scenario
5. reuse the same cases when comparing logging revisions so improvements are measurable
