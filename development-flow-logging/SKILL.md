---
name: development-flow-logging
description: Add, review, and iteratively optimize detailed development and debugging logs across mainstream languages so AI agents can pinpoint failures to the exact function, branch, external call, mutation, or timing boundary. Use when implementing or debugging Python, JavaScript, TypeScript, Go, Java, Kotlin, Rust, C, C++, C#, PHP, Shell, APIs, workers, scripts, migrations, or tests that need DEBUG-gated function-level observability, review existing logs, or turn incidents into reusable canary cases.
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
- AI agents should be able to locate the failing function or branch in one pass
- verbose logs should be controlled by `DEBUG`, not left permanently noisy

This skill is for application code, scripts, workers, schedulers, migrations, tests, and local tools.

This is an agent-first skill.
Its purpose is not just to make logs "better".
Its purpose is to help the next agent:
- narrow the search space quickly
- identify the likeliest failing file, function, branch, or boundary
- choose the next verification step without re-reading the whole system

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

7. Optimize for agent handoff, not just human readability.
   - Logs and review outputs should tell the next agent where to look next.
   - Good output reduces search space and proposes the next best check.
   - Weak output says "something is wrong" without naming the likeliest code boundary.

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
- "review these logs"
- "why are these logs still not enough"
- "refactor noisy or useless logs"
- "improve logs so AI can localize failures immediately"
- "score this logging"
- "turn this incident into a reusable canary"
- "build a logging review workflow"
- "make the review output structured"
- "define a machine-readable logging audit"
- "standardize logging score output"
- "wire this into CI"
- "make PR review enforce logging quality"
- "turn incidents into logging upgrades"
- "help the agent locate the bug faster"
- "make this agent-readable"
- "reduce the search space for the next agent"

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

## Agent-First Output Contract

Every serious review or logging rewrite should help the next agent answer:

1. what is the smallest plausible failing scope
2. what evidence supports that scope
3. what should be checked next
4. which file, function, or boundary should be opened next
5. how confident the handoff is

If the output cannot drive the next debugging move, it is incomplete.

Read `references/agent-localization-contract.md` for the normalized agent-handoff shape.

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
Read `references/language-templates.md` when you need a minimal copy-paste starter for the current language.

### 2.5 Pick the execution scenario

After choosing the language, choose the runtime scenario.

Common scenarios:
- generic function or utility flow
- Web or API request handling
- worker or queue consumer
- scheduler or cron job
- DB write or migration path
- external HTTP or RPC dependency

Rule:
- start from the language template
- layer one scenario template on top
- add repo-specific field names only after the base pattern is clear

Read `references/scenario-selector.md` to choose the scenario template quickly.
Read `references/scenario-templates.md` for reusable scenario-level log checkpoints.

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

### 9. Review and refactor existing logs

When logs already exist, do not assume they are useful.

Review them in this order:
1. can the failing function be identified immediately
2. can the failing checkpoint or branch be identified immediately
3. is the causal context present, not just the symptom
4. are repeated lines adding signal or just noise
5. does `DEBUG=false` stay readable
6. does `DEBUG=true` expose the exact path and boundary interactions

If the answer to 1 or 2 is no, the logging is still insufficient.

Read `references/logging-antipatterns.md` when reviewing bad or misleading logs.
Read `references/failure-library.md` when the current logs still force guessing.
Read `references/before-after-examples.md` for concrete rewrites from weak logs to diagnosable logs.
Read `references/review-rubric.md` to score whether the current logs are good enough for AI-driven debugging.
Read `references/log-review-workflow.md` when you need a repeatable way to audit existing code or log output.
Read `references/review-report-template.md` when the output needs a stable audit structure that humans and tools can both consume.
Read `references/agent-localization-contract.md` when the review result must explicitly guide the next agent action.

### 10. Build reusable canary cases

When a real incident exposes weak logging, do not just patch the code and move on.

Capture it as a reusable canary:
1. record the original symptom in one sentence
2. save the weak or misleading logs that slowed diagnosis
3. record the exact function, branch, boundary, or mutation that should have been obvious
4. rewrite the relevant logging pattern
5. add the case to a fixed canary set for future review

A canary case is good if:
- it represents a real failure mode
- the old logs looked plausible but were not enough
- the improved logs make the failing step obvious in one pass

Read `references/canary-corpus.md` for the corpus format and starter cases.
Read `references/canary-schema.md` when the canary set needs to be machine-readable and stable across iterations.

### 11. Use Darwin-style review loops

Do not optimize logging by taste alone.

Use a fixed review loop:
1. choose one logging weakness or hypothesis
2. compare baseline logs against the same canary cases
3. score the result with the review rubric
4. keep the change only if diagnosis becomes faster and more exact
5. revert or simplify if the change only adds noise

The point is not to maximize line count.
The point is to reduce diagnosis latency and ambiguity.

Read `references/darwin-optimization-loop.md` for the iteration rules.
Read `references/scoring-output-protocol.md` when the review result must be emitted in a consistent machine-readable format.
Read `references/agent-localization-contract.md` when the output must narrow the next agent's search space explicitly.

### 12. Integrate with PR and CI flows

Logging quality should not depend on memory or taste.

When a change touches one of these zones, require an explicit logging review:
- API handlers
- workers or queue consumers
- schedulers or cron paths
- DB mutations or migrations
- external HTTP or RPC boundaries
- deploy, rollback, or automation scripts

For each such change, record one of:
1. `no_logging_impact`
2. `logging_review_completed`
3. `canary_updated`
4. `existing_logs_sufficient`

Prefer a soft gate first:
- fail only on missing review metadata or obvious regression
- do not block on a perfect score at the start
- tighten the gate only after the team has stable canary coverage

Read `references/ci-pr-integration.md` for PR templates, CI gate patterns, and rollout rules.

### 13. Feed incidents back into the system

A production or staging incident should improve the logging standard, not just the code.

After each incident:
1. capture the symptom and the log gap
2. decide whether an existing canary already covers it
3. if not, add a new canary
4. update the review report or rewrite examples if the failure mode was novel
5. re-run the same review protocol so the gain is measurable

If postmortems do not change the canary set or review guidance, the skill will stagnate.

Read `references/incident-feedback-loop.md` for the incident-to-canary workflow.

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
Read `references/language-templates.md` for minimal copy-paste templates for every supported language.
Read `references/scenario-selector.md` for language + scenario composition rules.
Read `references/scenario-templates.md` for higher-level flow templates such as Web/API, worker, scheduler, DB mutation, and external call paths.
Read `references/logging-antipatterns.md` for bad patterns that look useful but block diagnosis.
Read `references/failure-library.md` for common failure types and the minimum logs needed to isolate them.
Read `references/before-after-examples.md` for concrete rewrites from weak logs to strong logs.
Read `references/review-rubric.md` to audit whether a logging implementation is actually AI-diagnosable.
Read `references/log-review-workflow.md` for a fixed review sequence when auditing existing logs or code.
Read `references/canary-corpus.md` for reusable canary incidents to test whether improved logging really helps.
Read `references/darwin-optimization-loop.md` for the change-compare-keep-or-revert loop.
Read `references/canary-schema.md` for the normalized canary record shape.
Read `references/review-report-template.md` for the expected audit output sections.
Read `references/scoring-output-protocol.md` for the normalized score payload.
Read `references/ci-pr-integration.md` for how to apply the review protocol in PR and CI flows.
Read `references/incident-feedback-loop.md` for how to turn real incidents into permanent logging improvements.
Read `references/example-artifacts.md` for end-to-end examples of the canary, report, score, and PR note outputs.
Read `references/agent-localization-contract.md` for the agent-facing handoff requirements.

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
6. add the failure to the failure library if the current references would not have predicted it
7. add a before/after rewrite if the original logs looked plausible but still slowed diagnosis
8. add or refresh a canary case when the incident exposed a repeatable blind spot
9. keep only logging changes that improve the rubric score or reduce diagnosis latency on the canary set
10. preserve the output format so later reviews can be compared automatically
11. push the best new incident pattern into PR and CI guidance so the gain is not lost
12. refresh example artifacts when the standard output format changes
13. prefer changes that help the next agent decide where to look next, not just changes that sound more descriptive

The standard is not "more logs".
The standard is "the next AI agent can isolate the exact failing function and step immediately".
