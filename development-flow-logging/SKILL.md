---
name: development-flow-logging
description: Add and refine detailed development and debugging logs across mainstream languages so AI can pinpoint failures to the exact function, branch, external call, mutation, or timing boundary. Use when implementing or debugging Python, JavaScript, TypeScript, Go, Java, Kotlin, Rust, C, C++, C#, PHP, Shell, APIs, workers, scripts, migrations, or tests that need DEBUG-gated function-level observability.
---

# Development Flow Logging

## Purpose

Use this skill when code needs richer observability during development, debugging, stabilization, or regression hunting.

This skill is intentionally cross-language.
It should work for:
- Python
- JavaScript and TypeScript
- Go
- Java and Kotlin
- Rust
- C and C++
- C#
- PHP
- Shell scripts

The goal is simple:
- every important execution path should leave a readable trail
- AI should be able to locate the failing function or branch in one pass
- verbose logs should be controlled by `DEBUG`, not left permanently noisy

This skill is for application code, scripts, workers, schedulers, migrations, tests, and local tools.

## Cross-Language Rules

1. Treat logs as diagnostic infrastructure.
   - Do not add vague `print("here")`, `console.log("x")`, or equivalent temporary markers.
   - Add logs that explain state, decision, and effect.

2. Instrument at function or routine granularity when debugging.
   - Every important function, method, handler, routine, or script step should log entry, exit, failure, and key checkpoints.

3. Use `DEBUG` to control verbosity.
   - `DEBUG=false` or unset: keep normal operational logs concise.
   - `DEBUG=true`: enable function-level and branch-level diagnostics.

4. Prefer native logging primitives for the stack.
   - Extend the logging framework already idiomatic for that language.
   - Do not force one language's logging style onto another stack.

5. Prefer structured logs.
   - Include fields instead of burying everything in prose when the language stack allows it.

6. Never log secrets.
   - Redact tokens, passwords, cookies, private keys, full auth headers, or raw PII.

## When To Apply

Use this skill for:
- "why is this request failing"
- "why did this worker skip data"
- "help me debug this function"
- "add full logs around this flow"
- "make this easier for AI to diagnose"
- "add DEBUG logging"
- "instrument every step"
- "make this logging standard reusable across languages"

## Logging Standard

At minimum, detailed debug logging should answer:

1. Which function or routine ran?
2. With what sanitized inputs?
3. Which branch or decision path was taken?
4. Which dependency or external call ran next?
5. What data shape changed?
6. How long did it take?
7. Where exactly did it fail?

Recommended fields:
- `module`
- `function`
- `request_id` or `trace_id`
- `step`
- `branch`
- `elapsed_ms`
- `record_count`
- `resource`
- `status`
- `summary`

## Workflow

### 1. Map the flow first

Before editing code:
- identify the entrypoint
- identify the critical downstream functions
- identify external boundaries such as DB, cache, HTTP, queue, file system, or subprocesses
- identify the mutation points and return boundaries

Do not spray logs randomly. Instrument the path intentionally.

### 2. Pick the native logging shape for the language

Use the stack's native or already-adopted logging layer.

Examples:
- Python: `logging`, `structlog`, existing app logger
- JavaScript or TypeScript: `pino`, `winston`, existing logger, or a thin wrapper if none exists
- Go: `slog`, `zap`, `logrus`, or existing wrapper
- Java or Kotlin: `SLF4J` with project-standard backend
- Rust: `tracing` or `log`
- C#: `ILogger`
- PHP: `Monolog` or project-standard logger
- Shell: thin `log_debug` and `log_info` helpers

Read `references/language-mapping.md` before choosing implementation details for a specific stack.

### 3. Define the DEBUG switch

Use one explicit switch:
- environment variable `DEBUG`
- config field derived from `DEBUG`
- logger level tied to `DEBUG`

Rules:
- `DEBUG=true` should enable verbose developer logs
- normal production or routine runs should not emit full function chatter
- the switch behavior must be documented close to the logger setup
- normalize `DEBUG` once instead of scattering ad hoc checks

Read `references/debug-switch-patterns.md` for language-aware DEBUG patterns.

### 4. Add function-level diagnostics

For each important function or routine, add:

1. entry log
   - function name
   - sanitized arguments or argument summary
   - correlation id if available

2. checkpoint logs
   - before external calls
   - after external calls
   - after parsing, filtering, dedup, mapping, branching, or persistence

3. exit log
   - success status
   - result summary
   - elapsed time

4. exception log
   - exception type
   - exception message
   - current step or branch
   - key local context that explains the failure

### 5. Log decisions, not just events

Always log why the code chose a branch when that choice affects behavior.

Examples:
- why a record was skipped
- why a retry was triggered
- why fallback logic was used
- why a feature flag path was selected
- why a migration step was not applied

If an AI still has to infer the reason from raw values, the log is too weak.

### 6. Instrument boundaries

Detailed logs are mandatory around:
- HTTP requests and responses
- DB reads and writes
- cache hits and misses
- file reads and writes
- subprocess calls
- message queue publish or consume
- migration steps
- scheduler dispatch decisions

Log summaries, counts, ids, and timing.
Do not log secret payloads blindly.

### 7. Keep the log trail compressible

Verbose does not mean chaotic.

Prefer:
- one clear line per checkpoint
- stable field names
- consistent function names
- short summaries with structured context

Avoid:
- dumping huge objects repeatedly
- printing the same state at every line
- hiding the failing step inside multiline noise

### 8. Validate the logs

After instrumentation:
- run the happy path once
- run a known failing or edge path once
- confirm the failing function and failing checkpoint are obvious from logs alone
- confirm `DEBUG=false` reduces noise as intended
- confirm the chosen implementation matches the idioms of the language

If AI still needs to guess, improve the logs.

## Function Checklist

Apply this checklist to every critical function during debug instrumentation:

1. entry log present
2. sanitized inputs present
3. branch decision logs present
4. external boundary logs present
5. mutation logs present
6. success exit log present
7. exception log present
8. elapsed time present
9. DEBUG gating correct
10. no secrets leaked
11. implementation fits the language stack

Read `references/function-checklist.md` for a compact per-function template.
Read `references/log-contract.md` for the standard field contract.
Read `references/debug-switch-patterns.md` for DEBUG gating guidance.
Read `references/language-mapping.md` for stack-specific logging choices.

## Patterns

### Normal mode

Keep:
- startup summary
- high-level operations
- warnings
- errors
- final outcome

### DEBUG mode

Add:
- function entry and exit
- argument summaries
- branch choice logs
- dependency call logs
- record counts and filtered counts
- timing for expensive operations
- stack-aware exception context

## Continuous Optimization

This skill should keep improving from real debugging sessions across different stacks.

After each incident:
1. record which missing log would have made diagnosis immediate
2. tighten the checklist or references
3. add a better example pattern for that language or failure type
4. remove noisy logs that did not help diagnosis
5. update the language mapping if a stack-specific gap was discovered

The standard is not "more logs".
The standard is "AI can isolate the exact failing function and step immediately".
