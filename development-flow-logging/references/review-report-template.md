# Review Report Template

Use this template when auditing logs, code instrumentation, or a canary-driven rewrite.

## Human-Readable Form

```md
# Logging Review Report

## Scope
- target:
- language:
- scenario:
- review_mode: code_first | logs_first | incident_first
- debug_mode_checked: true | false

## Current Score
- total:
- localizability:
- step_precision:
- boundary_visibility:
- branch_explainability:
- signal_to_noise_ratio:
- debug_discipline:
- safety:
- outcome_quality:

## Findings
1. [severity] short statement of the main localization failure
2. [severity] short statement of the next blocking weakness
3. [severity] optional additional weakness

## Minimum Rewrite Plan
1. add or improve:
2. remove or compress:
3. verify with:

## Canary Impact
- canary_case:
- before_latency:
- target_latency:
- canary_case_needed: yes | no

## Decision
- keep:
- revisit_after:
- note:
```

## Compact Form

Use this when the output needs to stay short but comparable:

```md
scope=worker_dedup score=27/40 latency=multiple_guesses
top_failures=missing_skip_reason,silent_cache_boundary,repetitive_finish_log
rewrite_plan=add_dedup_branch_reason+log_cache_key_summary+compress_finish_log
verify_with=failure_path canary=CANARY-002 decision=revise
```

## Writing Rules

1. findings must name the localization failure, not just say "logs are weak"
2. rewrite plan must be minimum viable change, not a full rewrite by default
3. canary impact must stay tied to one fixed case when possible
4. decision must be one of `keep`, `revise`, `revert`, `needs_more_data`
