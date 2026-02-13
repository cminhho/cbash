#!/usr/bin/env bash
# CBASH utilities — helpers. Colors from lib/colors.sh; logging from lib/log.sh.
# shellcheck disable=SC2034

[[ -n "$CBASH_DIR" ]] && [[ -f "$CBASH_DIR/lib/colors.sh" ]] && source "$CBASH_DIR/lib/colors.sh"
# Fallback when colors.sh not loaded (e.g. CBASH_DIR unset)
clr="${clr:-}"
txtred="${txtred:-}"
txtgrn="${txtgrn:-}"
txtylw="${txtylw:-}"
txtblu="${txtblu:-}"

# =============================================================================
# Functions
# =============================================================================
_command_exists() { command -v "$1" &>/dev/null; }
mkcd() { mkdir -p "$1" && cd "$1"; }
takegit() { git clone "$1" && cd "$(basename "${1%%.git}")"; }
