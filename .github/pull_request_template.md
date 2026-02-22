## Summary

Describe the problem and fix in 2–5 bullets:

- Problem:
- Why it matters:
- What changed:
- What did NOT change (scope boundary):

## Change Type (select all)

- [ ] Bug fix
- [ ] Feature
- [ ] Refactor
- [ ] Docs
- [ ] Security hardening
- [ ] Chore/infra

## Scope (select all touched areas)

- [ ] Git automation (`commit`, `pull_all`, `clone_all`, `gitfor`, `gitsync`, `auto_squash`)
- [ ] Docker & dev (`start`, `stop`, `devlogs`, `devexec`, `devkill`)
- [ ] Kubernetes (`k8pods`, `k8logs`, `k8exec`, `k8restart`)
- [ ] AWS / Cloud (`awsssh`, `awsssmget`)
- [ ] Generators (`gfeat`, `gproject`, `gdoc`)
- [ ] Docs (`doc`, docs list/edit)
- [ ] AI Chat (`chat`, `aipull`)
- [ ] macOS utils / Proxy / Build tools
- [ ] Plugins / core (plugin structure, `cbash.sh`, lib)
- [ ] CI/CD / infra
- [ ] Documentation (README, CONTRIBUTING, docs/)

## Linked Issue/PR

- Closes #
- Related #

## User-visible / Behavior Changes

List user-visible changes (including defaults/config).  
If none, write `None`.

## Security Impact (required)

- New permissions/capabilities? (`Yes/No`)
- Secrets/tokens handling changed? (`Yes/No`)
- New/changed network calls? (`Yes/No`)
- Command/shell execution surface changed? (`Yes/No`)
- Data access scope changed? (`Yes/No`)
- If any `Yes`, explain risk + mitigation:

## Repro + Verification

### Environment

- OS: (e.g. macOS / Linux / WSL2)
- Shell: (Bash 4.0+ / Zsh)
- cbash-cli version/source: (e.g. Homebrew, one-liner install)
- Relevant config (redacted):

### Steps

1.
2.
3.

### Expected

-

### Actual

-

## Evidence

Attach at least one:

- [ ] Failing test/log before + passing after
- [ ] Trace/log snippets
- [ ] Screenshot/recording
- [ ] Perf numbers (if relevant)

## Human Verification (required)

What you personally verified (not just CI), and how:

- Verified scenarios:
- Edge cases checked (e.g. bash vs zsh, clean env):
- What you did **not** verify:

## Compatibility / Migration

- Backward compatible? (`Yes/No`)
- Config/env changes? (`Yes/No`)
- Migration needed? (`Yes/No`)
- If yes, exact upgrade steps:

## Failure Recovery (if this breaks)

- How to disable/revert this change quickly:
- Files/config to restore:
- Known bad symptoms reviewers should watch for:

## Risks and Mitigations

List only real risks for this PR. Add/remove entries as needed. If none, write `None`.

- Risk:
  - Mitigation:
