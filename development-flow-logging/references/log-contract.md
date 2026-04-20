# Log Contract

Use these fields whenever the logging stack supports structured context.

## Minimum Fields

- `module`
- `function`
- `step`
- `status`
- `summary`

## Strongly Recommended

- `request_id` or `trace_id`
- `elapsed_ms`
- `branch`
- `resource`
- `record_count`
- `retry`
- `exception_type`

## Status Values

Recommended values:
- `start`
- `ok`
- `skip`
- `retry`
- `fail`

## Example

```text
DEBUG module=signal_pipeline function=map_candidates step=entry status=start record_count=42 summary="start mapping A-share candidates"
DEBUG module=signal_pipeline function=map_candidates step=dedup status=ok record_count=31 summary="deduplicated candidate list"
ERROR module=signal_pipeline function=fetch_company step=http status=fail resource=/api/company/123 exception_type=TimeoutError elapsed_ms=3001 summary="company fetch timed out"
```

## Redaction Rules

Never log:
- raw passwords
- access tokens
- cookies
- private keys
- full personal identifiers unless explicitly required and permitted

Prefer:
- `token=***redacted***`
- `user_id=12345`
- `phone_tail=8899`
