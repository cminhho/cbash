#!/usr/bin/env bash
# CBASH - Command-line tools for development workflow

# Works with bash and zsh
[[ -z "$BASH_VERSION" && -z "$ZSH_VERSION" ]] && { echo "Error: cbash requires bash or zsh" >&2; return 1 2>/dev/null || exit 1; }

# Avoid "read-only variable" when cbash.sh is sourced more than once (e.g. reload)
[[ -z "${CBASH_VERSION:-}" ]] && readonly CBASH_VERSION="1.0.0"
# Default: directory of this script if it looks like cbash install, else ~/.cbash
if [[ -z "$CBASH_DIR" ]]; then
  _cbash_script="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  if [[ -f "$_cbash_script/lib/plugin.sh" ]]; then
    export CBASH_DIR="$_cbash_script"
  else
    export CBASH_DIR="${HOME}/.cbash"
  fi
  unset _cbash_script
fi
export CBASH_DIR

# -----------------------------------------------------------------------------
# Init
# -----------------------------------------------------------------------------

_init() {
    [[ -d "$CBASH_DIR" ]] || { echo "Error: CBASH_DIR not found" >&2; exit 1; }
    [[ -f "$CBASH_DIR/lib/plugin.sh" ]] && source "$CBASH_DIR/lib/plugin.sh"
    for f in "$CBASH_DIR/plugins/aliases"/*.sh; do
        [[ -f "$f" && "${f##*/}" != "aliases.plugin.sh" ]] && source "$f"
    done
    [[ -f "$CBASH_DIR/plugins/mvn/mvn.plugin.sh" ]] && source "$CBASH_DIR/plugins/mvn/mvn.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/npm/npm.plugin.sh" ]] && source "$CBASH_DIR/plugins/npm/npm.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/docker/docker.plugin.sh" ]] && source "$CBASH_DIR/plugins/docker/docker.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/git/git.plugin.sh" ]] && source "$CBASH_DIR/plugins/git/git.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/macos/macos.plugin.sh" ]] && source "$CBASH_DIR/plugins/macos/macos.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/dev/dev.plugin.sh" ]] && source "$CBASH_DIR/plugins/dev/dev.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/setup/setup.plugin.sh" ]] && source "$CBASH_DIR/plugins/setup/setup.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/gen/gen.plugin.sh" ]] && source "$CBASH_DIR/plugins/gen/gen.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/cheat/cheat.plugin.sh" ]] && source "$CBASH_DIR/plugins/cheat/cheat.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/aws/aws.plugin.sh" ]] && source "$CBASH_DIR/plugins/aws/aws.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/k8s/k8s.plugin.sh" ]] && source "$CBASH_DIR/plugins/k8s/k8s.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/proxy/proxy.plugin.sh" ]] && source "$CBASH_DIR/plugins/proxy/proxy.plugin.sh"
    [[ -f "$CBASH_DIR/plugins/ai/ai.plugin.sh" ]] && source "$CBASH_DIR/plugins/ai/ai.plugin.sh"
}

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

_help() {
    [[ -f "$CBASH_DIR/plugins/hint/hint.sh" ]] && "$CBASH_DIR/plugins/hint/hint.sh" && return
    echo "cbash v$CBASH_VERSION - Run 'cbash help' for commands"
}

_conf() {
    cat <<EOF
CBASH v$CBASH_VERSION
  CBASH_DIR: $CBASH_DIR
  DEBUG: ${DEBUG:-false}
EOF
}

_run() {
    local cmd="$1"; shift
    
    case "$cmd" in
        help|--help|-h)     _help ;;
        -v|--version)       echo "cbash v$CBASH_VERSION" ;;
        conf|config|info)   _conf ;;
        cli)                "$CBASH_DIR/lib/cli.sh" "$@" ;;
        list-plugins)       cbash_list_plugins ;;
        uuid)               uuidgen ;;
        refresh)            source "$CBASH_DIR/cbash.sh" ;;
        *)
            # Plugin auto-discovery
            local plugin="$CBASH_DIR/plugins/$cmd/$cmd.plugin.sh"
            [[ -f "$plugin" ]] && { "$plugin" "$@"; return; }
            
            # Aliases
            case "$cmd" in
                mac|misc)                   "$CBASH_DIR/plugins/macos/macos.plugin.sh" "$@" ;;
                doc|docs)                   "$CBASH_DIR/plugins/docs/docs.plugin.sh" "$@" ;;
                alias|aliases)              "$CBASH_DIR/plugins/aliases/aliases.plugin.sh" "$@" ;;
                clone|pull|open)            "$CBASH_DIR/plugins/git/git.plugin.sh" "$cmd" "$@" ;;
                log|logs|stop|exec|status|kill|kill-all) "$CBASH_DIR/plugins/dev/dev.plugin.sh" "$cmd" "$@" ;;
                ssm|login)                  "$CBASH_DIR/plugins/aws/aws.plugin.sh" "$cmd" "$@" ;;
                *)                          echo "Unknown: $cmd. Run 'cbash help'" >&2; return 1 ;;
            esac
            ;;
    esac
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

# Only run if executed directly (not sourced)
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
