#!/usr/bin/env bash
# Base plugin for CBASH
# Miscellaneous utilities

source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

misc_ips() {
    if command -v ifconfig &>/dev/null; then
        ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
    elif command -v ip &>/dev/null; then
        ip addr | grep -oP 'inet \K[\d.]+'
    else
        echo "ifconfig or ip command not found"
    fi
}

misc_myip() {
    local urls=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/")
    for url in "${urls[@]}"; do
        local res
        if res="$(curl -fs "$url" 2>/dev/null)"; then
            echo "$res" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'
            return 0
        fi
    done
    echo "Could not determine public IP"
}

misc_passgen() {
    local length="${1:-4}"
    local words=()
    
    if [[ -f /usr/share/dict/words ]]; then
        for ((i=0; i<length; i++)); do
            words+=("$(shuf -n1 /usr/share/dict/words)")
        done
        echo "Password: ${words[*]}"
    else
        # Fallback to random string
        openssl rand -base64 32 | head -c 24
        echo
    fi
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'misc' \
            'ips             Show local IP addresses' \
            'myip            Show public IP address' \
            'passgen [n]     Generate random password' \
            'Miscellaneous utilities'
        return 0
    fi

    case "$cmd" in
        ips)     misc_ips ;;
        myip)    misc_myip ;;
        passgen) shift; misc_passgen "$@" ;;
        *)       echo "Unknown command: $cmd"; return 1 ;;
    esac
}

_main "$@"