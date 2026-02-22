#!/usr/bin/env bash
# Docs plugin for CBASH — view, list, edit docs in DOCS_DIR

DOCS_DIR="${DOCS_DIR:-$HOME/.config/cbash/docs}"

_docs_ensure_dir() {
    [[ -d "$DOCS_DIR" ]] || mkdir -p "$DOCS_DIR"
}

_docs_find() {
    local name="$1" file=""
    [[ -f "$DOCS_DIR/$name" ]] && file="$DOCS_DIR/$name"
    [[ -z "$file" && -f "$DOCS_DIR/$name.md" ]] && file="$DOCS_DIR/$name.md"
    [[ -z "$file" && -f "$DOCS_DIR/work-with-$name.md" ]] && file="$DOCS_DIR/work-with-$name.md"
    echo "$file"
}

docs_list() {
    _docs_ensure_dir
    if [[ -d "$DOCS_DIR" ]] && [[ -n "$(ls -A "$DOCS_DIR" 2>/dev/null)" ]]; then
        log_info "Documents: $DOCS_DIR"
        ls "$DOCS_DIR"
    else
        log_info "No documents in $DOCS_DIR"
        log_info "Create: cbash docs edit <name>"
    fi
}

docs_edit() {
    local name="$1"
    [[ -z "$name" ]] && { log_error "Usage: docs edit <name>"; return 1; }
    _docs_ensure_dir
    ${EDITOR:-vim} "$DOCS_DIR/$name.md"
}

docs_view() {
    local name="$1"
    [[ -z "$name" ]] && { log_error "Usage: docs <name>"; return 1; }
    local file
    file=$(_docs_find "$name")
    if [[ -n "$file" && -f "$file" ]]; then
        cat "$file"
    else
        log_error "Document '$name' not found in $DOCS_DIR"
        return 1
    fi
}

docs_conf() {
    echo "docs_dir: $DOCS_DIR"
}

docs_help() {
    _describe command 'docs' \
        '<name>       View document' \
        'list         List documents' \
        'edit <name>  Edit document' \
        'conf         Show config' \
        'Documentation viewer'
}

docs_list_aliases() {
    echo "Docs alias: doc"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") docs_help ;;
        aliases)           docs_list_aliases ;;
        list)              docs_list ;;
        edit)              shift; docs_edit "$@" ;;
        conf)              docs_conf ;;
        *)                 docs_view "$1" ;;
    esac
}
