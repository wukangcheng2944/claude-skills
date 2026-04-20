# Deploy Triage Matrix

Use this matrix to move from a deploy symptom to the most likely failing scope and next action quickly.

## Matrix

### 1. Cannot reach source repo

- `symptom`: `git fetch` or clone never starts or fails immediately
- `likely_scope`: `preflight -> repo reachability`
- `strongest_evidence`: DNS, timeout, or route failure before checkout logic
- `next_best_action`: `rerun one probe`
- `next_target`: repo host reachability from the machine expected to pull

### 2. SSH to target fails

- `symptom`: runner cannot execute remote command
- `likely_scope`: `preflight -> SSH negotiation`
- `strongest_evidence`: alias, auth, or timeout fails before any remote deploy step
- `next_best_action`: `inspect remote access path`
- `next_target`: alias, key strategy, host, and `BatchMode` configuration

### 3. Checkout fails after connection succeeds

- `symptom`: deploy reaches target but ref mismatch or fetch error occurs
- `likely_scope`: `checkout -> fetch or ref resolution`
- `strongest_evidence`: remote shell works, but target ref cannot be resolved or fetched
- `next_best_action`: `compare deployed ref`
- `next_target`: git remote config and target ref resolution logic

### 4. Build fails

- `symptom`: images, wheels, or artifacts do not complete
- `likely_scope`: `build -> dependency install or artifact build`
- `strongest_evidence`: checkout succeeded and build emitted explicit failing command
- `next_best_action`: `inspect remote logs`
- `next_target`: build step logs and temp artifact path

### 5. Migration fails

- `symptom`: schema step aborts deploy
- `likely_scope`: `migrate -> schema apply`
- `strongest_evidence`: backup succeeded, migrate failed, restart not yet started
- `next_best_action`: `open code`
- `next_target`: migration runner and failing revision or schema step

### 6. Restart fails

- `symptom`: service never returns to running state
- `likely_scope`: `restart -> service start`
- `strongest_evidence`: build and migrate succeeded, service state check failed
- `next_best_action`: `check service state`
- `next_target`: compose status or process manager state for the named service

### 7. Health check fails after restart

- `symptom`: service starts but health or smoke gate fails
- `likely_scope`: `healthcheck -> endpoint or data smoke path`
- `strongest_evidence`: restart succeeded, bounded retries exhausted
- `next_best_action`: `inspect remote logs`
- `next_target`: failing endpoint, app logs, and health gate output

### 8. Rollback fails

- `symptom`: deploy failed and restore left the system in uncertain state
- `likely_scope`: `rollback -> code restore or DB restore`
- `strongest_evidence`: rollback started but one restore step never reached `ok`
- `next_best_action`: `verify backup artifact`
- `next_target`: backup id, restore command, and final restored ref

### 9. Duplicate push or duplicate business action after restart

- `symptom`: same scheduled business action runs again after deploy
- `likely_scope`: `business-side-effect guard -> dedup check`
- `strongest_evidence`: deploy succeeded but replay prevention log is missing or negative
- `next_best_action`: `open code`
- `next_target`: scheduler dedup path and persisted delivery record check

### 10. Wrong timezone behavior after deploy

- `symptom`: dashboard or scheduler window appears in browser time instead of business time
- `likely_scope`: `business-side-effect guard -> timezone normalization`
- `strongest_evidence`: deploy changed runtime behavior but timezone assumption not logged
- `next_best_action`: `open code`
- `next_target`: timezone normalization path and displayed timestamp formatter

## Rule

If multiple symptoms appear, prioritize in this order:
1. rollback failed
2. migration failed
3. health check failed
4. restart failed
5. build failed
6. checkout failed
7. reachability failed

Reason:
- later-stage failures have more partial mutation risk
- rollback ambiguity is the most operationally dangerous
