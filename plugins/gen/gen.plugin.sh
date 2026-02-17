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
    local path_abs date template
    template="$GEN_TEMPLATE_DIR/troubleshooting.md"

    _gen_check_template "$template" || return 1
    mkdir -p "$dir" || { _gap; log_error "Could not create troubleshooting folder: $dir"; return 1; }
    path_abs=$(cd "$dir" && pwd)
    date=$(date +%Y-%m-%d)
    sed "s/{{DATE}}/$date/g" "$template" > "$dir/README.md" || { _gap; log_error "Could not write troubleshooting README"; return 1; }
    touch "$dir/troubleshooting.log"
    _gap; log_success "Created troubleshooting folder: $dir"
    log_debug "Location: $path_abs"
}

gen_feat() {
    local name="$1"
    local path_abs tpl
    [[ -z "$name" ]] && { read -rp "$(_label "Feature name: ")" name; }
    [[ -z "$name" ]] && { _gap; log_error "Feature name required"; return 1; }

    tpl="$GEN_TEMPLATE_DIR/feat-README.md"
    _gen_check_template "$tpl" || return 1
    mkdir -p "$name"/{docs,src,tests} || { _gap; log_error "Could not create feature directory: $name"; return 1; }
    path_abs=$(cd "$name" && pwd)
    sed "s/{{NAME}}/$name/g" "$tpl" > "$name/README.md" || { _gap; log_error "Could not write feature README"; return 1; }
    _gap; log_success "Created feature scaffold: $name"
    log_debug "Location: $path_abs"
    ls -la "$name" | while read -r line; do _muted "$line"; _br; done
}

gen_workspace() {
    local name="$1"
    local base path_abs year tpl_readme tpl_gitignore
    [[ -z "$name" ]] && { read -rp "$(_label "Workspace name: ")" name; }
    [[ -z "$name" ]] && { _gap; log_error "Workspace name required"; return 1; }

    tpl_readme="$GEN_TEMPLATE_DIR/workspace-README.md"
    tpl_gitignore="$GEN_TEMPLATE_DIR/workspace.gitignore"
    _gen_check_template "$tpl_readme" || return 1
    _gen_check_template "$tpl_gitignore" || return 1

    base="$HOME/$name"
    year=$(date +%Y)

    mkdir -p "$base"/{documents/{company,personal,learning,career},archive/"$year",artifacts/{maven,docker,node,venv,iso-vms},downloads,tmp,repos/{personal,company,open-source,labs}} || { _gap; log_error "Could not create workspace directories: $base"; return 1; }
    for d in documents documents/company documents/personal documents/learning documents/career archive archive/"$year" artifacts artifacts/maven artifacts/docker artifacts/node artifacts/venv artifacts/iso-vms downloads tmp repos repos/personal repos/company repos/open-source repos/labs; do
        touch "$base/$d/.gitkeep"
    done

    sed "s/{{WORKSPACE_NAME}}/$name/g" "$tpl_readme" > "$base/README.md" || { _gap; log_error "Could not write workspace README"; return 1; }
    cp "$tpl_gitignore" "$base/.gitignore" || { _gap; log_error "Could not write workspace .gitignore"; return 1; }
    path_abs=$(cd "$base" && pwd)
    _gap; log_success "Created workspace: $name"
    log_debug "Location: $path_abs"
    ls -la "$base" | while read -r line; do _muted "$line"; _br; done
}

gen_project() {
    local name="$1"
    local path_abs tpl
    [[ -z "$name" ]] && { read -rp "$(_label "Project name: ")" name; }
    [[ -z "$name" ]] && { _gap; log_error "Project name required"; return 1; }

    tpl="$GEN_TEMPLATE_DIR/project-README.md"
    _gen_check_template "$tpl" || return 1
    mkdir -p "$name"/{src,tests,docs,scripts} || { _gap; log_error "Could not create project directory: $name"; return 1; }
    path_abs=$(cd "$name" && pwd)
    sed "s/{{NAME}}/$name/g" "$tpl" > "$name/README.md" || { _gap; log_error "Could not write project README"; return 1; }
    _gap; log_success "Created project: $name"
    log_debug "Location: $path_abs"
    ls -la "$name" | while read -r line; do _muted "$line"; _br; done
}

# -----------------------------------------------------------------------------
# Doc from template (output: $WORKSPACE_TROUBLESHOOT/<year>/<date>/<name>/)
# -----------------------------------------------------------------------------

_gen_check_template() {
    [[ -f "$1" ]] || { _gap; log_error "Template not found: $1"; return 1; }
}

_gen_select_doc_type() {
    _gap
    _box "Select document type"
    _br
    _muted_nl "  1) troubleshooting  2) cab  3) note  4) adr"
    _muted_nl "  5) meeting  6) design  7) cab-review  8) code-review"
    _br
    local selection
    while true; do
        read -rp "$(_label "Selection (1-8): ")" selection
        case "$selection" in
            1) echo "troubleshooting"; return ;;
            2) echo "cab"; return ;;
            3) echo "note"; return ;;
            4) echo "adr"; return ;;
            5) echo "meeting"; return ;;
            6) echo "design"; return ;;
            7) echo "cab-review"; return ;;
            8) echo "code-review"; return ;;
            *) log_error "Invalid. Try again." ;;
        esac
    done
}

gen_doc() {
    local doc_type="$1" name="$2"

    [[ -z "$doc_type" ]] && doc_type=$(_gen_select_doc_type)
    [[ " ${GEN_DOC_TYPES[*]} " =~ " ${doc_type} " ]] || {
        _gap; log_error "Invalid document type. Allowed: ${GEN_DOC_TYPES[*]}"
        return 1
    }
    [[ -z "$name" ]] && {
        read -rp "$(_label "Document name: ")" name
        [[ -z "$name" ]] && { _gap; log_error "Document name required"; return 1; }
    }

    local year date output_dir template output_file
    year=$(date +%Y)
    date=$(date +%Y-%m-%d)
    [[ -n "$WORKSPACE_TROUBLESHOOT" ]] || { _gap; log_error "WORKSPACE_TROUBLESHOOT is not set"; return 1; }
    output_dir="$WORKSPACE_TROUBLESHOOT/$year/$date/$name"
    template="$GEN_TEMPLATE_DIR/${doc_type}.md"
    output_file="$output_dir/${doc_type}.md"

    _gen_check_template "$template" || return 1
    mkdir -p "$output_dir" || { _gap; log_error "Could not create document directory: $output_dir"; return 1; }
    sed "s/{{DATE}}/$date/g" "$template" > "$output_file" || { _gap; log_error "Could not generate $doc_type document"; return 1; }
    _gap; log_success "Generated $doc_type document: $name"
    log_debug "Output file: $output_file"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

gen_help() {
    _describe command 'gen' \
        'uuid                  Generate UUID' \
        'trouble [name]         Create troubleshooting dir (cwd)' \
        'feat [name]            Create feature dir' \
        'workspace [name]       Create ~/<name> (documents, archive, artifacts, downloads, tmp, repos)' \
        'project [name]         Create project structure' \
        'doc [type] [name]      Generate doc from template (→ \$WORKSPACE_TROUBLESHOOT/<year>/<date>/<name>)' \
        'aliases                List gen aliases' \
        'Structure and doc generator'
}

gen_list_aliases() {
    _gap
    _box "Gen aliases"
    _br
    _label "  gtrouble";  _muted_nl "    [name] = gen trouble"
    _label "  gfeat";     _muted_nl "    [name] = gen feat"
    _label "  gws";       _muted_nl "    [name] = gen workspace"
    _label "  gproject";  _muted_nl "    [name] = gen project"
    _label "  gdoc";      _muted_nl "    [type] [name] = gen doc"
    _br
}

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        gen_help
        return 0
    fi

    case "$cmd" in
        help|--help|-h) gen_help ;;
        uuid)           uuidgen ;;
        aliases)        gen_list_aliases ;;
        trouble)        shift; gen_trouble "$@" ;;
        feat)           shift; gen_feat "$@" ;;
        workspace)      shift; gen_workspace "$@" ;;
        project)        shift; gen_project "$@" ;;
        doc)            shift; gen_doc "$@" ;;
        *)              _gap; log_error "Unknown gen command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"