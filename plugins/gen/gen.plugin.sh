#!/usr/bin/env bash
# Gen plugin for CBASH
# Structure generator (scaffold + doc from templates)

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

readonly GEN_TEMPLATE_DIR="$CBASH_DIR/plugins/gen/templates"
readonly -a GEN_DOC_TYPES=("troubleshooting" "cab" "note" "adr" "meeting" "design" "cab-review" "code-review")

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias gtrouble='gen_trouble'
alias gfeat='gen_feat'
alias gws='gen_workspace'
alias gproject='gen_project'
alias gdoc='gen_doc'

# -----------------------------------------------------------------------------
# Commands (scaffold)
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

    local base="$HOME/$name"
    local year
    year=$(date +%Y)

    mkdir -p "$base"/{documents/{company,personal,learning,career},archive/"$year",artifacts/{maven,docker,node,venv,iso-vms},downloads,tmp,repos/{personal,company,open-source,labs}}
    # .gitkeep so empty dirs can be committed if desired
    for d in documents documents/company documents/personal documents/learning documents/career archive archive/"$year" artifacts artifacts/maven artifacts/docker artifacts/node artifacts/venv artifacts/iso-vms downloads tmp repos repos/personal repos/company repos/open-source repos/labs; do
        touch "$base/$d/.gitkeep"
    done

    cat > "$base/README.md" <<'READMEEOF'
# WORKSPACE_NAME

Developer workspace. Organize by ownership to avoid license and Git account confusion.

## repos/ (Developer heart)

| Folder | Purpose |
|--------|---------|
| `company/` | Current employer projects (optionally subdivide by client-a, client-b) |
| `personal/` | Personal projects, own startup |
| `open-source/` | Forks from community repos for contributing |
| `labs/` | Learning code, tutorials, trying new frameworks |

## documents/ (Knowledge & admin)

| Folder | Purpose |
|--------|---------|
| `company/` | Contracts, payroll, insurance, internal processes |
| `personal/` | Personal ID, finance, health docs |
| `learning/` | E-books, cheat-sheets, certificates |
| `career/` | CV versions, portfolio, interview prep |

## artifacts/ (Storage — keep disk clean)

Point tools here instead of default system/home paths.

| Folder | Purpose |
|--------|---------|
| `maven/` | `.m2/repository` — avoid re-downloading Java deps |
| `docker/` | Container volumes, DB data |
| `node/` | npm cache or shared node_modules |
| `venv/` | Python virtual environments |
| `iso-vms/` | OS install images, VM disks (VMware/VirtualBox) |

## archive/ (Project archive)

When a project ends, zip it and move here. One folder per year: `2024/`, `2025/`, …

## tmp/ & downloads/

| Folder | Purpose |
|--------|---------|
| `tmp/` | Quick export files (.json, .sql) for inspection |
| `downloads/` | Browser downloads |

---

Add to `.gitignore`: `artifacts/`, `downloads/`, `tmp/` (and `repos/`, `documents/` if private).
READMEEOF
    sed -i.bak "s/WORKSPACE_NAME/$name/" "$base/README.md" 2>/dev/null || sed -i '' "s/WORKSPACE_NAME/$name/" "$base/README.md"
    rm -f "$base/README.md.bak"
    cat > "$base/.gitignore" <<'EOF'
# Workspace defaults — uncomment or extend as needed
# artifacts/
# downloads/
# tmp/
# repos/
EOF
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
# Doc from template (output: $WORKSPACE_TROUBLESHOOT/<year>/<date>/<name>/)
# -----------------------------------------------------------------------------

_gen_check_template() {
    [[ -f "$1" ]] || { echo "Error: Template not found: $1"; return 1; }
}

_gen_select_doc_type() {
    echo "Select document type:"
    echo "1) troubleshooting  2) cab  3) note  4) adr  5) meeting  6) design  7) cab-review  8) code-review"
    local selection
    while true; do
        read -rp "Selection (1-8): " selection
        case "$selection" in
            1) echo "troubleshooting"; return ;;
            2) echo "cab"; return ;;
            3) echo "note"; return ;;
            4) echo "adr"; return ;;
            5) echo "meeting"; return ;;
            6) echo "design"; return ;;
            7) echo "cab-review"; return ;;
            8) echo "code-review"; return ;;
            *) echo "Invalid. Try again." ;;
        esac
    done
}

gen_doc() {
    local doc_type="$1" name="$2"

    [[ -z "$doc_type" ]] && doc_type=$(_gen_select_doc_type)
    [[ " ${GEN_DOC_TYPES[*]} " =~ " ${doc_type} " ]] || {
        echo "Error: Invalid type. Use: ${GEN_DOC_TYPES[*]}"
        return 1
    }
    [[ -z "$name" ]] && {
        read -rp "Document name: " name
        [[ -z "$name" ]] && { echo "Name required"; return 1; }
    }

    local year date output_dir template output_file
    year=$(date +%Y)
    date=$(date +%Y-%m-%d)
    [[ -n "$WORKSPACE_TROUBLESHOOT" ]] || { echo "Error: Set WORKSPACE_TROUBLESHOOT"; return 1; }
    output_dir="$WORKSPACE_TROUBLESHOOT/$year/$date/$name"
    template="$GEN_TEMPLATE_DIR/${doc_type}.md"
    output_file="$output_dir/${doc_type}.md"

    _gen_check_template "$template" || return 1
    mkdir -p "$output_dir" || { echo "Error: Failed to create directory"; return 1; }
    sed "s/{{DATE}}/$date/g" "$template" > "$output_file" || { echo "Error: Failed to generate document"; return 1; }
    success "Generated $doc_type at: $output_file"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

gen_help() {
    _describe command 'gen' \
        'trouble [name]   Create troubleshooting dir (cwd)' \
        'feat [name]      Create feature dir' \
        'workspace [name] Create ~/<name> (documents, archive, artifacts, downloads, tmp, repos)' \
        'project [name]   Create project structure' \
        'doc [type] [name]  Generate doc from template (→ \$WORKSPACE_TROUBLESHOOT/<year>/<date>/<name>)' \
        'aliases          List gen aliases' \
        'Structure and doc generator'
}

gen_list_aliases() {
    echo "Gen aliases: gtrouble, gfeat, gws, gproject, gdoc"
    echo "  gtrouble [name] = gen trouble"
    echo "  gfeat [name]    = gen feat"
    echo "  gws [name]      = gen workspace"
    echo "  gproject [name] = gen project"
    echo "  gdoc [type] [name] = gen doc"
}

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        gen_help
        return 0
    fi

    case "$cmd" in
        help|--help|-h) gen_help ;;
        aliases)        gen_list_aliases ;;
        trouble)        shift; gen_trouble "$@" ;;
        feat)           shift; gen_feat "$@" ;;
        workspace)      shift; gen_workspace "$@" ;;
        project)        shift; gen_project "$@" ;;
        doc)            shift; gen_doc "$@" ;;
        *)              echo "Unknown command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"