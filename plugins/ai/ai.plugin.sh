#!/usr/bin/env bash
# AI plugin for CBASH
# Chat with AI models via Ollama

source "$CBASH_DIR/lib/common.sh"

readonly DEFAULT_MODEL="deepseek-r1:14b"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

ai_check() {
    command -v ollama &>/dev/null || {
        err "Ollama not found. Install from https://ollama.ai"
        return 1
    }
}

ai_chat() {
    ai_check || return 1
    local model="${1:-$DEFAULT_MODEL}"
    info "Starting chat with $model..."
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
    [[ -z "$model" ]] && { echo "Usage: ai pull <model>"; return 1; }
    ollama pull "$model"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'ai' \
            'chat [model]    Chat with AI (default: deepseek-r1)' \
            'list            List available models' \
            'pull <model>    Pull a model' \
            'AI chat via Ollama'
        return 0
    fi

    case "$cmd" in
        chat|deepseek) shift; ai_chat "$@" ;;
        list)          ai_list ;;
        pull)          shift; ai_pull "$@" ;;
        *)             echo "Unknown command: $cmd"; return 1 ;;
    esac
}

_main "$@"