#!/bin/sh
# Shared utilities for tools/*.sh

: "${CBASH_DIR:=$HOME/.cbash}"

RED='\033[31m'; GREEN='\033[32m'; YELLOW='\033[33m'; BLUE='\033[34m'; RST='\033[0m'
error()   { printf "${RED}Error: %s${RST}\n" "$*" >&2; exit 1; }
info()    { printf "${BLUE}%s${RST}\n" "$*"; }
success() { printf "${GREEN}%s${RST}\n" "$*"; }
warn()    { printf "${YELLOW}%s${RST}\n" "$*"; }
