#!/usr/bin/env bash
# Setup plugin for CBASH - Development environment setup

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

_show_line() {
    local label="$1" value="$2" missing="${3:-Not installed}" use_err="${4:-}"
    printf "  ${style_label}%-7s${clr} " "$label:"
    if [[ -n "$value" ]]; then
        printf "${style_ok}%s${clr}\n" "$value"
    else
        [[ -n "$use_err" ]] && printf "${style_err}%s${clr}\n" "$missing" || printf "${style_muted}%s${clr}\n" "$missing"
    fi
}

setup_check() {
    local v
    _gap; _box "Development Environment"; _br
    v=$(git --version 2>/dev/null)
    _show_line "Git" "$v" "Not installed" "err"
    v=$(node -v 2>/dev/null)
    _show_line "Node" "$v" "Not installed" "err"
    v=$(python3 --version 2>/dev/null)
    _show_line "Python" "$v" "Not installed" "err"
    v=$(docker --version 2>/dev/null)
    _show_line "Docker" "$v" "Not installed" "err"
    v=$(java -version 2>&1 | head -n 1)
    _show_line "Java" "$v" "Not installed" "err"
    _br; _box "Git Config"; _br
    v=$(git config --global user.name 2>/dev/null)
    _show_line "Name" "$v" "<not set>"
    v=$(git config --global user.email 2>/dev/null)
    _show_line "Email" "$v" "<not set>"
    _br
}

# Cask packages (GUI) — use "brew install --cask"; others use "brew install"
readonly SETUP_BREW_CASKS="visual-studio-code intellij-idea-ce pycharm-ce postman mockoon dbeaver-community nosql-workbench google-chrome slack microsoft-teams zoom notion devtoys docker"

setup_brew() {
    local group="${1:-dev}"

    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
        [[ -x /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
    fi
    command -v brew &>/dev/null || { log_error "Homebrew not found. See https://brew.sh"; return 1; }

    local -a dev_tools=(zsh zsh-completions bash-completion openssl git tree wget curl jq nvm pnpm python pyenv pycharm-ce maven intellij-idea-ce dbeaver-community nosql-workbench)
    local -a cloud_tools=(awscli terraform docker docker-completion docker-compose-completion)
    local -a ide_tools=(visual-studio-code intellij-idea-ce pycharm-ce postman mockoon)
    local -a apps_tools=(google-chrome slack microsoft-teams zoom notion devtoys mas)

    local -a tools
    case "$group" in
        dev)   tools=("${dev_tools[@]}") ;;
        cloud) tools=("${cloud_tools[@]}") ;;
        ide)   tools=("${ide_tools[@]}") ;;
        apps)  tools=("${apps_tools[@]}") ;;
        all)   tools=("${dev_tools[@]}" "${cloud_tools[@]}" "${ide_tools[@]}" "${apps_tools[@]}") ;;
        *)     log_error "Groups: dev, cloud, ide, apps, all"; return 1 ;;
    esac

    _gap; _box "Installing $group tools"; _br
    for tool in "${tools[@]}"; do
        if brew list "$tool" &>/dev/null || brew list --cask "$tool" &>/dev/null; then
            _label "  $tool"; printf " ${style_ok}✓ ok${clr}\n"
        else
            _label "  $tool"
            [[ " $SETUP_BREW_CASKS " == *" $tool "* ]] && { _muted " \$ brew install --cask $tool"; _br; brew install --cask "$tool"; } || { _muted " \$ brew install $tool"; _br; brew install "$tool"; }
        fi
    done
    _br; log_success "Done"
}

setup_workspace() {
    local name="${1:-workspace}"
    [[ -f "$CBASH_DIR/plugins/gen/gen.plugin.sh" ]] || { log_error "Gen plugin not found"; return 1; }
    "$CBASH_DIR/plugins/gen/gen.plugin.sh" workspace "$name"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

setup_help() {
    _describe command 'setup' \
        'check           Check dev environment' \
        'brew [group]    Install tools (dev|cloud|ide|apps|all)' \
        'workspace [name] Create ~/<name> via gen (default: workspace)' \
        'aliases         List setup aliases' \
        'New Mac Setup - development environment'
}

setup_list_aliases() {
    _gap; _box "Setup aliases"; _br
    _label "  scheck";  _muted_nl " = setup check"
    _label "  sbrew";   _muted_nl " = setup brew [group]"
    _label "  sws";     _muted_nl " = setup workspace [name]"
    _br
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") setup_help ;;
        aliases)           setup_list_aliases ;;
        check)             setup_check ;;
        brew)              shift; setup_brew "$@" ;;
        workspace)         shift; setup_workspace "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

