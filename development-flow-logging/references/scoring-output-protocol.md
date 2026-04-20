# Scoring Output Protocol

Use this protocol when a logging review result should be machine-readable and comparable across iterations.

## JSON Payload

```json
{
  "target": "schedule dispatch path",
  "language": "Python",
  "scenario": "scheduler_window",
  "review_mode": "code_first",
  "score": {
    "total": 29,
    "max": 40,
    "dimensions": {
      "localizability": 3,
      "step_precision": 4,
      "boundary_visibility": 4,
      "branch_explainability": 3,
      "signal_to_noise_ratio": 4,
      "debug_discipline": 4,
      "safety": 4,
      "outcome_quality": 3
    }
  },
  "diagnosis_latency": {
    "baseline": "multiple_guesses",
    "target": "immediate"
  },
  "top_failures": [
    "selected window is not logged",
    "timezone normalization is not visible",
    "skip reason is generic"
  ],
  "minimum_rewrite_plan": [
    "log normalized timezone",
    "log selected window with source inputs",
    "log explicit skip reason when window rejected"
  ],
  "agent_handoff": {
    "suspected_scope": "schedule dispatch -> window selection branch",
    "strongest_evidence": "selected window and timezone normalization are both invisible before skip",
    "next_best_action": "open code",
    "next_target": "scheduler/window.py::select_window",
    "confidence": "high"
  },
  "canary": {
    "id": "CANARY-004",
    "used": true
  },
  "decision": "revise"
}
```

## TSV-Compatible Flattened Form

Use this when results need to be appended to a table:

```text
target	language	scenario	total	localizability	step_precision	boundary_visibility	branch_explainability	signal_to_noise_ratio	debug_discipline	safety	outcome_quality	baseline_latency	target_latency	suspected_scope	next_best_action	next_target	confidence	canary_id	decision
schedule dispatch path	Python	scheduler_window	29	3	4	4	3	4	4	4	3	multiple_guesses	immediate	schedule dispatch -> window selection branch	open code	scheduler/window.py::select_window	high	CANARY-004	revise
```

## Allowed Values

### `review_mode`

- `code_first`
- `logs_first`
- `incident_first`

### `diagnosis_latency`

- `immediate`
- `one_inference`
- `multiple_guesses`
- `not_localizable`

### `decision`

- `keep`
- `revise`
- `revert`
- `needs_more_data`

## Protocol Rules

1. keep dimension names stable across reviews
2. always include `total` and `max`
3. do not change the latency vocabulary
4. list failures and rewrite actions in priority order
5. keep one canary id attached when the review used a fixed case
6. always include one agent handoff with smallest plausible scope and next move
