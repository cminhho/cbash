#!/usr/bin/env bash
# Common utilities for CBASH plugins

source "$CBASH_DIR/lib/utils.sh"

# =============================================================================
# Style / color functions (theme from utils.sh)
# =============================================================================
_heading()        { printf "${style_heading}%s${clr}\n" "$*"; }
_heading_muted() { local h="$1" m="$2"; shift 2; printf "${style_heading}%s${clr} ${style_muted}%s${clr}\n" "$h" "$(printf "$m" "$@")"; }
_label()          { printf "${style_label}%s${clr}" "$*"; }
_label_nl()       { printf "${style_label}%s${clr}\n" "$*"; }
_muted()          { printf "${style_muted}%s${clr}" "$*"; }
_muted_nl()       { printf "${style_muted}%s${clr}\n" "$*"; }
_ok()             { printf "  ${style_ok}✓ %s${clr}\n" "$*"; }
_err()            { printf "  ${style_err}✗ %s${clr}\n" "$*"; }

# Breakline / spacing
_br()             { printf "\n"; }
_gap()            { printf "\n"; }

# Box / section (heading with optional prefix)
_box()            { printf "${style_heading}▸ %s${clr}\n" "$*"; }
_box_muted()      { local t="$1" m="$2"; shift 2; printf "${style_heading}▸ %s${clr} ${style_muted}%s${clr}\n" "$t" "$(printf "$m" "$@")"; }

# Indent: prefix each line with 2 spaces (stdin or "$@")
_indent()         { if [[ $# -gt 0 ]]; then printf '%s\n' "$@" | sed 's/^/  /'; else sed 's/^/  /'; fi; }

# Describe command help
_describe() {
    local name="$2"
    shift 2
    printf "${bldylw}%s${clr} - %s\n\n" "$name" "${@: -1}"
    printf "${bldylw}USAGE${clr}\n  cbash %s <command> [options]\n\n" "$name"
    printf "${bldylw}COMMANDS${clr}\n"
    for cmd in "${@:1:$#-1}"; do printf "  %s\n" "$cmd"; done
    echo
}

