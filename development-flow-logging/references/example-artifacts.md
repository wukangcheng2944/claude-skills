# Example Artifacts

Use these examples when you need end-to-end reference outputs rather than isolated schemas.

## Example Canary Record

```json
{
  "id": "CANARY-010",
  "title": "deploy rollback target not visible",
  "language": "Shell",
  "scenario": "deploy_rollback",
  "symptom": "deploy failed and rollback state was unclear",
  "baseline_failure": "script printed steps but not release id or rollback target",
  "expected_localization": {
    "function": "rollback_release",
    "step": "switch_symlink",
    "branch": "health_check_failed",
    "boundary": "service_restart",
    "mutation": "active_release_pointer"
  },
  "minimum_must_log": [
    "release id",
    "step name",
    "exit code",
    "rollback target",
    "final health result"
  ],
  "diagnosis_latency_target": "immediate",
  "source": "real_incident"
}
```

## Example Review Report

```md
# Logging Review Report

## Scope
- target: deploy rollback path
- language: Shell
- scenario: deploy_rollback
- review_mode: code_first
- debug_mode_checked: true

## Current Score
- total: 30/40
- localizability: 4
- step_precision: 4
- boundary_visibility: 3
- branch_explainability: 4
- signal_to_noise_ratio: 4
- debug_discipline: 4
- safety: 4
- outcome_quality: 3

## Findings
1. [medium] service restart boundary is visible, but final health failure is not tied to the active release id
2. [medium] rollback target is logged too late to anchor the failure path

## Minimum Rewrite Plan
1. add rollback target before service restart
2. log health check result with active release id
3. verify with failure_path

## Canary Impact
- canary_case: CANARY-010
- before_latency: one_inference
- target_latency: immediate
- canary_case_needed: no

## Decision
- keep: pending verification
- revisit_after: failure-path test
- note: healthy target release must be explicit
```

## Example Score Payload

```json
{
  "target": "deploy rollback path",
  "language": "Shell",
  "scenario": "deploy_rollback",
  "review_mode": "code_first",
  "score": {
    "total": 30,
    "max": 40,
    "dimensions": {
      "localizability": 4,
      "step_precision": 4,
      "boundary_visibility": 3,
      "branch_explainability": 4,
      "signal_to_noise_ratio": 4,
      "debug_discipline": 4,
      "safety": 4,
      "outcome_quality": 3
    }
  },
  "diagnosis_latency": {
    "baseline": "one_inference",
    "target": "immediate"
  },
  "top_failures": [
    "active release id not attached to final health result",
    "rollback target appears too late"
  ],
  "minimum_rewrite_plan": [
    "log rollback target before restart",
    "log health result with active release id"
  ],
  "canary": {
    "id": "CANARY-010",
    "used": true
  },
  "decision": "revise"
}
```

## Example PR Note

```md
## Logging Review
- logging_impact: yes
- review_mode: code_first
- score_summary: 30/40
- canary: CANARY-010
- verification: failure_path
- note: rollback target and final health state are now explicit
```
