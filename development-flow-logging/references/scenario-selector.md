# Scenario Selector

Use this file after choosing the language template.

## Rule

Build the logging pattern in this order:

1. choose the language template
2. choose one primary scenario template
3. layer repo-specific field names and IDs
4. validate on one happy path and one failing path

## Which Scenario To Pick

### Generic Function

Use when:
- the task is a utility function
- the task is local transformation logic
- there is no request lifecycle or background runner involved

Base:
- `language-templates.md`

### Web or API Request

Use when:
- the code is an HTTP handler
- the code is a controller, route, or endpoint
- a request or trace id exists

Add:
- request entry log
- auth or caller context
- payload summary
- outbound dependency logs
- response status log

### Worker or Queue Consumer

Use when:
- the code handles background jobs
- the code consumes messages from a queue
- retries, dead letters, or backoff exist

Add:
- job or message id
- dequeue and ack or nack logs
- retry decision logs
- terminal success or dead-letter logs

### Scheduler or Cron Job

Use when:
- the code runs on a timer
- the code computes a dispatch window
- duplicate prevention matters

Add:
- schedule trigger log
- window calculation log
- dedup or replay prevention log
- dispatch count log
- final run summary

### DB Write or Migration Path

Use when:
- the code mutates database state
- schema changes occur
- transaction boundaries matter

Add:
- transaction start log
- affected record count
- migration or statement identity
- commit or rollback log

### External HTTP or RPC Call

Use when:
- the code calls an external service
- timeouts, retries, or circuit breaking matter

Add:
- outbound request intent log
- sanitized target summary
- retry or fallback logs
- response status or timeout log

## Composition Examples

- Python API endpoint -> Python template + Web/API scenario
- TypeScript worker -> TypeScript template + Worker scenario
- Go cron job -> Go template + Scheduler scenario
- Java migration -> Java template + DB mutation scenario
- Shell deploy helper -> Shell template + External call scenario

If a flow mixes multiple scenarios, choose the dominant one and then add only the extra checkpoints you truly need.
