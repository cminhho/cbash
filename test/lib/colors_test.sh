#!/usr/bin/env bash
# Test lib/colors.sh — ensure helpers work and print results.
# Run from repo root: ./test/lib/colors_test.sh

set -e
SCRIPT_DIR="${BASH_SOURCE[0]%/*}"
CBASH_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
export CBASH_DIR

source "$CBASH_DIR/lib/colors.sh"

echo "=== style helpers ==="
_heading "Heading"
_label "Label: "; echo "value"
_label_nl "LabelNl"
_muted "muted"; echo ""
_muted_nl "MutedNl"
_ok "ok message"
_err "err message"
_box "BoxTitle"
_box_muted "Title" "muted %s" "text"
_heading_muted "H" "sub %s" "x"
_err_stderr "stderr msg" 2>&1
echo ""

echo "=== theme (minimal) ==="
cbash_theme=minimal
source "$CBASH_DIR/lib/colors.sh"
_heading "Minimal heading"
_ok "minimal ok"
echo ""

out="$(_heading "Check")"
[[ "$out" == *"Check"* ]] || { echo "FAIL: _heading" >&2; exit 1; }
echo "colors_test: ok"
