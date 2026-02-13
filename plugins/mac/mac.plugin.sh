#!/usr/bin/env bash
# Mac plugin for CBASH
# macOS system utilities and maintenance commands

source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

mac_info() {
    sw_vers
}

mac_lock() {
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
}

mac_speedtest() {
    echo "Testing internet speed..."
    networkQuality -v
}

mac_memory() {
    top -o MEM
}

mac_ports() {
    echo "Listening ports:"
    sudo lsof -iTCP -sTCP:LISTEN -P
}

mac_ip_local() {
    local ip
    ip=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
    echo "${ip:-Not connected}"
}

mac_ip_public() {
    curl -s https://ipinfo.io/ip
}

mac_users() {
    dscl . -list /Users uid
}

mac_size() {
    du -sh .
}

mac_tree() {
    du -sh */ 2>/dev/null | sort -hr
}

mac_clean_empty() {
    local empty_dirs
    empty_dirs=$(find . -type d -empty 2>/dev/null)

    if [[ -z "$empty_dirs" ]]; then
        echo "No empty directories found"
        return 0
    fi

    echo "Empty directories:"
    echo "$empty_dirs"
    read -rp "Delete? [y/N] " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        find . -type d -empty -delete
        success "Cleaned"
    fi
}

mac_find() {
    local text="$1"
    local ext="$2"

    [[ -z "$text" ]] && { read -rp "Search text: " text; }
    [[ -z "$ext" ]] && { read -rp "File extension: " ext; }

    find . -iname "*.$ext" -exec grep -lin --color "$text" {} \;
}

mac_replace() {
    local file="$1"
    local search="$2"
    local replace="$3"

    [[ -z "$file" ]] && { read -rp "File: " file; }
    [[ -z "$search" ]] && { read -rp "Search: " search; }
    [[ -z "$replace" ]] && { read -rp "Replace: " replace; }

    sed -i '' "s#${search}#${replace}#g" "$file"
    success "Replaced in $file"
}

mac_update() {
    echo "Updating Homebrew..."
    brew update && brew upgrade && brew upgrade --cask && brew cleanup

    if command -v npm &>/dev/null; then
        echo "Updating npm packages..."
        npm update -g
    fi

    if command -v pip3 &>/dev/null; then
        echo "Updating pip packages..."
        pip3 list --outdated --format=freeze 2>/dev/null | cut -d= -f1 | xargs -n1 pip3 install -U 2>/dev/null
    fi

    success "Update complete"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'mac' \
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
            'macOS system utilities'
        return 0
    fi

    case "$cmd" in
        info)        mac_info ;;
        lock)        mac_lock ;;
        speedtest)   mac_speedtest ;;
        memory)      mac_memory ;;
        ports)       mac_ports ;;
        ip-local)    mac_ip_local ;;
        ip-public)   mac_ip_public ;;
        users)       mac_users ;;
        size)        mac_size ;;
        tree)        mac_tree ;;
        clean-empty) mac_clean_empty ;;
        find)        shift; mac_find "$@" ;;
        replace)     shift; mac_replace "$@" ;;
        update)      mac_update ;;
        *)           echo "Unknown command: $cmd"; return 1 ;;
    esac
}

_main "$@"