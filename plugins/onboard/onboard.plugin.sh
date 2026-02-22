#!/usr/bin/env bash
# Onboard plugin for CBASH - Step-by-step onboarding: check → templates → workspace → tools.
# shellcheck disable=SC2154

readonly ONBOARD_SENTINEL="${HOME}/.cbash-onboard-done"
readonly ONBOARD_STEPS=4

_onboard_sentinel_exists() {
    [[ -f "$ONBOARD_SENTINEL" ]]
}

_onboard_sentinel_set() {
    touch "$ONBOARD_SENTINEL"
}

# Print step header (e.g. "Step 1/4: Environment check")
_onboard_step_header() {
    local n="$1" title="$2"
    printf "\n  ${style_ok}Step %s/%s: %s${clr}\n" "$n" "$ONBOARD_STEPS" "$title"
}

# ---- Subcommands (no flags) ----

onboard_welcome() {
    _gap
    _box "Welcome to CBASH CLI"
    _muted_nl "Command. Compose. Control. — A composable CLI toolkit for Bash automation."
    _br
    _label_nl "Quick start:"
    printf "  ${style_muted}cbash%s${clr}          Show minimal help\n" ""
    printf "  ${style_muted}cbash onboard%s${clr}       Quick setup (workspace + check)\n" ""
    printf "  ${style_muted}cbash onboard --interactive%s${clr}  Wizard: workspace, tools, etc.\n" ""
    printf "  ${style_muted}cbash onboard check%s${clr}  Verify your setup\n" ""
    printf "  ${style_muted}cbash onboard guide%s${clr}   Print short usage guide\n" ""
    _br
}

onboard_check() {
    _gap; _box "Onboard check"; _br
    local ok=0
    if [[ -n "${CBASH_DIR:-}" && -f "${CBASH_DIR}/cbash.sh" ]]; then
        _ok "CBASH_DIR is set and cbash.sh found"
    else
        _err "CBASH_DIR not set or cbash.sh missing"
        ok=1
    fi
    if command -v git &>/dev/null; then
        _ok "Git: $(git --version 2>/dev/null | head -n1)"
    else
        _err "Git not found"
        ok=1
    fi
    if [[ -n "${BASH_VERSION:-}" || -n "${ZSH_VERSION:-}" ]]; then
        _ok "Shell: ${BASH_VERSION:-$ZSH_VERSION}"
    else
        _muted_nl "  Shell: unknown"
    fi
    _br
    [[ $ok -eq 0 ]] && log_success "You're good to go." || log_warning "Fix the items above and run 'cbash onboard check' again."
}

onboard_guide() {
    _gap; _box "CBASH quick guide"; _br
    _label_nl "Essential commands:"
    printf "  ${style_ok}cbash git sync${clr}       Fetch and pull current repo\n"
    printf "  ${style_ok}cbash git pull-all [dir]${clr}  Pull all repos in a directory\n"
    printf "  ${style_ok}cbash dev start${clr}       Start Docker Compose services\n"
    printf "  ${style_ok}cbash setup check${clr}     Check dev environment\n"
    _br
    _label_nl "Plugins:"
    printf "  ${style_muted}git, dev, docker, k8s, aws, setup, gen, docs, ai, macos, ...${clr}\n"
    _br
    _muted_nl "Run 'cbash <plugin> help' for plugin-specific help. See README for full command list."
    _br
}

# ---- Step 2: Copy global templates (dotfiles, dev, ...) ----

_onboard_step_copy_templates() {
    local data_dir="${CBASH_DATA_DIR:-$HOME/.cbash}"
    local src_dir="${CBASH_DIR:-}/templates"
    local copied=() kept=() rel dest dir

    [[ -d "$src_dir" ]] || return 0

    while IFS= read -r -d '' f; do
        [[ -n "$f" ]] || continue
        rel="${f#$src_dir/}"
        dest="$data_dir/$rel"
        if [[ -f "$dest" ]]; then
            kept+=("$rel")
        else
            dir="$(dirname "$dest")"
            mkdir -p "$dir" && cp "$f" "$dest" && copied+=("$rel")
        fi
    done < <(find "$src_dir" -type f -print0 2>/dev/null)

    if [[ ${#copied[@]} -gt 0 ]]; then
        log_info "Copied to $data_dir: ${copied[*]}"
    fi
    if [[ ${#kept[@]} -gt 0 ]]; then
        _muted_nl "  Already present (skipped): ${kept[*]}"
    fi
    if [[ ${#copied[@]} -eq 0 && ${#kept[@]} -eq 0 ]]; then
        _muted_nl "  No template files in $src_dir"
    fi
}

# ---- Workspace + install apps (setup plugin) ----

_onboard_do_check() {
    onboard_check
}

_onboard_do_workspace() {
    local name="${1:-workspace}"
    if [[ -f "${CBASH_DIR:-}/plugins/setup/setup.plugin.sh" ]]; then
        log_info "Creating default workspace: $name"
        "$CBASH_DIR/plugins/setup/setup.plugin.sh" workspace "$name"
    else
        log_warning "Setup plugin not found; skipping workspace creation."
    fi
}

_onboard_do_brew() {
    local group="${1:-dev}"
    if [[ -f "${CBASH_DIR:-}/plugins/setup/setup.plugin.sh" ]]; then
        log_info "Installing development tools (group: $group)"
        "$CBASH_DIR/plugins/setup/setup.plugin.sh" brew "$group"
    else
        log_warning "Setup plugin not found; skipping tool installation."
    fi
}

# Run full onboarding flow: Step 1 → 2 → 3 → 4 (industry practice order).
onboard_run() {
    local interactive=$1 force=$2 workspace_only=$3 tools_only=$4

    if [[ $workspace_only -eq 0 && $tools_only -eq 0 ]] && _onboard_sentinel_exists && [[ $force -eq 0 && $interactive -eq 0 ]]; then
        log_warning "Onboarding already completed. Use --force to re-run or --interactive to choose steps."
        return 0
    fi

    _gap; _box "CBASH onboarding"; _br
    _muted_nl "Order: 1) Environment check → 2) Global templates → 3) Workspace → 4) Tools (optional)"
    _br

    if [[ $interactive -eq 1 ]]; then
        if _onboard_sentinel_exists && [[ $force -eq 0 ]]; then
            _label_nl "Onboarding was run before. Choose:"
            printf "  ${style_muted}1) Full onboarding (all steps again)${clr}\n"
            printf "  ${style_muted}2) Tools only (step 4: install/update brew)${clr}\n"
            printf "  ${style_muted}3) Cancel${clr}\n"
            read -r -p "Choice [1/2/3]: " choice
            case "$choice" in
                2) _onboard_step_header 1 "Environment check"; _onboard_do_check
                   _onboard_step_header 4 "Tools (brew)"; _onboard_do_brew "dev"
                   return 0 ;;
                3) return 0 ;;
                *) : ;;
            esac
        fi
        _onboard_step_header 1 "Environment check"
        _onboard_do_check
        _onboard_step_header 2 "Global templates (dotfiles, dev, ...)"
        _onboard_step_copy_templates
        read -r -p "Step 3: Create default workspace? [Y/n]: " create_ws
        if [[ "${create_ws:-y}" =~ ^[yY] ]]; then
            _onboard_step_header 3 "Workspace"
            _onboard_do_workspace "workspace"
        fi
        read -r -p "Step 4: Install development tools (brew)? [y/N]: " install_tools
        if [[ "${install_tools:-n}" =~ ^[yY] ]]; then
            _onboard_step_header 4 "Tools (brew)"
            _onboard_do_brew "dev"
        fi
        _onboard_sentinel_set
        _br; log_success "Onboarding complete."
        return 0
    fi

    if [[ $workspace_only -eq 1 ]]; then
        _onboard_step_header 1 "Environment check"; _onboard_do_check
        _onboard_step_header 2 "Global templates"; _onboard_step_copy_templates
        _onboard_step_header 3 "Workspace"; _onboard_do_workspace "workspace"
        return 0
    fi
    if [[ $tools_only -eq 1 ]]; then
        _onboard_step_header 1 "Environment check"; _onboard_do_check
        _onboard_step_header 2 "Global templates"; _onboard_step_copy_templates
        _onboard_step_header 4 "Tools (brew)"; _onboard_do_brew "dev"
        return 0
    fi

    # Default: steps 1 → 2 → 3 (no tools)
    _onboard_step_header 1 "Environment check"
    _onboard_do_check
    _onboard_step_header 2 "Global templates (dotfiles, dev, ...)"
    _onboard_step_copy_templates
    if [[ $force -eq 1 ]] || ! _onboard_sentinel_exists; then
        _onboard_step_header 3 "Workspace"
        _onboard_do_workspace "workspace"
        _onboard_sentinel_set
    fi
    _br; log_success "Quick setup done. Run 'cbash onboard --interactive' for step 4 (brew) or customize."
}

# ---- Help and router ----

onboard_help() {
    _describe command 'onboard' \
        '                Quick setup: steps 1→2→3 (check, templates, workspace)' \
        '--interactive   Wizard: all steps with prompts (workspace?, brew?)' \
        '--force         Re-run even if onboarding was already done' \
        '--workspace-only  Steps 1+2+3 only (check, templates, workspace)' \
        '--tools-only    Steps 1+2+4 only (check, templates, brew)' \
        'welcome         Show welcome and quick start' \
        'check           Verify CBASH and env setup' \
        'guide           Print short usage guide' \
        'Step-by-step onboarding (check → templates → workspace → tools)'
}

_main() {
    local interactive=0 force=0 workspace_only=0 tools_only=0
    local args=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --interactive)   interactive=1; shift ;;
            -i)             interactive=1; shift ;;
            --force)        force=1; shift ;;
            -f)             force=1; shift ;;
            --workspace-only) workspace_only=1; shift ;;
            --tools-only)   tools_only=1; shift ;;
            --brew-only)    tools_only=1; shift ;;
            help|--help|-h) onboard_help; return 0 ;;
            welcome)        onboard_welcome; return 0 ;;
            check)          onboard_check; return 0 ;;
            guide)          onboard_guide; return 0 ;;
            *)
                if [[ "$1" == --* ]]; then
                    log_error "Unknown option: $1"
                    return 1
                fi
                args+=("$1"); shift
                ;;
        esac
    done

    # No subcommand and no flags → default quick setup
    if [[ $interactive -eq 0 && $force -eq 0 && $workspace_only -eq 0 && $tools_only -eq 0 && ${#args[@]} -eq 0 ]]; then
        onboard_run 0 0 0 0
        return 0
    fi

    # Flags only → run onboarding with flags
    if [[ ${#args[@]} -eq 0 ]]; then
        onboard_run "$interactive" "$force" "$workspace_only" "$tools_only"
        return 0
    fi

    # Unknown positional (e.g. "cbash onboard foo")
    log_error "Unknown: ${args[0]}"
    return 1
}
