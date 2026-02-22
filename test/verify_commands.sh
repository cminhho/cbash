#!/usr/bin/env bash
# CBASH CLI test suite - TAP format
# Runs cbash as a subprocess (bash cbash.sh <args>), so shell aliases (doc, pull_all, etc.) are not exercised.
# Usage: ./test/verify_commands.sh [-v|--verbose]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CBASH_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CBASH="$CBASH_DIR/cbash.sh"
export CBASH_DIR

VERBOSE=false; [[ "$1" == "-v" || "$1" == "--verbose" ]] && VERBOSE=true
total=0 passed=0 failed=0

# Assertions
ok() {
    local desc="$1"; shift; ((total++))
    if bash "$CBASH" "$@" &>/dev/null; then
        ((passed++)); echo "ok $total - $desc"
    else
        ((failed++)); echo "not ok $total - $desc"
    fi
}

fail() {
    local desc="$1"; shift; ((total++))
    if ! bash "$CBASH" "$@" &>/dev/null; then
        ((passed++)); echo "ok $total - $desc"
    else
        ((failed++)); echo "not ok $total - $desc"
    fi
}

contains() {
    local desc="$1" want="$2"; shift 2; ((total++))
    if [[ "$(bash "$CBASH" "$@" 2>&1)" == *"$want"* ]]; then
        ((passed++)); echo "ok $total - $desc"
    else
        ((failed++)); echo "not ok $total - $desc (want: $want)"
    fi
}

echo "TAP version 14"

# Built-in commands
ok "help" help
ok "--help" --help
ok "-h" -h
ok "-v" -v
ok "--version" --version
ok "config" config
ok "list-plugins" list-plugins
contains "help shows USAGE" "USAGE" help

# CLI subcommands
ok "cli help" cli help
ok "cli version" cli version
ok "cli plugins" cli plugins
contains "cli help shows update" "update" cli help

# Plugins
ok "git" git
ok "docs" docs
ok "docs list" docs list
ok "aliases" aliases
ok "gen uuid" gen uuid
contains "git shows USAGE" "USAGE" git
contains "docs shows USAGE" "USAGE" docs
contains "gen uuid output" "-" gen uuid

# Aliases
contains "clone -> git" "clone" clone
contains "macos" "macos" macos
contains "aliases list" "alias" aliases list

# Error handling
fail "unknown-command" unknown-command
fail "uuid (use gen uuid)" uuid
fail "conf (use config)" conf
fail "info (use config)" info

echo "1..$total"
[[ $failed -eq 0 ]] && echo "# ✓ $passed/$total passed" && exit 0
echo "# ✗ $passed passed, $failed failed" && exit 1
