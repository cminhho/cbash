#!/bin/sh
# Uninstall cbash-cli. Run from repo or set CBASH_DIR.

set -e
TOOLS_DIR="$(cd "$(dirname "$0")" && pwd)"
CBASH_DIR="${CBASH_DIR:-$HOME/.cbash}"
. "$TOOLS_DIR/common.sh"

# Confirm
printf "Uninstall cbash-cli from $CBASH_DIR? [y/N] "
read -r answer
case "$answer" in
    [Yy]*) ;;
    *) warn "Cancelled"; exit 0 ;;
esac

# Remove directory
[ -d "$CBASH_DIR" ] && rm -rf "$CBASH_DIR" && warn "Removed $CBASH_DIR"

# Remove from shell configs
remove_from_shell() {
    local file="$1"
    [ -f "$file" ] || return 0
    if grep -q "CBASH_DIR" "$file" 2>/dev/null; then
        sed -i.bak '/CBASH_DIR/d' "$file" 2>/dev/null || sed -i '' '/CBASH_DIR/d' "$file"
        sed -i.bak '/# CBASH CLI/d' "$file" 2>/dev/null || sed -i '' '/# CBASH CLI/d' "$file"
        rm -f "${file}.bak"
        warn "Cleaned $file"
    fi
}

remove_from_shell "$HOME/.bashrc"
remove_from_shell "$HOME/.zshrc"
remove_from_shell "$HOME/.bash_profile"

success "✓ cbash-cli uninstalled"
