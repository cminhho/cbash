#!/usr/bin/env bash
# Verify cbash-cli lib: colors, helpers, theme.
# Run from repo root: ./test/lib/verify_lib.sh

set -e
SCRIPT_DIR="${BASH_SOURCE[0]%/*}"
CBASH_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
export CBASH_DIR

# Load lib
# shellcheck source=../../lib/common.sh
[[ -f "$CBASH_DIR/lib/common.sh" ]] && source "$CBASH_DIR/lib/common.sh"

echo "CBASH_DIR=$CBASH_DIR"
echo "cbash_theme=${cbash_theme:-${CBASH_THEME:-dark}}"
echo ""

# --- 1. Colors ---
verify_colors() {
    echo "=== 1. Colors ==="
    printf "${bldblu}bold blue${clr} ${txtgrn}green${clr} ${txtred}red${clr}\n"
    echo ""
}

# --- 2. Format helpers ---
verify_helpers() {
    echo "=== 2. Format helpers ==="
    _indent "indented line 1" "indented line 2"
    _br
    echo ""
}

# --- 3. Themes ---
verify_themes() {
    echo "=== 3. Named themes (dark / light / minimal) ==="
    for th in dark light minimal; do
        echo "--- theme: $th ---"
        cbash_theme="$th"
        source "$CBASH_DIR/lib/colors.sh"
        _heading "Heading"
        _label "Label: "; echo "value"
        _ok "ok message"
        _muted_nl "muted text"
        echo ""
    done
    cbash_theme="${CBASH_THEME:-dark}"
    source "$CBASH_DIR/lib/colors.sh"
}

# Run all
verify_colors
verify_helpers
verify_themes

echo "=== Done ==="
