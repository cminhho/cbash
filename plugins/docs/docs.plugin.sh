#!/usr/bin/env bash
# Docs plugin for CBASH
# View and manage documentation and cheatsheets

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# Configuration
readonly DOCS_DIR="${DOCS_DIR:-$HOME/.config/cbash/docs}"
readonly CHEAT_COMMUNITY_DIR="${CHEAT_COMMUNITY_DIR:-$HOME/.config/cbash/cheatsheets/community}"
readonly CHEAT_PERSONAL_DIR="${CHEAT_PERSONAL_DIR:-$HOME/.config/cbash/cheatsheets/personal}"
readonly CHEAT_REPO="https://github.com/cheat/cheatsheets"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias doc='docs_view'
alias ch='docs_cheat'
alias chlist='docs_cheat_list'
alias chsetup='docs_cheat_setup'
alias chedit='docs_cheat_edit'

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_docs_ensure_dir() {
    [[ -d "$DOCS_DIR" ]] || mkdir -p "$DOCS_DIR"
}

_cheat_ensure_dirs() {
    [[ -d "$CHEAT_COMMUNITY_DIR" ]] || mkdir -p "$CHEAT_COMMUNITY_DIR"
    [[ -d "$CHEAT_PERSONAL_DIR" ]] || mkdir -p "$CHEAT_PERSONAL_DIR"
}

_docs_find() {
    local name="$1"
    local file=""
    [[ -f "$DOCS_DIR/$name" ]] && file="$DOCS_DIR/$name"
    [[ -z "$file" && -f "$DOCS_DIR/$name.md" ]] && file="$DOCS_DIR/$name.md"
    [[ -z "$file" && -f "$DOCS_DIR/work-with-$name.md" ]] && file="$DOCS_DIR/work-with-$name.md"
    echo "$file"
}

_cheat_find() {
    local name="$1"
    local file=""
    [[ -f "$CHEAT_PERSONAL_DIR/$name" ]] && file="$CHEAT_PERSONAL_DIR/$name"
    [[ -z "$file" && -f "$CHEAT_PERSONAL_DIR/$name.md" ]] && file="$CHEAT_PERSONAL_DIR/$name.md"
    [[ -z "$file" && -f "$CHEAT_COMMUNITY_DIR/$name" ]] && file="$CHEAT_COMMUNITY_DIR/$name"
    echo "$file"
}

# -----------------------------------------------------------------------------
# Docs Commands
# -----------------------------------------------------------------------------

docs_list() {
    _docs_ensure_dir
    if [[ -d "$DOCS_DIR" ]] && [[ -n "$(ls -A "$DOCS_DIR" 2>/dev/null)" ]]; then
        log_info "Documents: $DOCS_DIR"
        ls "$DOCS_DIR"
    else
        log_info "No documents found in $DOCS_DIR"
        log_info "Create documents with: cbash docs edit <name>"
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

# -----------------------------------------------------------------------------
# Cheat Commands
# -----------------------------------------------------------------------------

docs_cheat() {
    local name="$1"
    [[ -z "$name" ]] && { log_error "Usage: docs cheat <name>"; return 1; }
    local file
    file=$(_cheat_find "$name")
    if [[ -n "$file" && -f "$file" ]]; then
        cat "$file"
    else
        log_error "Cheatsheet '$name' not found."
        log_info "Run 'cbash docs cheat-setup' to download community cheatsheets."
        return 1
    fi
}

docs_cheat_list() {
    _cheat_ensure_dirs
    echo "Community: $CHEAT_COMMUNITY_DIR"
    [[ -d "$CHEAT_COMMUNITY_DIR" ]] && ls "$CHEAT_COMMUNITY_DIR" 2>/dev/null | head -20
    echo ""
    echo "Personal: $CHEAT_PERSONAL_DIR"
    [[ -d "$CHEAT_PERSONAL_DIR" ]] && ls "$CHEAT_PERSONAL_DIR" 2>/dev/null
}

docs_cheat_setup() {
    _cheat_ensure_dirs
    if [[ -d "$CHEAT_COMMUNITY_DIR/.git" ]]; then
        log_info "Updating community cheatsheets..."
        git -C "$CHEAT_COMMUNITY_DIR" pull --quiet
    else
        log_info "Downloading community cheatsheets..."
        rm -rf "$CHEAT_COMMUNITY_DIR"
        git clone --quiet "$CHEAT_REPO" "$CHEAT_COMMUNITY_DIR"
    fi
    log_success "Cheatsheets ready at $CHEAT_COMMUNITY_DIR"
}

docs_cheat_edit() {
    local name="$1"
    [[ -z "$name" ]] && { log_error "Usage: docs cheat-edit <name>"; return 1; }
    _cheat_ensure_dirs
    ${EDITOR:-vim} "$CHEAT_PERSONAL_DIR/$name"
}

# -----------------------------------------------------------------------------
# Config
# -----------------------------------------------------------------------------

docs_conf() {
    cat <<EOF
docs_dir: $DOCS_DIR
cheat_community: $CHEAT_COMMUNITY_DIR
cheat_personal: $CHEAT_PERSONAL_DIR
EOF
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

docs_help() {
    _describe command 'docs' \
        '<name>          View document' \
        'list            List documents' \
        'edit <name>     Edit document' \
        'cheat <name>    View cheatsheet' \
        'cheat-list      List cheatsheets' \
        'cheat-setup     Download community cheatsheets' \
        'cheat-edit <n>  Edit personal cheatsheet' \
        'conf            Show configuration' \
        'Documentation and cheatsheet viewer'
}

docs_list_aliases() {
    echo "Docs aliases: doc, ch, chlist, chsetup, chedit"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") docs_help ;;
        aliases)           docs_list_aliases ;;
        list)              docs_list ;;
        edit)              shift; docs_edit "$@" ;;
        cheat)             shift; docs_cheat "$@" ;;
        cheat-list)        docs_cheat_list ;;
        cheat-setup)       docs_cheat_setup ;;
        cheat-edit)        shift; docs_cheat_edit "$@" ;;
        conf)              docs_conf ;;
        *)                 docs_view "$1" ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
