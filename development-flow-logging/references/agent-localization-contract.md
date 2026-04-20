# Agent Localization Contract

Use this contract when the output of a logging review, incident analysis, or canary comparison needs to guide the next agent directly.

## Goal

The output should reduce the next agent's search space.

A valid handoff does not just say:
- logs are weak
- add more context
- maybe this branch is wrong

A valid handoff must say:
- where the likeliest failure boundary is
- why that boundary is the strongest current hypothesis
- what should be checked next

## Required Fields

- `suspected_scope`
- `strongest_evidence`
- `next_best_action`
- `next_target`
- `confidence`

## Field Meanings

### `suspected_scope`

Smallest plausible failing scope.

Examples:
- `engine/company_research.py::fetch_profiles`
- `scheduler window selection branch`
- `rollback_release -> service_restart boundary`
- `db write path after dedup filter`

### `strongest_evidence`

Best log or structural reason supporting the current suspicion.

Examples:
- branch reason is missing between dedup check and DB write
- timeout occurs after outbound client call but before fallback branch
- active release id disappears before health check failure

### `next_best_action`

Single highest-value next move.

Allowed shapes:
- open code
- add log
- run failure path
- compare two branches
- inspect boundary input or output
- verify mutation result

### `next_target`

Concrete place to inspect next.

Examples:
- file path
- function
- boundary call
- migration step
- deploy phase name

### `confidence`

One of:
- `high`
- `medium`
- `low`

## Compact Handoff Example

```md
suspected_scope=rollback_release -> service_restart boundary
strongest_evidence=rollback target is logged after restart, so failing release pointer is ambiguous
next_best_action=open code
next_target=scripts/deploy_server.sh::rollback_release
confidence=high
```

## Rules

1. keep `suspected_scope` as small as current evidence allows
2. do not list multiple next actions unless the first one is blocked
3. confidence must reflect evidence quality, not optimism
4. if confidence is low, say exactly what missing log or check would raise it
