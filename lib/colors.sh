#!/usr/bin/env bash
# CBASH colors — short names + semantic styles for terminal output.
# shellcheck disable=SC2034

# =============================================================================
# Core colors (used by plugins and log.sh)
# =============================================================================
clr='\033[0m'           # reset
rst='\033[0m'
dim='\033[2;37m'

# Text colors
txtred='\033[0;31m'
txtgrn='\033[0;32m'
txtylw='\033[0;33m'
txtblu='\033[0;34m'
txtcyn='\033[0;36m'

# Bold colors
bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldylw='\033[1;33m'
bldblu='\033[1;34m'
bldcyn='\033[1;36m'
bldwht='\033[1;37m'

# Background colors (used by log.sh)
bakred='\033[41m'
bakgrn='\033[42m'
bakylw='\033[43m'
bakblu='\033[44m'


# =============================================================================
# Semantic theme: set by cbash_theme or CBASH_THEME (dark | light | minimal)
# =============================================================================
: "${cbash_theme:=${CBASH_THEME:-dark}}"
case "$cbash_theme" in
    dark)
        style_heading="$bldblu"
        style_label="$bldcyn"
        style_ok="$txtgrn"
        style_err="$txtred"
        style_warn="$txtylw"
        style_muted="$dim"
        ;;
    light)
        # Light theme - same as dark for now (terminal handles contrast)
        style_heading="$bldblu"
        style_label="$bldcyn"
        style_ok="$txtgrn"
        style_err="$txtred"
        style_warn="$txtylw"
        style_muted="$dim"
        ;;
    minimal)
        style_heading="$dim"
        style_label="$dim"
        style_ok="$dim"
        style_err="$txtred"
        style_warn="$dim"
        style_muted="$dim"
        ;;
    *)
        style_heading="$bldblu"
        style_label="$bldcyn"
        style_ok="$txtgrn"
        style_err="$txtred"
        style_warn="$txtylw"
        style_muted="$dim"
        ;;
esac

# =============================================================================
# Style helpers (loaded via common.sh)
# =============================================================================
_heading()        { printf "${style_heading}%s${clr}\n" "$*"; }
_heading_muted() { local h="$1" m="$2"; shift 2; printf "${style_heading}%s${clr} ${style_muted}%s${clr}\n" "$h" "$(printf "$m" "$@")"; }
_label()          { printf "${style_label}%s${clr}" "$*"; }
_label_nl()       { printf "${style_label}%s${clr}\n" "$*"; }
_muted()          { printf "${style_muted}%s${clr}" "$*"; }
_muted_nl()       { printf "${style_muted}%s${clr}\n" "$*"; }
_ok()             { printf "  ${style_ok}✓ %s${clr}\n" "$*"; }
_err()            { printf "  ${style_err}✗ %s${clr}\n" "$*"; }
_err_stderr()     { printf "  ${style_err}✗ %s${clr}\n" "$*" >&2; }
_box()            { printf "${style_heading}▸ %s${clr}\n" "$*"; }
_box_muted()      { local t="$1" m="$2"; shift 2; printf "${style_heading}▸ %s${clr} ${style_muted}%s${clr}\n" "$t" "$(printf "$m" "$@")"; }
