#!/usr/bin/env bash
# CBASH colors and style helpers
# shellcheck disable=SC2034

# Reset
clr='\033[0m'; rst='\033[0m'; dim='\033[2;37m'

# Text colors
txtred='\033[0;31m'; txtgrn='\033[0;32m'; txtylw='\033[0;33m'; txtblu='\033[0;34m'; txtcyn='\033[0;36m'

# Bold colors
bldred='\033[1;31m'; bldgrn='\033[1;32m'; bldylw='\033[1;33m'; bldblu='\033[1;34m'; bldcyn='\033[1;36m'; bldwht='\033[1;37m'

# Background colors
bakred='\033[41m'; bakgrn='\033[42m'; bakylw='\033[43m'; bakblu='\033[44m'

# Semantic styles (theme: CBASH_THEME=dark|minimal)
if [[ "${CBASH_THEME:-dark}" == "minimal" ]]; then
    style_heading="$dim"; style_label="$dim"; style_ok="$dim"; style_err="$txtred"; style_warn="$dim"; style_muted="$dim"
else
    style_heading="$bldblu"; style_label="$bldcyn"; style_ok="$txtgrn"; style_err="$txtred"; style_warn="$txtylw"; style_muted="$dim"
fi

# Style helpers
_heading()       { printf "${style_heading}%s${clr}\n" "$*"; }
_heading_muted() { printf "${style_heading}%s${clr} ${style_muted}%s${clr}\n" "$1" "$2"; }
_label()         { printf "${style_label}%s${clr}" "$*"; }
_label_nl()      { printf "${style_label}%s${clr}\n" "$*"; }
_muted()         { printf "${style_muted}%s${clr}" "$*"; }
_muted_nl()      { printf "${style_muted}%s${clr}\n" "$*"; }
_ok()            { printf "  ${style_ok}✓ %s${clr}\n" "$*"; }
_err()           { printf "  ${style_err}✗ %s${clr}\n" "$*"; }
_err_stderr()    { printf "  ${style_err}✗ %s${clr}\n" "$*" >&2; }
_box()           { printf "${style_heading}▸ %s${clr}\n" "$*"; }
_box_muted()     { printf "${style_heading}▸ %s${clr} ${style_muted}%s${clr}\n" "$1" "$2"; }
