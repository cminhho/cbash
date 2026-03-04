#!/usr/bin/env bash
# Deploy the official website to GitHub Pages (gh-pages branch).
# Pushes the contents of website/ to origin/gh-pages, overwriting that branch.
# Usage: run from repo root, or from anywhere (script cd's to repo root).
#   ./tools/deploy-gh-pages.sh
# Requires: clean working tree (no uncommitted changes).
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

if [[ ! -d website ]]; then
  echo "Error: website/ not found in repo root." >&2
  exit 1
fi

if [[ -n $(git status --porcelain) ]]; then
  echo "Error: Working tree is not clean. Commit or stash changes before deploying." >&2
  exit 1
fi

git subtree push --prefix website origin gh-pages

echo "Deployed. Site: https://cminhho.github.io/cbash/"
