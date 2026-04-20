# DEBUG Switch Patterns

## Goal

`DEBUG` should enable deep diagnostics without forcing noisy logs in every normal run.

## Cross-Language Rules

1. Normalize `DEBUG` once near config bootstrap.
2. Reuse that boolean or derived logger level everywhere.
3. Tie logger verbosity or verbose helper behavior to that value.
4. Avoid ad hoc string checks scattered across modules.
5. Keep expensive serialization and giant object dumps behind `DEBUG`.

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

## Language Notes

### Python

- Normalize `DEBUG` in config or settings once.
- Prefer logger level changes over scattered `if DEBUG:` branches when possible.
- Use `logger.exception(...)` or equivalent for failure paths.

### JavaScript and TypeScript

- In Node services, prefer the app logger or a thin wrapper around the existing logger.
- In browser code, gate noisy diagnostics to avoid console spam in normal flows.
- If the app uses build-time envs, document how `DEBUG` is read.

### Go

- Prefer a logger instance configured once at startup.
- Pass logger context or derive child loggers rather than re-reading env vars per function.

### Java and Kotlin

- Set debug level at configuration or bootstrap time.
- Keep MDC or correlation context consistent across request and worker boundaries.

### Rust

- Prefer subscriber or filter configuration once at startup.
- Keep field names stable across `tracing` spans and events.

### C#

- Prefer the application's existing `ILogger` pipeline.
- Use scope or correlation context instead of handwritten prefixes when available.

### PHP

- Normalize `DEBUG` in bootstrap or container config.
- Reuse the same logger service instead of constructing ad hoc loggers.

### Shell

- Convert `DEBUG` to a simple flag once.
- Route all verbose output through one helper such as `log_debug`.
