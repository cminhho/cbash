#!/usr/bin/env bash
# Setup plugin for CBASH
# Development environment setup (see New-Mac-Setup.md)

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

readonly SETUP_DIR="$CBASH_DIR/plugins/setup"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias scheck='setup_check'
alias sbrew='setup_brew'
alias sws='setup_workspace'

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

setup_check() {
    echo "Development Environment"
    echo "======================="
    echo "Git:     $(git --version 2>/dev/null || echo 'Not installed')"
    echo "Node:    $(node -v 2>/dev/null || echo 'Not installed')"
    echo "Python:  $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "Docker:  $(docker --version 2>/dev/null || echo 'Not installed')"
    echo "Java:    $(java -version 2>&1 | head -n 1 || echo 'Not installed')"
    echo ""
    echo "Git Config"
    echo "=========="
    echo "Name:    $(git config --global user.name 2>/dev/null || echo '<not set>')"
    echo "Email:   $(git config --global user.email 2>/dev/null || echo '<not set>')"
}

# Cask packages (GUI) — use "brew install --cask"; others use "brew install"
readonly SETUP_BREW_CASKS="visual-studio-code intellij-idea-ce pycharm-ce postman mockoon dbeaver-community nosql-workbench google-chrome slack microsoft-teams zoom notion devtoys docker"

setup_brew() {
    local group="${1:-dev}"

    # Ensure brew in PATH (e.g. after first install)
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
        [[ -x /usr/local/bin/brew ]] && eval "$(/usr/local/bin/brew shellenv)"
    fi
    command -v brew &>/dev/null || { echo "Homebrew not found. See https://brew.sh" >&2; return 1; }

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
        *)     echo "Groups: dev, cloud, ide, apps, all"; return 1 ;;
    esac

    echo "Installing $group tools..."
    for tool in "${tools[@]}"; do
        if brew list "$tool" &>/dev/null || brew list --cask "$tool" &>/dev/null; then
            echo "  $tool: ok"
        else
            echo "  Installing $tool..."
            if [[ " $SETUP_BREW_CASKS " == *" $tool "* ]]; then
                brew install --cask "$tool"
            else
                brew install "$tool"
            fi
        fi
    done
    success "Done"
}

setup_workspace() {
    local name="${1:-workspace}"
    [[ -f "$CBASH_DIR/plugins/gen/gen.plugin.sh" ]] || { echo "Gen plugin not found"; return 1; }
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
    echo "Setup aliases: scheck, sbrew, sws"
    echo "  scheck  = setup check"
    echo "  sbrew   = setup brew [group]"
    echo "  sws     = setup workspace [name]"
}

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        setup_help
        return 0
    fi

    case "$cmd" in
        help|--help|-h) setup_help ;;
        aliases)        setup_list_aliases ;;
        check)          setup_check ;;
        brew)           shift; setup_brew "$@" ;;
        workspace)      shift; setup_workspace "$@" ;;
        *)              echo "Unknown command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
