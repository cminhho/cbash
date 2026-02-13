#!/usr/bin/env bash
# Cheat plugin for CBASH
# View and manage command-line cheatsheets

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# Configuration
readonly CHEAT_COMMUNITY_DIR="${CHEAT_COMMUNITY_DIR:-$HOME/.config/cbash/cheatsheets/community}"
readonly CHEAT_PERSONAL_DIR="${CHEAT_PERSONAL_DIR:-$HOME/.config/cbash/cheatsheets/personal}"
readonly CHEAT_REPO="https://github.com/cheat/cheatsheets"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

ch() { cheat_view "$@"; }
alias chlist='cheat_list'
alias chsetup='cheat_setup'
alias chedit='cheat_edit'
alias chconf='cheat_conf'

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_cheat_ensure_dirs() {
    [[ -d "$CHEAT_COMMUNITY_DIR" ]] || mkdir -p "$CHEAT_COMMUNITY_DIR"
    [[ -d "$CHEAT_PERSONAL_DIR" ]] || mkdir -p "$CHEAT_PERSONAL_DIR"
}

_cheat_find() {
    local name="$1"
    local file=""

    # Check personal first, then community
    [[ -f "$CHEAT_PERSONAL_DIR/$name" ]] && file="$CHEAT_PERSONAL_DIR/$name"
    [[ -z "$file" && -f "$CHEAT_PERSONAL_DIR/$name.md" ]] && file="$CHEAT_PERSONAL_DIR/$name.md"
    [[ -z "$file" && -f "$CHEAT_COMMUNITY_DIR/$name" ]] && file="$CHEAT_COMMUNITY_DIR/$name"

    echo "$file"
}

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

cheat_list() {
    _cheat_ensure_dirs

    echo "Community: $CHEAT_COMMUNITY_DIR"
    [[ -d "$CHEAT_COMMUNITY_DIR" ]] && ls "$CHEAT_COMMUNITY_DIR" 2>/dev/null | head -20
    echo ""
    echo "Personal: $CHEAT_PERSONAL_DIR"
    [[ -d "$CHEAT_PERSONAL_DIR" ]] && ls "$CHEAT_PERSONAL_DIR" 2>/dev/null
}

cheat_setup() {
    _cheat_ensure_dirs

    if [[ -d "$CHEAT_COMMUNITY_DIR/.git" ]]; then
        echo "Updating community cheatsheets..."
        git -C "$CHEAT_COMMUNITY_DIR" pull --quiet
    else
        echo "Downloading community cheatsheets..."
        rm -rf "$CHEAT_COMMUNITY_DIR"
        git clone --quiet "$CHEAT_REPO" "$CHEAT_COMMUNITY_DIR"
    fi

    success "Cheatsheets ready at $CHEAT_COMMUNITY_DIR"
}

cheat_edit() {
    local name="$1"
    [[ -z "$name" ]] && { echo "Usage: cheat edit <name>"; return 1; }

    _cheat_ensure_dirs
    local file="$CHEAT_PERSONAL_DIR/$name"
    ${EDITOR:-vim} "$file"
}

cheat_view() {
    local name="$1"
    [[ -z "$name" ]] && { echo "Usage: cheat <name>"; return 1; }

    local file
    file=$(_cheat_find "$name")

    if [[ -n "$file" && -f "$file" ]]; then
        cat "$file"
    else
        echo "Cheatsheet '$name' not found."
        echo "Run 'cbash cheat setup' to download community cheatsheets."
        return 1
    fi
}

cheat_conf() {
    cat <<EOF
cheatpaths:
  - name: community
    path: $CHEAT_COMMUNITY_DIR
    readonly: true
  - name: personal
    path: $CHEAT_PERSONAL_DIR
    readonly: false
EOF
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

cheat_help() {
    _describe command 'cheat' \
        '<name>          View cheatsheet' \
        'list            List available cheatsheets' \
        'edit <name>     Edit or create personal cheatsheet' \
        'setup           Download community cheatsheets' \
        'conf            Show configuration' \
        'aliases         List cheat aliases' \
        'Command-line cheatsheet viewer'
}

cheat_list_aliases() {
    echo "Cheat aliases: ch, chlist, chsetup, chedit, chconf"
    echo "  ch <name>     = view cheatsheet"
    echo "  chlist       = list cheatsheets"
    echo "  chsetup      = download/update community cheatsheets"
    echo "  chedit <name>= edit personal cheatsheet"
    echo "  chconf       = show config"
}

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        cheat_help
        return 0
    fi

    case "$cmd" in
        help|--help|-h) cheat_help ;;
        aliases)        cheat_list_aliases ;;
        list)           cheat_list ;;
        setup)          cheat_setup ;;
        edit)           shift; cheat_edit "$@" ;;
        conf)           cheat_conf ;;
        *)              cheat_view "$cmd" ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"