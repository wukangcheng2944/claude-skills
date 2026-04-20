# CI and PR Integration

Use this guide when the logging review protocol needs to become part of day-to-day development instead of an optional afterthought.

## When To Trigger Review

Require a logging review when a PR touches:

- request handlers
- worker consumers
- scheduler logic
- external API clients
- DB write paths
- migrations
- deploy or rollback automation
- retry loops
- feature-flagged branches with materially different behavior

## PR Expectations

Each logging-sensitive PR should include a short note with:

- `logging_impact`: yes or no
- `review_mode`: code_first, logs_first, or incident_first
- `score_summary`: current total or `not_scored`
- `canary`: existing id, new id, or `none`
- `verification`: happy path, failure path, or both

## Suggested PR Snippet

```md
## Logging Review
- logging_impact: yes
- review_mode: code_first
- score_summary: 31/40
- canary: CANARY-010
- verification: failure_path
- note: rollback target and final health result are now logged explicitly
```

## CI Gate Strategy

Start with soft gates:

1. fail if a logging-sensitive PR has no logging review note
2. fail if required canary or verification fields are missing
3. warn when score regresses
4. warn when `DEBUG=true` changes add obvious noisy dumps

Only later consider hard gates:

1. block if score falls below the team floor
2. block if the same canary remains `not_localizable`
3. block if sensitive values appear in logs

## Rollout Rule

Adopt gates in this order:

1. metadata required
2. review output standardized
3. regression warnings enabled
4. hard blocking on repeated failures only after the corpus is stable

This prevents fake precision before the review system has enough good canaries.
