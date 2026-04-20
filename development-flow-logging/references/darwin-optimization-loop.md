# Darwin Optimization Loop

Use this loop when iterating on logging standards, templates, or rewrites over time.

## Principle

Do not optimize logging by intuition alone.

A change should survive only if it helps a fixed canary set become easier to diagnose.

## Inputs

For each iteration, keep these fixed:

- one logging hypothesis
- one baseline implementation
- one revised implementation
- one stable canary subset
- one review rubric

## Iteration Steps

### 1. Pick one hypothesis

Examples:
- missing branch reasons are the main problem
- boundary logs exist but mutation logs are missing
- `DEBUG=true` is too noisy to be useful
- exception logs need step context

Do not change multiple hypotheses at once.

### 2. Run the baseline

Against the same canary cases:
- inspect the current code or logs
- score them with `review-rubric.md`
- note diagnosis latency in plain language:
  - immediate
  - one inference required
  - multiple guesses required
  - not localizable

### 3. Apply the minimal revision

Change only the logging pattern needed for the chosen hypothesis.

Good examples:
- add branch reason fields
- move exception logging closer to the boundary
- replace object dumps with summaries
- add affected-row logging after writes

Bad examples:
- rewrite every log in the module
- add verbose chatter to unrelated functions
- mix formatting cleanup with diagnosis improvements

### 4. Re-score on the same canaries

Check:
- rubric score improved or not
- diagnosis latency improved or not
- normal mode became noisier or not
- safety or redaction regressed or not

### 5. Keep or revert

Keep the change only if:
- the failing function becomes easier to locate
- the failing step becomes easier to locate
- ambiguity is reduced on the same canary set
- normal mode remains readable

Revert or simplify if:
- the score stays flat
- only verbosity increased
- the same canary still requires guessing
- the new logs obscure the happy path

## Suggested Record Format

For each iteration, capture:

- `date`
- `hypothesis`
- `changed_pattern`
- `canaries_used`
- `before_score`
- `after_score`
- `before_latency`
- `after_latency`
- `decision`
- `note`

## Example

Hypothesis:
- scheduler logs lack timezone and selected-window context

Change:
- add timezone normalization log
- add selected-window log
- add skip reason when window rejected

Result:
- CANARY-004 moved from "multiple guesses required" to "immediate"
- score improved from 24 to 34
- decision: keep

This is the standard.
If the canary does not get easier to diagnose, the logging change did not earn its complexity.
