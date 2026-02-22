#!/bin/sh
# Install cbash-cli
# Usage: sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
# Env: CBASH_DIR, CBASH_DATA_DIR (default: ~/.cbash), REPO, BRANCH. Creates ~/.cbashrc if missing.

set -e

# Config
CBASH_DIR="${CBASH_DIR:-$HOME/.cbash}"
CBASH_DATA_DIR="${CBASH_DATA_DIR:-$HOME/.cbash}"
REPO="${REPO:-cminhho/cbash}"
REMOTE="https://github.com/${REPO}.git"
BRANCH="${BRANCH:-master}"

# Colors (inline - can't source common.sh before clone)
RED='\033[31m'; GREEN='\033[32m'; YELLOW='\033[33m'; BLUE='\033[34m'; RST='\033[0m'
error()   { printf "${RED}Error: %s${RST}\n" "$*" >&2; exit 1; }
info()    { printf "${BLUE}%s${RST}\n" "$*"; }
success() { printf "${GREEN}%s${RST}\n" "$*"; }

# Check git
command -v git >/dev/null 2>&1 || error "git is not installed"

# Install/update
info "Installing cbash-cli to $CBASH_DIR..."
if [ -d "$CBASH_DIR/.git" ]; then
    git -C "$CBASH_DIR" pull --rebase origin "$BRANCH" 2>/dev/null || true
else
    rm -rf "$CBASH_DIR" 2>/dev/null || true
    git clone --depth=1 -b "$BRANCH" "$REMOTE" "$CBASH_DIR"
fi
chmod +x "$CBASH_DIR/cbash.sh"

# Copy templates/ tree to global data dir. One source: add files under templates/ and they are copied.
# Never overwrites existing files (user edits in ~/.cbash are kept).
copy_global_templates() {
    data_dir="$1"
    repo_dir="$2"
    src_dir="${repo_dir}/templates"
    [ -d "$src_dir" ] || return 0
    src_dir="${src_dir%/}"
    find "$src_dir" -type f 2>/dev/null | while IFS= read -r f; do
        [ -n "$f" ] || continue
        rel="${f#$src_dir/}"
        dest="$data_dir/$rel"
        if [ ! -f "$dest" ]; then
            dir="${dest%/*}"
            mkdir -p "$dir" && cp "$f" "$dest" && info "Copied to $dest"
        fi
    done
}
info "Setting up global config in $CBASH_DATA_DIR..."
copy_global_templates "$CBASH_DATA_DIR" "$CBASH_DIR"

# Copy default .cbashrc to user home. If one exists, rename to .cbashrc.bak then copy default.
CBASHRC="${HOME}/.cbashrc"
CBASHRC_DEFAULT="${CBASH_DIR}/tools/cbashrc.default"
if [ -f "$CBASHRC_DEFAULT" ]; then
    if [ -f "$CBASHRC" ]; then
        mv "$CBASHRC" "${CBASHRC}.bak"
        info "Backed up to ${CBASHRC}.bak"
    fi
    cp "$CBASHRC_DEFAULT" "$CBASHRC"
    info "Installed $CBASHRC"
fi

# Add to shell config
add_to_shell() {
    [ -f "$1" ] || return 0
    grep -q "cbash.sh" "$1" 2>/dev/null && return 0
    printf '\n# CBASH CLI\nsource "%s/cbash.sh"\n' "$CBASH_DIR" >> "$1"
    info "Added to $1"
}
add_to_shell "$HOME/.zshrc"
add_to_shell "$HOME/.bashrc"
add_to_shell "$HOME/.bash_profile"

success "cbash-cli installed!"
printf "${YELLOW}Restart terminal or: source ~/.zshrc${RST}\n"
printf "${YELLOW}Then try: cbash help${RST}\n"