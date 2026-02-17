#!/usr/bin/env bash
# CBASH - Command-line tools for development workflow

[[ -n "$BASH_VERSION" || -n "$ZSH_VERSION" ]] || { echo "Error: requires bash or zsh" >&2; return 1 2>/dev/null || exit 1; }

readonly CBASH_VERSION="${CBASH_VERSION:-1.0.0}"
: "${CBASH_DIR:=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)}"
[[ -d "$CBASH_DIR/lib" ]] || CBASH_DIR="$HOME/.cbash"
export CBASH_DIR

# Load plugins and aliases
_init() {
    [[ -d "$CBASH_DIR" ]] || { echo "Error: CBASH_DIR not found" >&2; exit 1; }
    source "$CBASH_DIR/lib/common.sh"
    local dir name
    for dir in "$CBASH_DIR/plugins/"*/; do
        name=${dir%/}; name=${name##*/}
        [[ -f "$dir$name.aliases.sh" ]] && source "$dir$name.aliases.sh"
        [[ -f "$dir$name.plugin.sh" ]] && source "$dir$name.plugin.sh"
    done
    for f in "$CBASH_DIR/plugins/aliases/"*.aliases.sh; do
        [[ -f "$f" ]] && source "$f"
    done
}

# Display help
_help() {
    [[ -f "$CBASH_DIR/lib/help.sh" ]] && { bash "$CBASH_DIR/lib/help.sh"; return; }
    echo "cbash v$CBASH_VERSION - Run 'cbash help' for commands"
}

# Show config
_config() {
    printf "%-10s %s\n" "version" "$CBASH_VERSION" "dir" "$CBASH_DIR" "debug" "${DEBUG:-false}"
}

# Run plugin by name (source common.sh first for plugin access)
_plugin() { bash -c "source '$CBASH_DIR/lib/common.sh'; source '$CBASH_DIR/plugins/$1/$1.plugin.sh'; _main ${*:2}" ; }

# Command router (built-in + auto-discover)
_run() {
    local cmd="${1:-help}"; shift 2>/dev/null || true
    case "$cmd" in
        help|--help|-h)  _help ;;
        -v|--version)    echo "cbash v$CBASH_VERSION" ;;
        config)          _config ;;
        cli)             bash "$CBASH_DIR/lib/cli.sh" "$@" ;;
        list-plugins)    cbash_list_plugins ;;
        refresh)         source "$CBASH_DIR/cbash.sh" ;;
        *)               [[ -f "$CBASH_DIR/plugins/$cmd/$cmd.plugin.sh" ]] && _plugin "$cmd" "$@" || { echo "Unknown: $cmd. Run 'cbash help'" >&2; return 1; } ;;
    esac
}

# Main entry point
_main() {
    [[ "${DEBUG:-}" == "true" ]] && set -x
    _init
    _run "$@"
}

# Execute or source
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    _main "$@"
else
    _init
    alias cbash='$CBASH_DIR/cbash.sh'
fi
