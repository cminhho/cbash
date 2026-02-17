#!/bin/sh
# Upgrade cbash-cli (run via: cbash cli update)

set -e
. "$(cd "$(dirname "$0")" && pwd)/common.sh"

cd "$CBASH_DIR" 2>/dev/null || error "cbash directory not found: $CBASH_DIR"
[ -d .git ] || error "Not a git repository"

info "Upgrading cbash-cli..."
git stash push -q -m "upgrade-$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
git fetch --all --prune -q

if git pull --rebase -q origin master 2>/dev/null || git pull --rebase -q origin main 2>/dev/null; then
    success "cbash-cli upgraded"
    info "Restart terminal or: source ~/.zshrc"
else
    error "Failed to pull updates"
fi
