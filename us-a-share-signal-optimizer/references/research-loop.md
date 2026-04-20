# Research Loop

## Default loop

1. Choose one hypothesis.
2. Freeze the editable surface.
3. Record the baseline version.
4. Run baseline on live trace + golden cases.
5. Draft one candidate.
6. Evaluate candidate with the same recipe.
7. Compare baseline vs candidate.
8. Accept, reject, or rollback.
9. Record the next best hypothesis.

## Editable surfaces

Good default surfaces:
- system prompt sections
- output template
- mapping instructions
- confidence instructions
- timing-note instructions
- optimization doc wording

Bad default surfaces:
- DB schema
- tool names
- delivery plumbing
- broad product scope

## Acceptance logic

Accept only when:
- the main target metric improves
- no hard guardrail fails
- canary cases do not regress materially

Reject when:
- gains exist only on one live trace
- concept/supply-chain separation gets worse
- bearish handling regresses
- the candidate inflates confidence without evidence

## Research log template

- Hypothesis:
- Editable surface:
- Baseline version:
- Candidate version:
- Cases run:
- Improvement observed:
- Regressions:
- Decision:
- Next hypothesis:
