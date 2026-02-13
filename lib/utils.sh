#!/usr/bin/env bash
# CBASH Utilities - Colors, Logging, Functions
# shellcheck disable=SC2034

# =============================================================================
# Colors
# =============================================================================
clr='\033[0m'
rst='\033[0m'

# Regular
txtred='\033[0;31m'
txtgrn='\033[0;32m'
txtylw='\033[0;33m'
txtblu='\033[0;34m'
txtcyn='\033[0;36m'

# Bold
bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldylw='\033[1;33m'
bldblu='\033[1;34m'
bldcyn='\033[1;36m'
bldwht='\033[1;37m'

# Muted / secondary (dim)
dim='\033[2;37m'

# =============================================================================
# Semantic theme (reusable; change here for theming)
# =============================================================================
style_heading="$bldblu"
style_label="$bldcyn"
style_ok="$txtgrn"
style_err="$txtred"
style_warn="$txtylw"
style_muted="$dim"

# Background
bakred='\033[41m'
bakgrn='\033[42m'
bakylw='\033[43m'
bakblu='\033[44m'

# =============================================================================
# Logging
# =============================================================================
success() { printf "${txtgrn}✓${clr} %s\n" "$*"; }
info()    { printf "${txtblu}ℹ${clr} %s\n" "$*"; }
warn()    { printf "${txtylw}⚠${clr} %s\n" "$*" >&2; }
err()     { printf "${txtred}✗${clr} %s\n" "$*" >&2; }
debug()   { [[ -n "$DEBUG" ]] && printf "[DEBUG] %s\n" "$*"; }
abort()   { err "$@"; exit 1; }

# Aliases
error() { err "$@"; }
note()  { info "$@"; }

# =============================================================================
# Functions
# =============================================================================
_command_exists() { command -v "$1" &>/dev/null; }

mkcd() { mkdir -p "$1" && cd "$1"; }

takegit() { git clone "$1" && cd "$(basename "${1%%.git}")"; }
