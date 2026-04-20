# Before and After Examples

Use these examples when rewriting weak logs into AI-diagnosable logs.

## 1. Generic API Failure

Before:

```text
request failed
```

After:

```text
ERROR function=getUserProfile step=call-user-service request_id=req-742 status=fail target=user-service timeout_ms=3000 error="timeout after 3001ms"
```

Why better:
- names the function
- identifies the failing step
- names the target dependency
- includes request id and timeout context

## 2. Useless Worker Log

Before:

```text
processing job
error processing job
```

After:

```text
DEBUG function=syncPortfolioJob step=dequeue queue=portfolio-sync job_id=job-991 attempt=2 status=start
ERROR function=syncPortfolioJob step=write-db queue=portfolio-sync job_id=job-991 attempt=2 status=fail error="deadlock detected"
```

Why better:
- ties the failure to a specific queue, job, attempt, and step

## 3. Weak Branch Log

Before:

```text
record skipped
```

After:

```text
DEBUG function=rankSignals step=filter branch=skip-low-confidence signal_id=sig-41 confidence=0.38 threshold=0.50 status=ok
```

Why better:
- explains why the branch happened

## 4. Noisy Object Dump

Before:

```text
payload={"user":{"id":"123","name":"Alice","email":"alice@example.com", ... 300 more lines}}
```

After:

```text
DEBUG function=handleWebhook step=parse-payload request_id=req-201 payload_keys=["user","event","items"] item_count=12 status=ok
```

Why better:
- preserves the diagnostic shape without leaking or flooding

## 5. Silent DB Path

Before:

```text
saving portfolio
saved portfolio
```

After:

```text
DEBUG function=savePortfolio step=begin-transaction database=main portfolio_id=p-88 status=start
DEBUG function=savePortfolio step=upsert-holdings database=main portfolio_id=p-88 row_count=24 status=ok
INFO  function=savePortfolio step=commit database=main portfolio_id=p-88 status=ok elapsed_ms=78
```

Why better:
- confirms the transaction boundary and actual data mutation

## 6. Scheduler Mystery

Before:

```text
task finished
```

After:

```text
INFO function=runMorningPush step=dispatch-summary run_id=run-20260420 timezone=Asia/Shanghai dispatch_count=17 skipped_count=3 status=ok elapsed_ms=2145
```

Why better:
- confirms the run id, timezone assumption, and dispatch outcome
