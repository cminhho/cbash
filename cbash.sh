#!/usr/bin/env bash
# CBASH - Command-line tools for development workflow

[[ -n "$BASH_VERSION" || -n "$ZSH_VERSION" ]] || { echo "Error: cbash requires bash or zsh" >&2; return 1 2>/dev/null || exit 1; }
[[ -z "${CBASH_VERSION:-}" ]] && readonly CBASH_VERSION="1.0.0"
if [[ -z "$CBASH_DIR" ]]; then
  _d="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  CBASH_DIR="$([[ -f "$_d/lib/plugin.sh" ]] && echo "$_d" || echo "${HOME}/.cbash")"
  unset _d
fi
export CBASH_DIR

_init() {
    [[ -d "$CBASH_DIR" ]] || { echo "Error: CBASH_DIR not found" >&2; exit 1; }
    [[ -f "$CBASH_DIR/lib/plugin.sh" ]] && source "$CBASH_DIR/lib/plugin.sh"
    local dir name
    for dir in "$CBASH_DIR/plugins/"*/; do
        name=$(basename "$dir")
        if [[ "$name" == "aliases" ]]; then
            for f in "$dir"*.sh; do [[ -f "$f" && "${f##*/}" != "aliases.plugin.sh" ]] && source "$f"; done
        fi
        [[ -f "$dir/$name.plugin.sh" ]] && source "$dir/$name.plugin.sh"
    done
}

_help() {
    [[ -f "$CBASH_DIR/plugins/hint/hint.sh" ]] && bash "$CBASH_DIR/plugins/hint/hint.sh" && return
    echo "cbash v$CBASH_VERSION - Run 'cbash help' for commands"
}

_config() {
    printf "%-10s %s\n" "version" "$CBASH_VERSION"
    printf "%-10s %s\n" "dir"     "$CBASH_DIR"
    printf "%-10s %s\n" "debug"   "${DEBUG:-false}"
}

_run_plugin() { local n="$1"; shift; bash "$CBASH_DIR/plugins/$n/$n.plugin.sh" "$@"; }

_run() {
    local cmd="$1"; shift
    case "$cmd" in
        help|--help|-h)   _help ;;
        -v|--version)    echo "cbash v$CBASH_VERSION" ;;
        config)          _config ;;
        cli)             bash "$CBASH_DIR/lib/cli.sh" "$@" ;;
        list-plugins)    cbash_list_plugins ;;
        refresh)         source "$CBASH_DIR/cbash.sh" ;;
        *)
            local p="$CBASH_DIR/plugins/$cmd/$cmd.plugin.sh"
            [[ -f "$p" ]] && { bash "$p" "$@"; return; }
            case "$cmd" in
                mac|misc)     _run_plugin macos "$@" ;;
                doc|docs)     _run_plugin docs "$@" ;;
                alias|aliases) _run_plugin aliases "$@" ;;
                clone|pull|open) _run_plugin git "$cmd" "$@" ;;
                log|logs|stop|exec|status|kill|kill-all) _run_plugin dev "$cmd" "$@" ;;
                ssm|login)    _run_plugin aws "$cmd" "$@" ;;
                *)            echo "Unknown: $cmd. Run 'cbash help'" >&2; return 1 ;;
            esac
            ;;
    esac
}

# Run when executed directly; when sourced only set alias
if [[ "${BASH_SOURCE[0]}" == "${0}" ]] || [[ -z "$ZSH_EVAL_CONTEXT" || "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
    [[ "${DEBUG:-false}" == "true" ]] && set -x
    _init
    [[ -z "$1" ]] && { _help; exit 0; }
    _run "$@"
else
    # When sourced, just init and create alias
    _init
    alias cbash='$CBASH_DIR/cbash.sh'
fi
