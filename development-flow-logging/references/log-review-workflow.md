# Log Review Workflow

Use this workflow when logs already exist and the job is to review, score, and improve them.

## Entry Modes

### 1. Code-first review

Use when you have source code but not a full incident log.

Steps:
1. identify the entrypoint and expected happy path
2. mark branch points, boundary calls, and mutation points
3. inspect current logs at each point
4. score the implementation with `review-rubric.md`
5. rewrite only the weakest checkpoints first

### 2. Logs-first review

Use when you mainly have runtime logs from a failing run.

Steps:
1. find the last clearly trustworthy line
2. find the first ambiguous, missing, or generic line
3. infer which function and boundary must sit between them
4. map the missing visibility back to source code
5. rewrite the minimum logs needed so the next run makes the gap obvious

### 3. Incident-first review

Use when the user reports a symptom but the exact code path is still unknown.

Steps:
1. restate the symptom precisely
2. identify the likeliest runtime scenario: API, worker, scheduler, DB, deploy, script
3. inspect the scenario template and failure library
4. instrument the shortest path that can confirm or reject the hypothesis
5. run once with `DEBUG=true`

## Review Sequence

Run these checks in order:

1. Localize the function
   - Can the failing function be identified from logs alone?

2. Localize the step
   - Can the failing checkpoint, boundary, or branch be identified?

3. Explain the branch
   - If code chose a path, does the log explain why?

4. Expose the boundary
   - Are HTTP, DB, queue, file, subprocess, or cache interactions visible?

5. Confirm the mutation
   - If state should change, is the attempted and actual change visible?

6. Check DEBUG discipline
   - Is `DEBUG=false` readable and `DEBUG=true` precise?

7. Check safety
   - Are secrets or oversized dumps avoided?

## Output Shape

A good review result should end with:

- `current_score`
- `top_3_failures`
- `minimum_rewrite_plan`
- `canary_case_needed` yes or no
- `verify_with` happy path, failure path, or both

## Rewrite Rule

Do not rewrite all logs at once.

Prefer this order:
1. generic failure logs
2. missing branch reasons
3. silent boundaries
4. missing mutation summaries
5. repetitive noise

This preserves causality while minimizing churn.
