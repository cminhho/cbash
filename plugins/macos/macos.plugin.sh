#!/usr/bin/env bash
# MacOS plugin for CBASH
# macOS system utilities and maintenance commands

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Aliases (shortcuts for common commands)
# -----------------------------------------------------------------------------

alias mlock='macos_lock'
alias minfo='macos_info'
alias mports='macos_ports'
alias mip='macos_ip_local'
alias mipublic='macos_ip_public'
alias mupdate='macos_update'
alias mspeedtest='macos_speedtest'
alias mmemory='macos_memory'
alias msize='macos_size'
alias mtree='macos_tree'
alias musers='macos_users'
alias mcleanempty='macos_clean_empty'

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

macos_info() {
    sw_vers
}

macos_lock() {
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
}

macos_speedtest() {
    log_info "Testing internet speed..."
    networkQuality -v
}

macos_memory() {
    top -o MEM
}

macos_ports() {
    echo "Listening ports:"
    sudo lsof -iTCP -sTCP:LISTEN -P
}

macos_ip_local() {
    local ip
    ip=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
    echo "${ip:-Not connected}"
}

macos_ip_public() {
    curl -s https://ipinfo.io/ip
}

macos_users() {
    dscl . -list /Users uid
}

macos_size() {
    du -sh .
}

macos_tree() {
    du -sh */ 2>/dev/null | sort -hr
}

macos_clean_empty() {
    local empty_dirs
    empty_dirs=$(find . -type d -empty 2>/dev/null)

    if [[ -z "$empty_dirs" ]]; then
        log_info "No empty directories found"
        return 0
    fi

    echo "Empty directories:"
    echo "$empty_dirs"
    read -rp "Delete? [y/N] " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        find . -type d -empty -delete
        log_success "Cleaned"
    fi
}

macos_find() {
    local text="$1"
    local ext="$2"

    [[ -z "$text" ]] && { read -rp "Search text: " text; }
    [[ -z "$ext" ]] && { read -rp "File extension: " ext; }

    find . -iname "*.$ext" -exec grep -lin --color "$text" {} \;
}

macos_replace() {
    local file="$1"
    local search="$2"
    local replace="$3"

    [[ -z "$file" ]] && { read -rp "File: " file; }
    [[ -z "$search" ]] && { read -rp "Search: " search; }
    [[ -z "$replace" ]] && { read -rp "Replace: " replace; }

    sed -i '' "s#${search}#${replace}#g" "$file"
    log_success "Replaced in $file"
}

macos_update() {
    log_info "Updating Homebrew..."
    brew update && brew upgrade && brew upgrade --cask && brew cleanup

    if command -v npm &>/dev/null; then
        log_info "Updating npm packages..."
        npm update -g
    fi

    if command -v pip3 &>/dev/null; then
        log_info "Updating pip packages..."
        pip3 list --outdated --format=freeze 2>/dev/null | cut -d= -f1 | xargs -n1 pip3 install -U 2>/dev/null
    fi

    log_success "Update complete"
}

# -----------------------------------------------------------------------------
# Misc (merged from base plugin: cross-platform ips/myip/passgen)
# -----------------------------------------------------------------------------

macos_ips() {
    if command -v ifconfig &>/dev/null; then
        ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
    elif command -v ip &>/dev/null; then
        ip addr | grep -oP 'inet \K[\d.]+'
    else
        log_error "ifconfig or ip command not found"
    fi
}

macos_myip() {
    local urls=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/" "https://ipinfo.io/ip")
    for url in "${urls[@]}"; do
        local res
        if res="$(curl -fs "$url" 2>/dev/null)"; then
            echo "$res" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1
            return 0
        fi
    done
    log_error "Could not determine public IP"
}

macos_passgen() {
    local length="${1:-4}"
    local words=()

    if [[ -f /usr/share/dict/words ]]; then
        for ((i=0; i<length; i++)); do
            words+=("$(shuf -n1 /usr/share/dict/words 2>/dev/null)")
        done
        echo "Password: ${words[*]}"
    else
        openssl rand -base64 32 | head -c 24
        echo
    fi
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

macos_help() {
    _describe command 'macos' \
        'info            Show macOS version' \
        'lock            Lock screen' \
        'speedtest       Test internet speed' \
        'memory          Show memory usage' \
        'ports           List listening ports' \
        'ip-local        Show local IP' \
        'ip-public       Show public IP' \
        'users           List system users' \
        'size            Show current folder size' \
        'tree            List folders by size' \
        'clean-empty     Remove empty directories' \
        'find <text> <ext>  Find text in files' \
        'replace <file> <s> <r>  Replace in file' \
        'update          Update brew/npm/pip' \
        'ips             Show all local IPs (ifconfig/ip)' \
        'myip            Show public IP (fallback sources)' \
        'passgen [n]     Generate random password (n words)' \
        'list            List aliases' \
        'macOS system utilities'
}

macos_list_aliases() {
    echo "MacOS aliases: mlock, minfo, mports, mip, mipublic, mupdate, mspeedtest, mmemory, msize, mtree, musers, mcleanempty"
}

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        macos_help
        return 0
    fi

    case "$cmd" in
        help|--help|-h) macos_help ;;
        list)          macos_list_aliases ;;
        info)          macos_info ;;
        lock)           macos_lock ;;
        speedtest)      macos_speedtest ;;
        memory)         macos_memory ;;
        ports)          macos_ports ;;
        ip-local)       macos_ip_local ;;
        ip-public)      macos_ip_public ;;
        users)          macos_users ;;
        size)           macos_size ;;
        tree)           macos_tree ;;
        clean-empty)    macos_clean_empty ;;
        find)           shift; macos_find "$@" ;;
        replace)        shift; macos_replace "$@" ;;
        update)         macos_update ;;
        ips)            macos_ips ;;
        myip)           macos_myip ;;
        passgen)        shift; macos_passgen "$@" ;;
        *)              log_error "Unknown command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
