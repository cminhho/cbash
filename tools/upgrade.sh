#!/bin/sh
# Upgrade cbash-cli (run via: cbash cli update)

set -e
. "$(cd "$(dirname "$0")" && pwd)/common.sh"

[ -d "$CBASH_DIR/.git" ] || error "Not a git repository: $CBASH_DIR"

info "Upgrading cbash-cli..."
git -C "$CBASH_DIR" stash push -q -m "upgrade-$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
git -C "$CBASH_DIR" fetch --all --prune -q
git -C "$CBASH_DIR" pull --rebase -q origin master 2>/dev/null || \
git -C "$CBASH_DIR" pull --rebase -q origin main 2>/dev/null || \
error "Failed to pull updates"

success "cbash-cli upgraded"
info "Restart terminal or: source ~/.zshrc"
