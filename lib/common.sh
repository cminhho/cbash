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

