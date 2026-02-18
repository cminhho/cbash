#!/usr/bin/env bash
# CBASH logging - level-based with color support
# Set CBASH_LOG_LEVEL: 0=off, 1=fatal, 3=error, 4=warn, 6=info, 7=debug (default 7)
# shellcheck disable=SC2034,SC2154
# (SC2154: color vars from colors.sh, set when lib is used via common.sh)

# Log levels
: "${CBASH_LOG_LEVEL:=7}"

# Check if colors enabled
_log_colors() { [[ -z "${NO_COLOR:-}" && "${CLICOLOR:-1}" != 0 ]]; }

# Print log message: _log label bg_color text_color message stream(1|2)
_log() {
    local label="$1" bg="$2" fg="$3" msg="$4" out="${5:-1}"
    if _log_colors && [[ -n "$bg" ]]; then
        printf '%b\n' "${bg}${bldwht} ${label} ${clr} ${fg}${msg}${clr}" >&"$out"
    else
        printf '%s: %s\n' "$label" "$msg" >&"$out"
    fi
}

# Log functions
log_fatal()   { [[ $CBASH_LOG_LEVEL -ge 1 ]] && _log "FATAL"   "$bakred" "$txtred" "$*" 2; }
log_error()   { [[ $CBASH_LOG_LEVEL -ge 3 ]] && _log "ERROR"   "$bakred" "$txtred" "$*" 2; }
log_warning() { [[ $CBASH_LOG_LEVEL -ge 4 ]] && _log "WARN"    "$bakylw" "$txtylw" "$*" 2; }
log_info()    { [[ $CBASH_LOG_LEVEL -ge 6 ]] && _log "INFO"    "$bakblu" "$txtgrn" "$*" 1; }
log_success() { [[ $CBASH_LOG_LEVEL -ge 6 ]] && _log "SUCCESS" "$bakgrn" "$txtgrn" "$*" 1; }
log_debug()   { [[ $CBASH_LOG_LEVEL -ge 7 ]] && _log "DEBUG"   ""        "$dim"    "$*" 1; }
