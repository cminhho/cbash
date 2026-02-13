#!/usr/bin/env bash
# CLI management for CBASH

[[ -n "$CBASH_DIR" && -d "$CBASH_DIR" ]] || { echo "Error: CBASH_DIR not set or not a directory" >&2; exit 1; }
source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

cli_help() {
    cat <<EOF
Usage: cbash cli <command>

Commands:
  help          Show this help
  version       Show version
  plugins       List available plugins
  install-local [dir]  Copy local dev copy to install dir (for testing)
  update        Update CBASH
  reload        Reload shell
EOF
}

cli_version() {
    [[ -d "$CBASH_DIR/.git" ]] || { echo "CBASH ${CBASH_VERSION:-unknown} (not a git repo)"; return 0; }
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
    for plugin in "$CBASH_DIR/plugins"/*/*.plugin.sh; do
        [[ -f "$plugin" ]] && echo "  $(basename "$(dirname "$plugin")")"
    done | sort -u
}

# Copy local folder into CBASH_DIR (for testing without commit/push).
# Usage: cbash cli install-local [source_dir]
#   If source_dir omitted, uses current directory (pwd).
cli_install_local() {
    local src="${1:-$(pwd)}"
    local src_abs dest_abs
    src_abs=$(cd "$src" 2>/dev/null && pwd) || { echo "Error: Invalid source dir: $src" >&2; return 1; }
    dest_abs=$(cd "$CBASH_DIR" 2>/dev/null && pwd) || { echo "Error: CBASH_DIR not valid" >&2; return 1; }

    if [[ "$src_abs" == "$dest_abs" ]]; then
        echo "Source and install dir are the same. Nothing to do."
        return 0
    fi
    [[ -f "$src_abs/cbash.sh" ]] || { echo "Error: Not a cbash tree (no cbash.sh in $src_abs)" >&2; return 1; }

    echo "Copying: $src_abs -> $dest_abs"
    rsync -a --delete --exclude='.git' "$src_abs/" "$dest_abs/" || { echo "Error: rsync failed" >&2; return 1; }
    echo "Done."
    cli_reload
}

cli_reload() {
    echo "Reloading shell..."
    exec "${SHELL:-/bin/bash}"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'cli' \
            'help          Show help' \
            'version       Show version' \
            'plugins       List plugins' \
            'install-local [dir] Copy local dev to install (testing)' \
            'update        Update CBASH' \
            'reload        Reload shell' \
            'CLI management'
        return 0
    fi

    case "$cmd" in
        help)           cli_help ;;
        version)        cli_version ;;
        plugins)        cli_plugins ;;
        install-local)  shift; cli_install_local "$@" ;;
        update)         cli_update ;;
        reload)         cli_reload ;;
        *)              echo "Unknown command: $cmd" >&2; cli_help; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"