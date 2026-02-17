#!/usr/bin/env bash
# Verify cbash main commands and aliases.
# Run from repo root: ./test/verify_commands.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CBASH_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
export CBASH_DIR
CBASH="$CBASH_DIR/cbash.sh"

passed=0
failed=0

run_ok() {
    local name="$1"
    shift
    if bash "$CBASH" "$@" &>/dev/null; then
        echo "  OK   $name"
        ((passed++)) || true
        return 0
    else
        echo "  FAIL $name (expected exit 0)"
        ((failed++)) || true
        return 1
    fi
}

run_fail() {
    local name="$1"
    shift
    if ! bash "$CBASH" "$@" &>/dev/null; then
        echo "  OK   $name (expected exit non-zero)"
        ((passed++)) || true
        return 0
    else
        echo "  FAIL $name (expected exit non-zero)"
        ((failed++)) || true
        return 1
    fi
}

run_contains() {
    local name="$1"
    local want="$2"
    shift 2
    local out
    out=$(bash "$CBASH" "$@" 2>&1) || true
    if [[ "$out" == *"$want"* ]]; then
        echo "  OK   $name"
        ((passed++)) || true
        return 0
    else
        echo "  FAIL $name (output should contain: $want)"
        ((failed++)) || true
        return 1
    fi
}

echo "Verify cbash commands (CBASH_DIR=$CBASH_DIR)"
echo ""

echo "Built-in:"
run_ok "help" help
run_ok "help (long)" --help
run_ok "help (short)" -h
run_ok "version" -v
run_ok "version (long)" --version
run_ok "config" config
run_ok "list-plugins" list-plugins
run_contains "help shows usage" "USAGE" help

echo ""
echo "cli subcommands:"
run_ok "cli help" cli help
run_ok "cli version" cli version
run_ok "cli plugins" cli plugins
run_contains "cli help shows update" "update" cli help

echo ""
echo "gen plugin:"
run_ok "gen uuid" gen uuid
run_contains "gen uuid output" "-" gen uuid

echo ""
echo "Plugin by name (auto-discovery):"
run_ok "git" git
run_ok "docs" docs
run_ok "aliases" aliases
run_contains "git shows USAGE" "USAGE" git
run_contains "docs shows USAGE" "USAGE" doc

echo ""
echo "Aliases -> plugin:"
run_ok "mac -> macos" mac
run_ok "doc -> docs" doc
# clone with no args: git plugin may exit 1 (needs repo); just check it reached git
run_contains "clone -> git (pass_cmd)" "clone" clone
run_contains "mac shows macos" "macos" mac
run_contains "aliases list" "alias" aliases list

echo ""
echo "Unknown command:"
run_fail "unknown-command" unknown-command
run_fail "uuid (moved to gen uuid)" uuid
run_fail "conf (use config)" conf
run_fail "info (use config)" info

echo ""
if [[ $failed -eq 0 ]]; then
    echo "All $passed tests passed."
    exit 0
else
    echo "Passed: $passed  Failed: $failed"
    exit 1
fi
