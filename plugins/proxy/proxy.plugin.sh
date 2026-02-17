#!/usr/bin/env bash
# Proxy plugin for CBASH - Proxy settings management

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

proxy_enable() {
    local proxy="${1:-${HTTP_PROXY_URL:-}}"
    local no_proxy="${NO_PROXY_LIST:-127.0.0.1,localhost}"

    if [[ -z "$proxy" ]]; then
        read -rp "Proxy URL (e.g. http://proxy:8080): " proxy
    fi
    [[ -z "$proxy" ]] && { log_error "Proxy URL required"; return 1; }

    export http_proxy="$proxy"
    export https_proxy="$proxy"
    export HTTP_PROXY="$proxy"
    export HTTPS_PROXY="$proxy"
    export ALL_PROXY="$proxy"
    export no_proxy="$no_proxy"
    export NO_PROXY="$no_proxy"

    # npm
    if command -v npm &>/dev/null; then
        npm config set proxy "$proxy" 2>/dev/null
        npm config set https-proxy "$proxy" 2>/dev/null
    fi

    # git
    if command -v git &>/dev/null; then
        git config --global http.proxy "$proxy"
        git config --global https.proxy "$proxy"
    fi

    log_success "Proxy enabled: $proxy"
}

proxy_disable() {
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY no_proxy NO_PROXY

    # npm
    if command -v npm &>/dev/null; then
        npm config delete proxy 2>/dev/null
        npm config delete https-proxy 2>/dev/null
    fi

    # git
    if command -v git &>/dev/null; then
        git config --global --unset http.proxy 2>/dev/null
        git config --global --unset https.proxy 2>/dev/null
    fi

    log_success "Proxy disabled"
}

proxy_show() {
    echo "Environment:"
    echo "  http_proxy:  ${http_proxy:-<not set>}"
    echo "  https_proxy: ${https_proxy:-<not set>}"
    echo "  no_proxy:    ${no_proxy:-<not set>}"

    if command -v npm &>/dev/null; then
        echo ""
        echo "npm:"
        echo "  proxy:       $(npm config get proxy 2>/dev/null || echo '<not set>')"
        echo "  https-proxy: $(npm config get https-proxy 2>/dev/null || echo '<not set>')"
    fi

    if command -v git &>/dev/null; then
        echo ""
        echo "git (global):"
        echo "  http.proxy:  $(git config --global --get http.proxy 2>/dev/null || echo '<not set>')"
        echo "  https.proxy: $(git config --global --get https.proxy 2>/dev/null || echo '<not set>')"
    fi
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

proxy_help() {
    _describe command 'proxy' \
        'enable [url]   Enable proxy (env, npm, git)' \
        'disable        Disable proxy' \
        'show           Show proxy settings' \
        'aliases        List proxy aliases' \
        'Proxy settings manager'
}

proxy_list_aliases() {
    echo "Proxy aliases: proxon, proxoff, proxshow"
    echo "  proxon [url]  = proxy enable"
    echo "  proxoff       = proxy disable"
    echo "  proxshow      = proxy show"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") proxy_help ;;
        aliases)           proxy_list_aliases ;;
        enable)            shift; proxy_enable "$@" ;;
        disable)           proxy_disable ;;
        show)              proxy_show ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

