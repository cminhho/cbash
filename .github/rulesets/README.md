# Branch protection rulesets (as code)

Ruleset definitions live here and are applied via the GitHub API.

- **protect-master.json** — Protects `master`: require PR and status checks (Shellcheck, Verify commands, Actionlint).

## Apply or update

From repo root, after `gh auth login`:

```bash
./tools/setup-branch-ruleset.sh [owner/repo]
```

Default repo: `cminhho/cbash`. The script creates the ruleset if missing, or updates it if it already exists (same name). Requires `jq` (e.g. `brew install jq`).
