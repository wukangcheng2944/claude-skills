# Review Rubric

Use this rubric when auditing an existing logging implementation.

Score each dimension from 1 to 5.

## Dimensions

1. Localizability
- Can the failing function be identified immediately?

2. Step Precision
- Can the failing step or checkpoint be identified immediately?

3. Boundary Visibility
- Are external calls, DB mutations, file operations, and queues visible?

4. Branch Explainability
- Do branch and skip logs explain why the path was chosen?

5. Signal-to-Noise Ratio
- Are the logs concise enough to scan without losing key detail?

6. DEBUG Discipline
- Does `DEBUG=false` stay readable while `DEBUG=true` becomes richly diagnostic?

7. Safety
- Are secrets and oversized payloads kept out of logs?

8. Outcome Quality
- Do success logs include timing, counts, and summaries that prove meaningful work happened?

## Interpretation

- `36-40`: strong, AI-friendly logs
- `28-35`: usable, but still has blind spots
- `20-27`: weak, likely to slow diagnosis
- `<20`: misleading or low-value logging

## Exit Criteria

Do not consider the logging work done until:
- the failing function is obvious
- the failing step is obvious
- at least one happy path and one failure path were tested
- `DEBUG=false` is still readable
