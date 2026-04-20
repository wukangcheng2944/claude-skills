# Function Checklist

Use this template when instrumenting a critical function.

## Entry

- log function name
- log sanitized argument summary
- log correlation id if available

## Internal Checkpoints

- before external call
- after external call
- after parse or transform
- after filter or branch
- before write or mutation
- after write or mutation

## Exit

- success status
- result shape or count
- elapsed time

## Failure

- exception type
- exception message
- current step
- branch or condition
- key identifiers needed to reproduce

## Gate

- verbose lines behind `DEBUG`
- concise operational lines remain visible without `DEBUG`
