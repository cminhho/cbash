#!/bin/sh
# Upgrade cbash-cli to latest version

set -e

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
RESET='\033[0m'

CBASH_DIR="${CBASH_DIR:-$HOME/.cbash}"

error()   { printf "${RED}✗ %s${RESET}\n" "$*" >&2; exit 1; }
success() { printf "${GREEN}✓ %s${RESET}\n" "$*"; }
info()    { printf "${YELLOW}%s${RESET}\n" "$*"; }

# Validate
cd "$CBASH_DIR" 2>/dev/null || error "cbash directory not found: $CBASH_DIR"
[ -d .git ] || error "Not a git repository"

info "Upgrading cbash-cli..."

# Stash and pull
git stash push -q -m "upgrade-$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
git fetch --all --prune -q

if git pull --rebase -q origin master 2>/dev/null || git pull --rebase -q origin main 2>/dev/null; then
    success "cbash-cli upgraded"
    info "Restart terminal or: source ~/.zshrc"
else
    error "Failed to pull updates"
fi
