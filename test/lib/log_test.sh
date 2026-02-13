#!/usr/bin/env bash
# Test lib/log.sh — ensure log levels work and print results.
# Run from repo root: ./test/lib/log_test.sh

set -e
SCRIPT_DIR="${BASH_SOURCE[0]%/*}"
CBASH_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
export CBASH_DIR

source "$CBASH_DIR/lib/colors.sh"
source "$CBASH_DIR/lib/log.sh"

echo "=== log output (CBASH_LOG_LEVEL=7) ==="
CBASH_LOG_LEVEL=7
log_fatal "fatal msg" 2>&1
log_error "error msg" 2>&1
log_warning "warn msg" 2>&1
log_info "info msg"
log_success "success msg"
log_debug "debug msg"
echo ""

echo "=== level filter ==="
out="$(CBASH_LOG_LEVEL=0 log_fatal "x" 2>&1)"
[[ -z "$out" ]] || { echo "FAIL: level 0 should produce no output" >&2; exit 1; }
echo "  level 0: no output (ok)"

out="$(CBASH_LOG_LEVEL=7 log_debug "visible" 2>&1)"
[[ "$out" == *"DEBUG"* && "$out" == *"visible"* ]] || { echo "FAIL: level 7 debug" >&2; exit 1; }
echo "  level 7: debug visible (ok)"
echo ""
echo "log_test: ok"
