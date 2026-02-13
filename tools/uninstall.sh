#!/bin/sh
# Uninstall cbash-cli

set -e

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
RESET='\033[0m'

CBASH_DIR="${CBASH_DIR:-$HOME/.cbash}"

info()  { printf "${YELLOW}%s${RESET}\n" "$*"; }
success() { printf "${GREEN}✓ %s${RESET}\n" "$*"; }

# Confirm
printf "Uninstall cbash-cli from $CBASH_DIR? [y/N] "
read -r answer
case "$answer" in
    [Yy]*) ;;
    *) info "Cancelled"; exit 0 ;;
esac

# Remove directory
[ -d "$CBASH_DIR" ] && rm -rf "$CBASH_DIR" && info "Removed $CBASH_DIR"

# Remove from shell configs
remove_from_shell() {
    local file="$1"
    [ -f "$file" ] || return 0
    if grep -q "CBASH_DIR" "$file" 2>/dev/null; then
        sed -i.bak '/CBASH_DIR/d' "$file" 2>/dev/null || sed -i '' '/CBASH_DIR/d' "$file"
        sed -i.bak '/# CBASH CLI/d' "$file" 2>/dev/null || sed -i '' '/# CBASH CLI/d' "$file"
        rm -f "${file}.bak"
        info "Cleaned $file"
    fi
}

remove_from_shell "$HOME/.bashrc"
remove_from_shell "$HOME/.zshrc"
remove_from_shell "$HOME/.bash_profile"

success "cbash-cli uninstalled"
