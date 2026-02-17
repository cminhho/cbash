#!/usr/bin/env bash
# Common utilities for CBASH plugins
# shellcheck disable=SC2034

source "$CBASH_DIR/lib/colors.sh"
[[ -f "$CBASH_DIR/lib/log.sh" ]] && source "$CBASH_DIR/lib/log.sh"

# =============================================================================
# Format helpers
# =============================================================================
_br()      { printf "\n"; }
_gap()     { printf "\n"; }
_indent()  { if [[ $# -gt 0 ]]; then printf '%s\n' "$@" | sed 's/^/  /'; else sed 's/^/  /'; fi; }

# =============================================================================
# Utility functions
# =============================================================================
_command_exists() { command -v "$1" &>/dev/null; }

# Describe command help (used by all plugins)
_describe() {
    local name="$2"
    shift 2
    printf "${bldylw}%s${clr} - %s\n\n" "$name" "${@: -1}"
    printf "${bldylw}USAGE${clr}\n  cbash %s <command> [options]\n\n" "$name"
    printf "${bldylw}COMMANDS${clr}\n"
    for cmd in "${@:1:$#-1}"; do printf "  %s\n" "$cmd"; done
    echo
}

