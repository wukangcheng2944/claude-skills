# Language Mapping

Use this reference to translate the skill's logging contract into the idioms of the current stack.

## Shared Intent

No matter the language, the implementation should provide:
- function or routine entry logs
- checkpoint logs
- exit logs
- exception or failure logs
- `DEBUG`-gated verbosity
- structured fields when feasible

## Python

Preferred tools:
- `logging`
- `structlog`
- existing app logger

Typical adaptation:
- `module` -> `__name__`
- `function` -> function name
- `status` and `step` -> `extra` fields or structured logger fields
- failure path -> `logger.exception(...)`

## JavaScript and TypeScript

Preferred tools:
- `pino`
- `winston`
- existing logger
- minimal wrapper if none exists

Typical adaptation:
- structured object as first argument
- `function`, `step`, `status`, `elapsed_ms` as fields
- `DEBUG` controls `debug` calls or logger level

Browser note:
- avoid flooding the console on render-heavy paths
- use the same principles for async actions, data fetches, and user-triggered flows

## Go

Preferred tools:
- `slog`
- `zap`
- `logrus`
- existing logger wrapper

Typical adaptation:
- structured key/value pairs on every important call
- `elapsed_ms` from explicit timers
- `DEBUG` controls logger level or handler configuration

## Java and Kotlin

Preferred tools:
- `SLF4J`
- project-standard backend such as Logback or Log4j2

Typical adaptation:
- stable message plus structured arguments or MDC where supported
- request correlation through MDC
- method-level debug logs gated by logger config

## Rust

Preferred tools:
- `tracing`
- `log`

Typical adaptation:
- use spans or event fields for `function`, `step`, and `status`
- attach timing and resource ids as fields
- configure verbosity centrally

## C and C++

Preferred tools:
- the project's existing logger
- a thin wrapper around `fprintf`, `printf`, or stream output if no logger exists
- lightweight logging macros for `DEBUG`, `INFO`, `WARN`, `ERROR`

Typical adaptation:
- use one shared header or logging utility instead of ad hoc prints
- include function name, step, status, and elapsed time in macro arguments or helper calls
- gate verbose diagnostics through compile-time flags, runtime `DEBUG`, or both
- keep error-path context explicit around system calls, file IO, sockets, threads, and external libraries

Notes:
- in C, prefer small logging helpers or macros over scattered direct prints
- in C++, prefer the repo's logger or a thin RAII-safe wrapper if one already exists
- if the codebase uses compile-time debug flags, document how they relate to runtime `DEBUG`

## C#

Preferred tools:
- `ILogger`
- existing application logging pipeline

Typical adaptation:
- named message templates with stable field names
- scopes for request or operation context
- `DEBUG` controls logger filter level

## PHP

Preferred tools:
- `Monolog`
- framework logger

Typical adaptation:
- structured context array for `function`, `step`, `status`, `resource`
- bootstrap-level `DEBUG` control

## Shell

Preferred pattern:
- small helpers like `log_debug`, `log_info`, `log_warn`, `log_error`

Typical adaptation:
- `DEBUG` determines whether `log_debug` emits
- always include script function or step name
- log command intent before running risky external calls

## Selection Rule

When editing code, choose the smallest change that matches the existing language stack.

If the user asks for starter code, use `language-templates.md` first and then adapt it to repo conventions.

Do:
- extend the existing logger
- preserve project conventions
- keep field names stable

Do not:
- introduce a brand-new logging framework unless the user asked for it
- force JSON logs into a project that already uses readable text logs without a reason
- copy Python logging patterns into non-Python stacks verbatim
