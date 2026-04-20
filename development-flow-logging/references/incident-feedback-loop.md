# Incident Feedback Loop

Use this flow after a real failure in development, staging, or production.

## Objective

A real incident should strengthen the logging standard permanently.

## Workflow

1. Capture the symptom
   - what the user or operator observed
   - what the system reported

2. Capture the gap
   - what important fact was missing from the logs
   - which function, step, branch, boundary, or mutation stayed ambiguous

3. Classify the incident
   - language
   - scenario
   - severity
   - whether an existing canary already covers it

4. Decide the artifact updates
   - add or update a canary
   - add a before/after rewrite
   - tighten the review workflow
   - add CI/PR guidance if the failure should have been caught earlier

5. Re-run the review
   - use the same scoring protocol
   - compare before and after diagnosis latency

6. Record the rule
   - what future reviewers should check first

## Good Output

A good incident follow-up produces:

- one updated canary or a justified reuse of an old one
- one measurable improvement in diagnosis speed or precision
- one short rule that can be reused in review or CI

## Bad Output

Avoid these anti-patterns:

- fixing code without updating the logging standard
- adding verbose logs without stating the missing fact
- treating every incident as unique and never updating the corpus
