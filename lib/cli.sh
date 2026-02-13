#!/usr/bin/env bash
# CLI management for CBASH

source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

cli_help() {
    cat <<EOF
Usage: cbash cli <command>

Commands:
  help        Show this help
  version     Show version
  plugins     List available plugins
  update      Update CBASH
  reload      Reload shell
EOF
}

cli_version() {
    cd "$CBASH_DIR" || return 1
    local version commit
    version=$(git describe --tags HEAD 2>/dev/null) || \
    version=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || \
    version="unknown"
    commit=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    echo "CBASH $version ($commit)"
}

cli_plugins() {
    echo "Available plugins:"
    for plugin in "$CBASH_DIR/plugins"/*/*.plugin.sh 2>/dev/null; do
        [[ -f "$plugin" ]] && echo "  $(basename "$(dirname "$plugin")")"
    done | sort
}

cli_update() {
    [[ -f "$CBASH_DIR/tools/upgrade.sh" ]] && source "$CBASH_DIR/tools/upgrade.sh"
}

cli_reload() {
    echo "Reloading shell..."
    exec "$SHELL"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'cli' \
            'help        Show help' \
            'version     Show version' \
            'plugins     List plugins' \
            'update      Update CBASH' \
            'reload      Reload shell' \
            'CLI management'
        return 0
    fi

    case "$cmd" in
        help)    cli_help ;;
        version) cli_version ;;
        plugins) cli_plugins ;;
        update)  cli_update ;;
        reload)  cli_reload ;;
        *)       echo "Unknown command: $cmd"; cli_help; return 1 ;;
    esac
}

_main "$@"