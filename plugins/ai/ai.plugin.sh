#!/usr/bin/env bash
# AI plugin for CBASH - Chat with AI models via Ollama

readonly DEFAULT_MODEL="deepseek-r1:14b"

# Commands
_ai_check() { command -v ollama &>/dev/null || { log_error "Ollama not found. Install from https://ollama.ai"; return 1; }; }

ai_chat() { _ai_check && ollama run "${1:-$DEFAULT_MODEL}"; }
ai_list() { _ai_check && ollama list; }
ai_pull() { _ai_check || return 1; [[ -n "$1" ]] || { log_error "Usage: ai pull <model>"; return 1; }; ollama pull "$1"; }

# Help and router
ai_help() {
    _describe command 'ai' \
        'chat [model]    Chat with AI (default: deepseek-r1:14b)' \
        'list            List available models' \
        'pull <model>    Pull a model' \
        'AI chat via Ollama'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") ai_help ;;
        chat|deepseek)     shift; ai_chat "$@" ;;
        list)              ai_list ;;
        pull)              shift; ai_pull "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

