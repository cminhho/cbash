#!/usr/bin/env bash
# Test lib/cli.sh — ensure CLI commands work and print results.
# Run from repo root: ./test/lib/cli_test.sh
# (Skips install-local and reload — they change fs / exec shell.)

set -e
SCRIPT_DIR="${BASH_SOURCE[0]%/*}"
CBASH_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
export CBASH_DIR

source "$CBASH_DIR/lib/cli.sh" || { echo "source cli.sh failed" >&2; exit 1; }

echo "=== cli help ==="
cli_help
echo ""

echo "=== cli version ==="
cli_version
echo ""

echo "=== cli plugins ==="
cli_plugins
echo ""

echo "=== _main (no arg) ==="
_main ""
echo ""

echo "=== _main help / version / plugins ==="
_main help
_main version
_main plugins
echo ""

echo "=== _main unknown ==="
_main unknown 2>&1 || true
echo ""

out="$(cli_help)"
[[ "$out" == *"Usage"* && "$out" == *"Commands"* ]] || { echo "FAIL: cli_help" >&2; exit 1; }
echo "cli_test: ok"
