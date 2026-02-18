#!/usr/bin/env bash
# Run the same checks as CI locally: shellcheck, verify_commands, actionlint.
# Usage: from repo root, run: ./tools/check.sh
# Requirements: shellcheck (optional: actionlint for workflow linting)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT" || exit 1

failed=0

# 1. Shellcheck (same globs as .github/workflows/ci.yml)
echo "==> Shellcheck (plugins, lib, tools)"
if command -v shellcheck &>/dev/null; then
  for f in plugins/*/*.plugin.sh lib/*.sh tools/*.sh; do
    [ -f "$f" ] || continue
    shellcheck -S warning "$f" || failed=1
  done
else
  echo "    shellcheck not found. Install: brew install shellcheck (macOS) or apt install shellcheck (Linux)"
  failed=1
fi

# 2. Verify commands
echo "==> Verify commands (test/verify_commands.sh)"
if [ -x "./test/verify_commands.sh" ]; then
  ./test/verify_commands.sh || failed=1
else
  echo "    test/verify_commands.sh not found or not executable"
  failed=1
fi

# 3. Actionlint (workflow files)
echo "==> Actionlint (.github/workflows)"
if command -v actionlint &>/dev/null; then
  if [ -f .github/actionlint.yaml ]; then
    actionlint -config-file .github/actionlint.yaml || failed=1
  else
    actionlint || failed=1
  fi
else
  echo "    actionlint not found (optional). Install: brew install actionlint (macOS)"
  echo "    CI will still run actionlint on push/PR."
fi

if [ $failed -eq 1 ]; then
  echo ""
  echo "One or more checks failed. Fix the issues above before pushing."
  exit 1
fi
echo ""
echo "All checks passed."
exit 0
