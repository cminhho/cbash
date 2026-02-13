#!/bin/sh
# Install cbash-cli (oh-my-zsh style)
#
# Usage:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
#
# Environment variables:
#   CBASH_DIR - install path (default: ~/.cbash)
#   REPO      - repo (default: cminhho/cbash)
#   BRANCH    - branch (default: master)

set -e

# Colors
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'

# Defaults
CBASH_DIR="${CBASH_DIR:-$HOME/.cbash}"
REPO="${REPO:-cminhho/cbash}"
REMOTE="${REMOTE:-https://github.com/${REPO}.git}"
BRANCH="${BRANCH:-master}"

error() { printf "${RED}Error: %s${RESET}\n" "$*" >&2; exit 1; }
info()  { printf "${BLUE}%s${RESET}\n" "$*"; }
success() { printf "${GREEN}%s${RESET}\n" "$*"; }

# Check git
command -v git >/dev/null 2>&1 || error "git is not installed"

# Clone repo
info "Installing cbash-cli to $CBASH_DIR..."

if [ -d "$CBASH_DIR" ]; then
    info "Updating existing installation..."
    cd "$CBASH_DIR"
    git pull --rebase origin "$BRANCH" 2>/dev/null || true
else
    git clone --depth=1 -b "$BRANCH" "$REMOTE" "$CBASH_DIR"
fi

# Make executable
chmod +x "$CBASH_DIR/cbash.sh"

# Add to shell config
add_to_shell() {
    local config="$1"
    local line="export CBASH_DIR=\"$CBASH_DIR\" && source \"\$CBASH_DIR/cbash.sh\""
    
    if [ -f "$config" ]; then
        if ! grep -q "CBASH_DIR" "$config" 2>/dev/null; then
            echo "" >> "$config"
            echo "# CBASH CLI" >> "$config"
            echo "$line" >> "$config"
            info "Added to $config"
        fi
    fi
}

add_to_shell "$HOME/.bashrc"
add_to_shell "$HOME/.zshrc"
add_to_shell "$HOME/.bash_profile"

success "cbash-cli installed successfully!"
echo ""
printf "${YELLOW}Restart your terminal or run:${RESET}\n"
echo "  source ~/.zshrc  # or ~/.bashrc"
echo ""
printf "${YELLOW}Then try:${RESET}\n"
echo "  cbash help"