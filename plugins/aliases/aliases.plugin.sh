#!/usr/bin/env bash
# Aliases plugin for CBASH - Shell aliases management

readonly ALIASES_DIR="$CBASH_DIR/plugins/aliases"

# Commands
aliases_list() {
    echo "Available aliases:"
    for f in "$ALIASES_DIR"/*.sh; do
        [[ -f "$f" ]] || continue
        local name=$(basename "$f" .sh); [[ "$name" == "aliases.plugin" ]] && continue
        echo "  $name ($(grep -c "^alias " "$f" 2>/dev/null || echo 0) aliases)"
    done
}

aliases_show() {
    [[ -n "$1" ]] || { log_error "Usage: aliases show <name>"; return 1; }
    local file="$ALIASES_DIR/${1}.sh"
    [[ -f "$file" ]] || { log_error "Not found: $1"; return 1; }
    grep "^alias " "$file" | sed 's/alias /  /'
}

aliases_edit() {
    [[ -n "$1" ]] || { log_error "Usage: aliases edit <name>"; return 1; }
    ${EDITOR:-vim} "$ALIASES_DIR/${1}.sh"
}

aliases_load() {
    for f in "$ALIASES_DIR"/*.sh; do
        [[ -f "$f" && "$(basename "$f")" != "aliases.plugin.sh" ]] && source "$f"
    done
    log_success "Aliases loaded"
}

# Help and router
aliases_help() {
    _describe command 'aliases' \
        'list            List alias files' \
        'show <name>     Show aliases' \
        'edit <name>     Edit alias file' \
        'load            Load all aliases' \
        'Shell aliases manager'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") aliases_help ;;
        list)  aliases_list ;;
        show)  shift; aliases_show "$@" ;;
        edit)  shift; aliases_edit "$@" ;;
        load)  aliases_load ;;
        *)     log_error "Unknown: $1"; return 1 ;;
    esac
}

