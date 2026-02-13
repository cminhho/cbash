#!/usr/bin/env bash
# CBASH colors — Bash-it style (echo_*) + short names (txt*, bld*) + semantic (style_*).
# Reference: https://github.com/Bash-it/bash-it/blob/master/lib/colors.bash
# Load: via common.sh (utils.sh sources this). Use: printf "${echo_red}text${echo_normal}\n"
# shellcheck disable=SC2034

# =============================================================================
# Raw codes (single source)
# =============================================================================
echo_normal='\033[0m'
echo_reset='\033[39m'

echo_black='\033[0;30m'
echo_red='\033[0;31m'
echo_green='\033[0;32m'
echo_yellow='\033[0;33m'
echo_blue='\033[0;34m'
echo_purple='\033[0;35m'
echo_cyan='\033[0;36m'
echo_white='\033[0;37m'
echo_orange='\033[0;91m'

echo_bold_black='\033[1;30m'
echo_bold_red='\033[1;31m'
echo_bold_green='\033[1;32m'
echo_bold_yellow='\033[1;33m'
echo_bold_blue='\033[1;34m'
echo_bold_purple='\033[1;35m'
echo_bold_cyan='\033[1;36m'
echo_bold_white='\033[1;37m'
echo_bold_orange='\033[1;91m'

echo_underline_black='\033[4;30m'
echo_underline_red='\033[4;31m'
echo_underline_green='\033[4;32m'
echo_underline_yellow='\033[4;33m'
echo_underline_blue='\033[4;34m'
echo_underline_purple='\033[4;35m'
echo_underline_cyan='\033[4;36m'
echo_underline_white='\033[4;37m'

echo_bg_black='\033[40m'
echo_bg_red='\033[41m'
echo_bg_green='\033[42m'
echo_bg_yellow='\033[43m'
echo_bg_blue='\033[44m'
echo_bg_purple='\033[45m'
echo_bg_cyan='\033[46m'
echo_bg_white='\033[47m'

echo_dim='\033[2;37m'

# =============================================================================
# Short names (for plugins)
# =============================================================================
clr="$echo_normal"
rst="$echo_normal"
txtred="$echo_red"
txtgrn="$echo_green"
txtylw="$echo_yellow"
txtblu="$echo_blue"
txtcyn="$echo_cyan"
bldred="$echo_bold_red"
bldgrn="$echo_bold_green"
bldylw="$echo_bold_yellow"
bldblu="$echo_bold_blue"
bldcyn="$echo_bold_cyan"
bldwht="$echo_bold_white"
dim="$echo_dim"
bakred="$echo_bg_red"
bakgrn="$echo_bg_green"
bakylw="$echo_bg_yellow"
bakblu="$echo_bg_blue"

# =============================================================================
# Semantic theme (change here for theming)
# =============================================================================
style_heading="$bldblu"
style_label="$bldcyn"
style_ok="$txtgrn"
style_err="$txtred"
style_warn="$txtylw"
style_muted="$dim"

# =============================================================================
# Style helpers (use theme above; loaded via utils.sh so plugins get these)
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
