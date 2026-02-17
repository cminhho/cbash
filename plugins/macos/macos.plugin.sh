#!/usr/bin/env bash
# MacOS plugin for CBASH - macOS system utilities

# Commands 
macos_info()      { sw_vers; }
macos_lock()      { /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend; }
macos_speedtest() { log_info "Testing speed..."; networkQuality -v; }
macos_memory()    { top -o MEM; }
macos_ports()     { echo "Listening ports:"; sudo lsof -iTCP -sTCP:LISTEN -P; }
macos_ip_local()  { ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "Not connected"; }
macos_ip_public() { curl -s https://ipinfo.io/ip; }
macos_users()     { dscl . -list /Users uid; }
macos_size()      { du -sh .; }
macos_tree()      { du -sh */ 2>/dev/null | sort -hr; }

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

# Commands (misc)
macos_ips() { ifconfig 2>/dev/null | awk '/inet /{ print $2 }' || ip addr | grep -oP 'inet \K[\d.]+'; }

macos_myip() {
    for url in "https://ipinfo.io/ip" "http://myip.dnsomatic.com/"; do
        curl -fs "$url" 2>/dev/null && return 0
    done
    log_error "Could not determine public IP"
}

macos_passgen() {
    local n="${1:-4}"
    [[ -f /usr/share/dict/words ]] && { shuf -n "$n" /usr/share/dict/words | tr '\n' ' '; echo; return; }
    openssl rand -base64 32 | head -c 24; echo
}

# Help and router
macos_help() {
    _describe command 'macos' \
        'info            macOS version' \
        'lock            Lock screen' \
        'speedtest       Internet speed' \
        'memory          Memory usage' \
        'ports           Listening ports' \
        'ip-local        Local IP' \
        'ip-public       Public IP' \
        'users           System users' \
        'size            Folder size' \
        'tree            Folders by size' \
        'clean-empty     Remove empty dirs' \
        'find <t> <ext>  Find text in files' \
        'replace <f> <s> <r>  Replace in file' \
        'update          Update brew/npm/pip' \
        'passgen [n]     Random password' \
        'macOS utilities'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") macos_help ;;
        info)        macos_info ;;
        lock)        macos_lock ;;
        speedtest)   macos_speedtest ;;
        memory)      macos_memory ;;
        ports)       macos_ports ;;
        ip-local)    macos_ip_local ;;
        ip-public)   macos_ip_public ;;
        users)       macos_users ;;
        size)        macos_size ;;
        tree)        macos_tree ;;
        clean-empty) macos_clean_empty ;;
        find)        shift; macos_find "$@" ;;
        replace)     shift; macos_replace "$@" ;;
        update)      macos_update ;;
        ips)         macos_ips ;;
        myip)        macos_myip ;;
        passgen)     shift; macos_passgen "$@" ;;
        *)           log_error "Unknown: $1"; return 1 ;;
    esac
}

