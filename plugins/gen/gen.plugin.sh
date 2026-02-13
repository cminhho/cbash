#!/usr/bin/env bash
# Gen plugin for CBASH
# Directory structure generator

source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

gen_trouble() {
    local name="${1:-$(date '+%Y-%m-%d')}"
    local dir="$name"

    mkdir -p "$dir"
    cat > "$dir/README.md" <<'EOF'
# Troubleshooting

## Issue

## Investigation

## Root Cause

## Resolution

## Prevention
EOF
    touch "$dir/troubleshooting.log"
    success "Created: $dir"
}

gen_feat() {
    local name="$1"
    [[ -z "$name" ]] && { read -rp "Feature name: " name; }
    [[ -z "$name" ]] && { echo "Name required"; return 1; }

    mkdir -p "$name"/{docs,src,tests}
    cat > "$name/README.md" <<EOF
# $name

## Overview

## Requirements

## Implementation
EOF
    success "Created: $name"
    ls -la "$name"
}

gen_workspace() {
    local name="$1"
    [[ -z "$name" ]] && { read -rp "Workspace name: " name; }
    [[ -z "$name" ]] && { echo "Name required"; return 1; }

    local base="$HOME/workspace/$name"
    mkdir -p "$base"/{projects,docs,tools,scripts}
    success "Created: $base"
    ls -la "$base"
}

gen_project() {
    local name="$1"
    [[ -z "$name" ]] && { read -rp "Project name: " name; }
    [[ -z "$name" ]] && { echo "Name required"; return 1; }

    mkdir -p "$name"/{src,tests,docs,scripts}
    cat > "$name/README.md" <<EOF
# $name

## Getting Started

## Development

## Testing
EOF
    success "Created: $name"
    ls -la "$name"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'gen' \
            'trouble [name]   Create troubleshooting dir' \
            'feat [name]      Create feature dir' \
            'workspace [name] Create workspace structure' \
            'project [name]   Create project structure' \
            'Directory structure generator'
        return 0
    fi

    case "$cmd" in
        trouble)   shift; gen_trouble "$@" ;;
        feat)      shift; gen_feat "$@" ;;
        workspace) shift; gen_workspace "$@" ;;
        project)   shift; gen_project "$@" ;;
        *)         echo "Unknown command: $cmd"; return 1 ;;
    esac
}

_main "$@"