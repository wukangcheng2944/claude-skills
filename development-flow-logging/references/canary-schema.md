# Canary Schema

Use this schema when a canary case needs to be stored, compared, or reused across review loops.

## Required Fields

```json
{
  "id": "CANARY-001",
  "title": "generic request failure hides validation branch",
  "language": "Python",
  "scenario": "api_validation",
  "symptom": "request returns 500 after payload validation",
  "baseline_failure": "only request failed was logged",
  "expected_localization": {
    "function": "validate_payload",
    "step": "field_validation",
    "branch": "invalid_required_field",
    "boundary": null,
    "mutation": null
  },
  "minimum_must_log": [
    "handler entry",
    "payload summary",
    "validation step",
    "branch reason",
    "exception context"
  ],
  "diagnosis_latency_target": "immediate",
  "source": "real_incident",
  "notes": "replace with repo-specific names when available"
}
```

## Field Rules

- `id`: stable identifier, never reuse for a different failure mode
- `title`: short human-readable summary
- `language`: one dominant language for the case
- `scenario`: normalized category such as `api_validation`, `worker_dedup`, `scheduler_window`
- `symptom`: what the operator or user sees
- `baseline_failure`: why the old logs were not enough
- `expected_localization`: what the improved logs should make obvious
- `minimum_must_log`: smallest set of log checkpoints that would unlock fast diagnosis
- `diagnosis_latency_target`: one of `immediate`, `one_inference`, `multiple_guesses`
- `source`: `real_incident` or `synthetic`
- `notes`: optional repo-specific clarifications

## Optional Fields

```json
{
  "repo": "redfi-invest-agent",
  "component": "schedule",
  "severity": "high",
  "related_canaries": ["CANARY-004"],
  "verification_paths": ["happy_path", "failure_path"]
}
```

## Maintenance Rules

1. prefer real incidents
2. keep normalized scenario names stable
3. do not encode ephemeral timestamps into the case id
4. update `expected_localization` when the true failure boundary becomes clearer
5. keep `minimum_must_log` short enough to remain actionable
