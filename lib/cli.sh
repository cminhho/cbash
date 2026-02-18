#!/usr/bin/env bash
# CLI management (cbash cli <cmd>)

[[ -d "$CBASH_DIR" ]] || { echo "Error: CBASH_DIR not set" >&2; exit 1; }
source "$CBASH_DIR/lib/common.sh"

cli_help() {
    cat <<'EOF'
Usage: cbash cli <command>

Commands:
  help            Show this help
  version         Show version
  plugins         List plugins
  install-local   Copy local dev to install dir
  update          Update CBASH
  reload          Reload shell
EOF
}

cli_version() {
    [[ -d "$CBASH_DIR/.git" ]] || { echo "CBASH ${CBASH_VERSION:-unknown}"; return; }
    local ver
    ver=$(git -C "$CBASH_DIR" describe --tags HEAD 2>/dev/null || git -C "$CBASH_DIR" rev-parse --short HEAD)
    echo "CBASH ${ver:-unknown}"
}

cli_install_local() {
    local src="${1:-$(pwd)}" dest="$CBASH_DIR"
    [[ -f "$src/cbash.sh" ]] || { echo "Error: Not a cbash tree" >&2; return 1; }
    [[ "$(cd "$src" && pwd)" == "$(cd "$dest" && pwd)" ]] && { echo "Same directory"; return 0; }
    rsync -a --delete --exclude='.git' "$src/" "$dest/" && cli_reload
}

cli_reload() { echo "Reloading..."; exec "${SHELL:-/bin/bash}"; }
cli_update() { bash "$CBASH_DIR/tools/upgrade.sh"; }

_main() {
    case "${1:-help}" in
        help)          cli_help ;;
        version)       cli_version ;;
        plugins)       cbash_list_plugins ;;
        install-local) shift; cli_install_local "$@" ;;
        update)        cli_update ;;
        reload)        cli_reload ;;
        *)             echo "Unknown: $1" >&2; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"