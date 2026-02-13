#!/usr/bin/env bash
# Common utilities for CBASH plugins

source "$CBASH_DIR/lib/utils.sh"

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

