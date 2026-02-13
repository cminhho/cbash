#!/usr/bin/env bash
# Common utilities for CBASH plugins (style helpers from lib/colors.sh via utils.sh)

source "$CBASH_DIR/lib/utils.sh"
[[ -f "$CBASH_DIR/lib/log.sh" ]] && source "$CBASH_DIR/lib/log.sh"

# =============================================================================
# Format helpers (no color; style/color from lib/colors.sh)
# =============================================================================
_br()      { printf "\n"; }
_gap()     { printf "\n"; }
_indent()  { if [[ $# -gt 0 ]]; then printf '%s\n' "$@" | sed 's/^/  /'; else sed 's/^/  /'; fi; }

# Box with border. Usage: _box_frame "Title" [line1 line2 ...] or echo lines | _box_frame "Title"
# Optional: CBASH_BOX_WIDTH (default 52), uses style_heading for border.
_box_frame() {
    local title="${1:-}"
    shift
    local width="${CBASH_BOX_WIDTH:-52}"
    local lines=()
    if [[ $# -gt 0 ]]; then
        lines=("$@")
    else
        while IFS= read -r line; do lines+=("$line"); done
    fi
    local maxlen=$((width - 1))
    local top="${style_heading}┌${clr}"; local t=0; while [[ $t -lt $width ]]; do top="${top}${style_heading}─${clr}"; t=$((t+1)); done; top="${top}${style_heading}┐${clr}"
    local bar="${style_heading}│${clr}"
    local mid="${style_heading}├${clr}"; t=0; while [[ $t -lt $width ]]; do mid="${mid}${style_heading}─${clr}"; t=$((t+1)); done; mid="${mid}${style_heading}┤${clr}"
    local bot="${style_heading}└${clr}"; t=0; while [[ $t -lt $width ]]; do bot="${bot}${style_heading}─${clr}"; t=$((t+1)); done; bot="${bot}${style_heading}┘${clr}"
    printf '%b\n' "$top"
    if [[ -n "$title" ]]; then
        printf '%b%-*s%b\n' "$bar" "$width" " ${title:0:$maxlen}" "$bar"
        [[ ${#lines[@]} -gt 0 ]] && printf '%b\n' "$mid"
    fi
    local line
    for line in "${lines[@]}"; do
        [[ ${#line} -gt $maxlen ]] && line="${line:0:$((maxlen-3))}..."
        printf '%b%-*s%b\n' "$bar" "$width" " $line" "$bar"
    done
    printf '%b\n' "$bot"
}

# Group: section heading + optional end. Between _group_start and _group_end, use _indent for body lines.
_group_start() { printf "${style_heading}▸ %s${clr}\n" "$*"; }
_group_end()   { _gap; }

# Table/column: print one row with aligned columns. _column_row W1 W2 W3 "val1" "val2" "val3"
# Or _column_row "val1" "val2" (default widths 20 40). Truncates long cells.
_column_row() {
    local w
    local widths=()
    local i=1
    while [[ $i -le $# ]]; do
        [[ "${!i}" =~ ^[0-9]+$ ]] && widths+=("${!i}") && ((i++)) || break
    done
    [[ ${#widths[@]} -eq 0 ]] && widths=(20 40)
    local j=0
    for w in "${widths[@]}"; do
        [[ $i -gt $# ]] && break
        local cell="${!i}"
        [[ ${#cell} -gt $w ]] && cell="${cell:0:$((w-3))}..."
        printf '%-*s' "$w" "$cell"
        ((i++)); ((j++))
    done
    [[ $j -gt 0 ]] && printf '\n'
}
# Header row (styled). Same args as _column_row; builds line then prints with style_label.
_column_header() {
    local widths=()
    local i=1
    while [[ $i -le $# ]]; do
        [[ "${!i}" =~ ^[0-9]+$ ]] && widths+=("${!i}") && ((i++)) || break
    done
    [[ ${#widths[@]} -eq 0 ]] && widths=(20 40)
    local line="" w
    for w in "${widths[@]}"; do
        [[ $i -gt $# ]] && break
        local cell="${!i}"
        [[ ${#cell} -gt $w ]] && cell="${cell:0:$((w-3))}..."
        printf -v line '%s%-*s' "$line" "$w" "$cell"
        ((i++))
    done
    [[ -n "$line" ]] && printf "${style_label}%s${clr}\n" "$line"
}

# Describe command help (uses bldylw from colors.sh)
_describe() {
    local name="$2"
    shift 2
    printf "${bldylw}%s${clr} - %s\n\n" "$name" "${@: -1}"
    printf "${bldylw}USAGE${clr}\n  cbash %s <command> [options]\n\n" "$name"
    printf "${bldylw}COMMANDS${clr}\n"
    for cmd in "${@:1:$#-1}"; do printf "  %s\n" "$cmd"; done
    echo
}

