#!/usr/bin/env bash
# Config loader: single file ~/.cbashrc (like .zshrc). Precedence: env > config file > defaults.

: "${CBASH_CONFIG_FILE:=$HOME/.cbashrc}"
[[ -f "$CBASH_CONFIG_FILE" ]] && source "$CBASH_CONFIG_FILE" 2>/dev/null || true

: "${CBASH_DATA_DIR:=$HOME/.cbash}"
