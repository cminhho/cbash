#!/usr/bin/env bash
# Verify cbash-cli lib: colors, box, group, table, theme.
# Run from repo root: ./test/lib/verify_lib.sh

set -e
SCRIPT_DIR="${BASH_SOURCE[0]%/*}"
# Force repo root (test/lib -> repo root = ../..)
CBASH_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
export CBASH_DIR

# Load lib (common.sh pulls utils + log)
# shellcheck source=../../lib/utils.sh
[[ -f "$CBASH_DIR/lib/colors.sh" ]] && source "$CBASH_DIR/lib/colors.sh"
# shellcheck source=../../lib/common.sh
[[ -f "$CBASH_DIR/lib/common.sh" ]] && source "$CBASH_DIR/lib/common.sh"

echo "CBASH_DIR=$CBASH_DIR"
echo "cbash_theme=${cbash_theme:-${CBASH_THEME:-dark}}"
echo ""

# --- 1. echo_reset_color ---
verify_reset_color() {
    echo "=== 1. echo_reset_color (bold + color, then reset_color keeps bold) ==="
    printf "${bldblu}bold blue${echo_reset_color} default fg still bold${clr} normal\n"
    echo ""
}

# --- 2. Box frame ---
verify_box_frame() {
    echo "=== 2. _box_frame ==="
    _box_frame "Sample Title" "line one" "line two"
    echo ""
    echo "From stdin:"
    printf 'stdin A\nstdin B\n' | _box_frame "Stdin Box"
    echo ""
}

# --- 3. Group start/end ---
verify_group() {
    echo "=== 3. _group_start / _group_end ==="
    _group_start "Section A"
    _indent "indented line 1" "indented line 2"
    _group_end
    _group_start "Section B"
    _indent "only one line"
    _group_end
    echo ""
}

# --- 4. Table/column ---
verify_table() {
    echo "=== 4. _column_row / _column_header ==="
    _column_header 12 30 "CMD" "Description"
    _column_row 12 30 "pull" "Pull all repos"
    _column_row 12 30 "status" "Show status"
    _column_row 12 30 "push" "Push changes"
    echo ""
    echo "Default widths (20 40):"
    _column_row "name" "value"
    _column_row "foo" "bar"
    echo ""
}

# --- 5. Themes ---
verify_themes() {
    echo "=== 5. Named themes (dark / light / minimal) ==="
    for th in dark light minimal; do
        echo "--- theme: $th ---"
        cbash_theme="$th"
        # Re-source colors to apply theme (theme is set when colors.sh is sourced)
        source "$CBASH_DIR/lib/colors.sh"
        _heading "Heading"
        _label "Label: "; echo "value"
        _ok "ok message"
        _muted_nl "muted text"
        echo ""
    done
    # Restore default for rest of script
    cbash_theme="${CBASH_THEME:-dark}"
    source "$CBASH_DIR/lib/colors.sh"
}

# Run all
verify_reset_color
verify_box_frame
verify_group
verify_table
verify_themes

echo "=== Done ==="
