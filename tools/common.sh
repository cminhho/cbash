#!/bin/sh
# Shared for tools/*.sh (install, uninstall, upgrade)
# Source from tools dir: . "$(dirname "$0")/common.sh" or with CBASH_DIR set

: "${CBASH_DIR:=$HOME/.cbash}"
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'
error()   { printf "${RED}Error: %s${RESET}\n" "$*" >&2; exit 1; }
info()    { printf "${BLUE}%s${RESET}\n" "$*"; }
success() { printf "${GREEN}%s${RESET}\n" "$*"; }
warn()    { printf "${YELLOW}%s${RESET}\n" "$*"; }
