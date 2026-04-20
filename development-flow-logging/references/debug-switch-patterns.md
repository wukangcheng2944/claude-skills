# DEBUG Switch Patterns

## Goal

`DEBUG` should enable deep diagnostics without forcing noisy logs in every normal run.

## Rules

1. Normalize `DEBUG` once near config bootstrap.
2. Reuse that boolean everywhere.
3. Tie logger level or verbose helper behavior to that boolean.
4. Avoid ad hoc string checks scattered across modules.

## Generic Pattern

```text
DEBUG=false   -> info/warn/error only
DEBUG=true    -> debug/info/warn/error with function-level diagnostics
```

## Guidance

- If the codebase already has a logger abstraction, extend it.
- If the codebase has no logger abstraction, add the thinnest helper that supports consistent fields and DEBUG gating.
- If a function is on a hot path, keep heavy object serialization behind DEBUG.
- If the team already uses JSON logs, keep the same format instead of introducing a second style.
