#!/usr/bin/env bash
# Apply repository ruleset from .github/rulesets/protect-master.json (create or update).
# Prerequisite: gh auth login. Run from repo root: ./tools/setup-branch-ruleset.sh [owner/repo]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT" || exit 1

REPO="${1:-cminhho/cbash}"
RULESET_FILE="${2:-.github/rulesets/protect-master.json}"

if ! command -v jq &>/dev/null; then
  echo "Error: jq is required. Install: brew install jq"
  exit 1
fi

if [[ ! -f "$RULESET_FILE" ]]; then
  echo "Error: Ruleset file not found: $RULESET_FILE"
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Error: Not logged in. Run: gh auth login"
  exit 1
fi

# GitHub API request body must not include "source_type" / read-only fields; use only what's in the file
# jq strips any keys we don't want to send on create/update
BODY=$(jq -c '{
  name,
  target,
  enforcement,
  conditions,
  rules
}' "$RULESET_FILE")

NAME=$(jq -r '.name' "$RULESET_FILE")
EXISTING=$(gh api "repos/$REPO/rulesets" --jq ".[] | select(.name == \"$NAME\") | .id" 2>/dev/null || true)

if [[ -n "$EXISTING" ]]; then
  echo "Updating existing ruleset '$NAME' (id: $EXISTING) for repo: $REPO"
  gh api "repos/$REPO/rulesets/$EXISTING" \
    -X PUT \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    --input - <<< "$BODY"
  echo "Done. Ruleset updated."
else
  echo "Creating ruleset '$NAME' for repo: $REPO"
  gh api "repos/$REPO/rulesets" \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    --input - <<< "$BODY"
  echo "Done. Ruleset created."
fi
