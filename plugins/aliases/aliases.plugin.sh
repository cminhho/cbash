#!/usr/bin/env bash
# Aliases plugin for CBASH
# Shell aliases management

source "$CBASH_DIR/lib/common.sh"

readonly ALIASES_DIR="$CBASH_DIR/plugins/aliases"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

aliases_list() {
    echo "Available aliases:"
    for f in "$ALIASES_DIR"/*.sh; do
        [[ -f "$f" ]] || continue
        local name=$(basename "$f" .sh)
        [[ "$name" == "aliases.plugin" ]] && continue
        local count=$(grep -c "^alias " "$f" 2>/dev/null || echo 0)
        echo "  $name ($count aliases)"
    done
}

aliases_show() {
    local name="$1"
    [[ -z "$name" ]] && { echo "Usage: aliases show <name>"; return 1; }

    local file="$ALIASES_DIR/${name}.sh"
    [[ -f "$file" ]] || { echo "Not found: $name"; return 1; }

    grep "^alias " "$file" | sed 's/alias /  /'
}

aliases_edit() {
    local name="$1"
    [[ -z "$name" ]] && { echo "Usage: aliases edit <name>"; return 1; }

    local file="$ALIASES_DIR/${name}.sh"
    ${EDITOR:-vim} "$file"
}

aliases_load() {
    for f in "$ALIASES_DIR"/*.sh; do
        [[ -f "$f" ]] || continue
        local name=$(basename "$f")
        [[ "$name" == "aliases.plugin.sh" ]] && continue
        source "$f"
    done
    success "Aliases loaded"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'aliases' \
            'list            List alias files' \
            'show <name>     Show aliases in file' \
            'edit <name>     Edit alias file' \
            'load            Load all aliases' \
            'Shell aliases manager'
        return 0
    fi

    case "$cmd" in
        list) aliases_list ;;
        show) shift; aliases_show "$@" ;;
        edit) shift; aliases_edit "$@" ;;
        load) aliases_load ;;
        *)    echo "Unknown command: $cmd"; return 1 ;;
    esac
}

_main "$@"