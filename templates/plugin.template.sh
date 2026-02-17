#!/usr/bin/env bash
# {{NAME}} plugin for CBASH - {{DESCRIPTION}}
#
# Files:
#   {{name}}.plugin.sh  - Commands and router (this file)
#   {{name}}.aliases.sh - Aliases (sourced into shell, optional)

# shellcheck source=../../lib/common.sh
[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# Config
# readonly CONFIG_VAR="value"

# Commands
{{name}}_example() {
    log_info "Example"
}

# Help
{{name}}_help() {
    _describe command '{{name}}' \
        'example  Example command' \
        '{{DESCRIPTION}}'
}

# Router
_main() {
    case "${1:-}" in
        help|--help|-h|"") {{name}}_help ;;
        example)           shift; {{name}}_example "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
