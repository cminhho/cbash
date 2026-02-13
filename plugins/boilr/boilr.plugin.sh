#!/usr/bin/env bash
# Boilr plugin for CBASH
# Template generator for documentation and project scaffolding

source "$CBASH_DIR/lib/common.sh"

# Template directory
readonly TEMPLATE_DIR="$CBASH_DIR/plugins/boilr/templates"

# Document types
readonly -a DOC_TYPES=("troubleshooting" "cab" "note" "adr" "meeting" "design" "cab-review" "code-review")

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_boilr_check_template() {
    local template="$1"
    [[ -f "$template" ]] || {
        echo "Error: Template not found: $template"
        return 1
    }
}

_boilr_get_date() {
    date +"%Y-%m-%d"
}

_boilr_get_year() {
    date +%Y
}

_boilr_prompt_input() {
    local prompt="$1"
    local value=""
    while [[ -z "$value" ]]; do
        read -rp "$prompt: " value
        [[ -z "$value" ]] && echo "Cannot be empty. Try again."
    done
    echo "$value"
}

_boilr_select_doc_type() {
    echo "Select document type:"
    echo "1) Troubleshooting (troubleshooting)"
    echo "2) Change Advisory Board (cab)"
    echo "3) General Note (note)"
    echo "4) Architecture Decision Record (adr)"
    echo "5) Meeting Notes (meeting)"
    echo "6) Technical Design (design)"
    echo "7) CAB Review (cab-review)"
    echo "8) Code Review (code-review)"
    
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

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

boilr_doc() {
    local doc_type="$1"
    local name="$2"

    # Prompt for type if not provided
    if [[ -z "$doc_type" ]]; then
        doc_type=$(_boilr_select_doc_type)
    fi

    # Validate doc type
    [[ " ${DOC_TYPES[*]} " =~ " ${doc_type} " ]] || {
        echo "Error: Invalid type. Use: ${DOC_TYPES[*]}"
        return 1
    }

    # Prompt for name if not provided
    [[ -z "$name" ]] && name=$(_boilr_prompt_input "Document name")

    # Setup paths
    local year=$(_boilr_get_year)
    local date=$(_boilr_get_date)
    local output_dir="$WORKSPACE_TROUBLESHOOT/$year/$date/$name"
    local template="$TEMPLATE_DIR/${doc_type}.md"
    local output_file="$output_dir/${doc_type}.md"

    # Check template exists
    _boilr_check_template "$template" || return 1

    # Create directory and generate file
    mkdir -p "$output_dir" || {
        echo "Error: Failed to create directory: $output_dir"
        return 1
    }

    sed "s/{{DATE}}/$date/g" "$template" > "$output_file" || {
        echo "Error: Failed to generate document"
        return 1
    }

    success "Generated $doc_type document at: $output_file"
}


# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'boilr' \
            'doc [type] [name]       Generate documentation from templates' \
            'Template generator for docs'
        return 0
    fi

    case "$cmd" in
        doc)    shift; boilr_doc "$@" ;;
        *)      abort "Invalid command: $cmd" ;;
    esac
}

_main "$@"
