#!/bin/sh
# Uninstall cbash-cli

set -e
. "$(cd "$(dirname "$0")" && pwd)/common.sh"

# Confirm
printf "Uninstall cbash-cli from $CBASH_DIR? [y/N] "
read -r answer
case "$answer" in [Yy]*) ;; *) warn "Cancelled"; exit 0 ;; esac

# Remove directory
[ -d "$CBASH_DIR" ] && rm -rf "$CBASH_DIR" && warn "Removed $CBASH_DIR"

# Remove from shell configs
remove_from_shell() {
    [ -f "$1" ] || return 0
    grep -q "cbash" "$1" 2>/dev/null || return 0
    sed -i.bak '/cbash/d' "$1" 2>/dev/null || sed -i '' '/cbash/d' "$1"
    sed -i.bak '/# CBASH/d' "$1" 2>/dev/null || sed -i '' '/# CBASH/d' "$1"
    rm -f "$1.bak"
    warn "Cleaned $1"
}
remove_from_shell "$HOME/.zshrc"
remove_from_shell "$HOME/.bashrc"
remove_from_shell "$HOME/.bash_profile"

success "cbash-cli uninstalled"
