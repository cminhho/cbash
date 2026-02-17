#!/usr/bin/env bash
# AI plugin for CBASH
# Chat with AI models via Ollama

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

readonly DEFAULT_MODEL="deepseek-r1:14b"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias aichat='ai_chat'
alias ailist='ai_list'
alias aipull='ai_pull'
alias chat='ai_chat'

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

ai_check() {
    command -v ollama &>/dev/null || {
        log_error "Ollama not found. Install from https://ollama.ai"
        return 1
    }
}

ai_chat() {
    ai_check || return 1
    local model="${1:-$DEFAULT_MODEL}"
    log_info "Starting chat with $model..."
    ollama run "$model"
}

ai_list() {
    ai_check || return 1
    echo "Available models:"
    ollama list
}

ai_pull() {
    ai_check || return 1
    local model="$1"
    [[ -z "$model" ]] && { log_error "Usage: ai pull <model>"; return 1; }
    ollama pull "$model"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

ai_help() {
    _describe command 'ai' \
        'chat [model]    Chat with AI (default: deepseek-r1:14b)' \
        'list            List available models' \
        'pull <model>    Pull a model' \
        'aliases         List AI aliases' \
        'AI chat via Ollama'
}

ai_list_aliases() {
    echo "AI aliases: aichat, ailist, aipull, chat"
    echo "  aichat [model] = ai chat"
    echo "  ailist        = ai list"
    echo "  aipull <model>= ai pull"
    echo "  chat [model]  = ai chat"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") ai_help ;;
        aliases)           ai_list_aliases ;;
        chat|deepseek)     shift; ai_chat "$@" ;;
        list)              ai_list ;;
        pull)              shift; ai_pull "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"