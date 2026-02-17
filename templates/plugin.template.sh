#!/usr/bin/env bash
# {{NAME}} plugin for CBASH - {{DESCRIPTION}}

# Config (optional)
# readonly CONFIG_VAR="value"

# Commands
{{name}}_example() {
    log_info "Example command"
}

# Help and router
{{name}}_help() {
    _describe command '{{name}}' \
        'example  Example command' \
        '{{DESCRIPTION}}'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") {{name}}_help ;;
        example)           shift; {{name}}_example "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}
