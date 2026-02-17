#!/usr/bin/env bash
# CBASH logging — level-based log with optional color.
#
# Load: via common.sh. Plugins use source "$CBASH_DIR/lib/common.sh".
# Set CBASH_LOG_LEVEL to filter: 0=off, 1=fatal, 3=error, 4=warn, 6=info, 7=debug (default 6).
# shellcheck disable=SC2034

# =============================================================================
# Log levels (syslog-style)
# =============================================================================
: "${CBASH_LOG_LEVEL_FATAL:=1}"
: "${CBASH_LOG_LEVEL_ERROR:=3}"
: "${CBASH_LOG_LEVEL_WARNING:=4}"
: "${CBASH_LOG_LEVEL_INFO:=6}"
: "${CBASH_LOG_LEVEL_DEBUG:=7}"
: "${CBASH_LOG_LEVEL:=7}"

# =============================================================================
# Helpers
# =============================================================================
# Use colors by default; disable with NO_COLOR=1 or CLICOLOR=0.
_log_has_colors() {
    [[ -z "${NO_COLOR:-}" && "${CLICOLOR:-1}" != 0 ]]
}

# Internal: print a log line. level_label e.g. "ERROR", label_bg/text_color from colors.sh.
_log_message() {
    local level_label="$1"
    local label_bg="$2"   # e.g. bakred, bakylw (from colors.sh)
    local text_color="$3"
    local msg="$4"
    local stream="${5:-1}"  # 1=stdout, 2=stderr
    if _log_has_colors && [[ -n "$label_bg" && -n "$text_color" ]]; then
        local line
        line="${label_bg}${bldwht:-} ${level_label} ${clr:-} ${text_color}${msg}${clr:-}"
        if [[ "$stream" == 2 ]]; then
            printf '%b\n' "$line" >&2
        else
            printf '%b\n' "$line"
        fi
    else
        if [[ "$stream" == 2 ]]; then
            printf '%s: %s\n' "$level_label" "$msg" >&2
        else
            printf '%s: %s\n' "$level_label" "$msg"
        fi
    fi
}

# =============================================================================
# Leveled log functions (only output if CBASH_LOG_LEVEL >= level)
# =============================================================================
# Level styles: label background (bak*) + message color (style_*), from colors.sh
log_fatal() {
    [[ "${CBASH_LOG_LEVEL:-6}" -ge "${CBASH_LOG_LEVEL_FATAL:-1}" ]] || return 0
    _log_message "FATAL" "$bakred" "${style_err:-$txtred}" "$*" 2
}

log_error() {
    [[ "${CBASH_LOG_LEVEL:-6}" -ge "${CBASH_LOG_LEVEL_ERROR:-3}" ]] || return 0
    _log_message "ERROR" "$bakred" "${style_err:-$txtred}" "$*" 2
}

log_warning() {
    [[ "${CBASH_LOG_LEVEL:-6}" -ge "${CBASH_LOG_LEVEL_WARNING:-4}" ]] || return 0
    _log_message "WARN" "$bakylw" "${style_warn:-$txtylw}" "$*" 2
}

log_info() {
    [[ "${CBASH_LOG_LEVEL:-6}" -ge "${CBASH_LOG_LEVEL_INFO:-6}" ]] || return 0
    _log_message "INFO" "$bakblu" "${style_ok:-$txtgrn}" "$*" 1
}

log_success() {
    [[ "${CBASH_LOG_LEVEL:-6}" -ge "${CBASH_LOG_LEVEL_INFO:-6}" ]] || return 0
    _log_message "SUCCESS" "$bakgrn" "${style_ok:-$txtgrn}" "$*" 1
}

log_debug() {
    [[ "${CBASH_LOG_LEVEL:-6}" -ge "${CBASH_LOG_LEVEL_DEBUG:-7}" ]] || return 0
    _log_message "DEBUG" "" "${style_muted:-$dim}" "$*" 1
}
