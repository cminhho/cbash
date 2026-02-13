#!/usr/bin/env bash
# Setup plugin for CBASH
# Development environment setup and configuration (Mac Setup Guide)

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

readonly SETUP_DIR="$CBASH_DIR/plugins/setup"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias scheck='setup_check'
alias sbrew='setup_brew'
alias sws='setup_workspace'
alias sdot='setup_dotfiles'

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

setup_brew() {
    local group="${1:-dev}"

    # Tool groups
    local -a dev_tools=(
        # Shell & Common
        "zsh" "zsh-completions" "bash-completion" "openssl"
        # General
        "git" "tree" "wget" "curl" "jq"
        # Node.js
        "nvm" "pnpm"
        # Python
        "python" "pyenv" "pycharm-ce"
        # Java
        "maven" "intellij-idea-ce"
        # Database
        "dbeaver-community" "nosql-workbench"
    )
    local -a cloud_tools=(
        # AWS & Cloud
        "awscli" "terraform"
        # Docker
        "docker" "docker-completion" "docker-compose-completion"
    )
    local -a ide_tools=(
        # IDEs
        "visual-studio-code" "intellij-idea-ce" "pycharm-ce"
        # Dev Apps
        "postman" "mockoon"
    )
    local -a apps_tools=(
        # Browser
        "google-chrome"
        # Communication
        "slack" "microsoft-teams" "zoom" "notion"
        # Productivity
        "devtoys" "mas"
    )

    # Check/install Homebrew
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

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
        if brew list "$tool" &>/dev/null; then
            echo "  $tool: installed"
        else
            echo "  Installing $tool..."
            # Cask apps (GUI applications)
            local cask_apps="visual-studio-code intellij-idea intellij-idea-ce pycharm-ce postman mockoon dbeaver-community nosql-workbench google-chrome slack microsoft-teams zoom notion devtoys docker"
            if [[ " $cask_apps " == *" $tool "* ]]; then
                brew install --cask "$tool" 2>/dev/null
            else
                brew install "$tool" 2>/dev/null
            fi
        fi
    done
    success "Done"
}

setup_workspace() {
    local base="${1:-$HOME/workspace}"
    local dirs=("projects" "tools" "docs" "scripts" "sandbox")

    echo "Creating workspace at $base..."
    for dir in "${dirs[@]}"; do
        mkdir -p "$base/$dir"
        echo "  Created: $base/$dir"
    done
    success "Workspace ready"
}

setup_dotfiles() {
    local dotfiles_dir="$CBASH_DIR/dotfiles"
    [[ ! -d "$dotfiles_dir" ]] && { echo "No dotfiles directory"; return 1; }

    echo "Importing dotfiles from $dotfiles_dir..."
    for file in "$dotfiles_dir"/.*; do
        [[ -f "$file" ]] || continue
        local name=$(basename "$file")
        [[ "$name" == "." || "$name" == ".." ]] && continue
        cp "$file" "$HOME/$name"
        echo "  Copied: $name"
    done
    success "Dotfiles imported"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

setup_help() {
    _describe command 'setup' \
        'check           Check dev environment' \
        'brew [group]    Install tools (dev|cloud|ide|apps|all)' \
        'workspace [dir] Create workspace structure' \
        'dotfiles        Import dotfiles' \
        'aliases         List setup aliases' \
        'Mac Setup Guide - development environment'
}

setup_list_aliases() {
    echo "Setup aliases: scheck, sbrew, sws, sdot"
    echo "  scheck  = setup check"
    echo "  sbrew   = setup brew [group]"
    echo "  sws     = setup workspace [dir]"
    echo "  sdot    = setup dotfiles"
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
        dotfiles)       setup_dotfiles ;;
        *)              echo "Unknown command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
