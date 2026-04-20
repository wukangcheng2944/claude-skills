# Failure Library

Use this file when a bug is still hard to localize.

The idea is simple:
- identify the failure class
- check whether the required logs exist
- if they do not, add them before deeper debugging

## 1. Wrong Branch Taken

Symptom:
- a record is skipped, retried, filtered, or routed unexpectedly

Minimum logs needed:
- function name
- branch name
- branch condition summary
- key identifiers of the affected record or request

## 2. External Dependency Timeout

Symptom:
- request hangs or times out

Minimum logs needed:
- outbound call start
- target service or endpoint summary
- timeout setting
- attempt number
- outbound failure with elapsed time

## 3. DB Mutation Did Not Happen

Symptom:
- code says success, but rows or state did not change

Minimum logs needed:
- transaction start
- write intent summary
- affected row or object count
- commit or rollback result

## 4. Duplicate Job or Push

Symptom:
- worker or scheduler processes the same item twice

Minimum logs needed:
- job or dispatch id
- dedup check result
- replay-prevention branch
- final ack or dispatch state

## 5. Crash Without Context

Symptom:
- exception exists but it is unclear which step failed

Minimum logs needed:
- function entry
- checkpoint immediately before the failing step
- exception log with step and local context

## 6. Wrong Data Shape

Symptom:
- downstream code fails because upstream parsing or mapping was wrong

Minimum logs needed:
- parse checkpoint
- input shape summary
- output shape summary
- filtered or dropped count

## 7. Retry Loop Gone Wrong

Symptom:
- retries happen forever or never happen when expected

Minimum logs needed:
- attempt count
- retry decision reason
- cap or max retry info
- terminal path log

## 8. Scheduler Window Bug

Symptom:
- expected task was not sent or was sent in the wrong time window

Minimum logs needed:
- run id
- computed window start and end
- timezone assumption
- dedup result
- dispatch count and skipped count

## 9. Partial Success Hidden as Full Success

Symptom:
- one sub-step failed but final log still says success

Minimum logs needed:
- per-step statuses
- explicit sub-step summary
- final outcome tied to all critical sub-steps

## 10. AI Still Cannot Localize the Bug

Symptom:
- logs exist, but multiple adjacent steps are still plausible failure points

Minimum logs needed:
- more granular checkpoint split
- stronger branch reason logging
- clearer boundary logs
- before/after result summaries instead of generic "done"
