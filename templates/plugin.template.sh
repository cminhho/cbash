#!/usr/bin/env bash
# {{NAME}} plugin for CBASH
# {{DESCRIPTION}}

# shellcheck source=../../lib/common.sh
[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# =============================================================================
# Configuration
# =============================================================================
# readonly CONFIG_VAR="value"

# =============================================================================
# Aliases
# =============================================================================
# alias shortcut='{{name}}_command'

# =============================================================================
# Commands
# =============================================================================

{{name}}_example() {
    log_info "Example command"
}

# =============================================================================
# Help & Router
# =============================================================================

{{name}}_help() {
    _describe command '{{name}}' \
        'example     Example command' \
        'aliases     List aliases' \
        '{{DESCRIPTION}}'
}

{{name}}_list_aliases() {
    echo "{{NAME}} aliases: ..."
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") {{name}}_help ;;
        aliases)           {{name}}_list_aliases ;;
        example)           shift; {{name}}_example "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
