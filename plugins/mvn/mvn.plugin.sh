#!/usr/bin/env bash
# Maven plugin for CBASH - Maven wrapper and aliases

# -----------------------------------------------------------------------------
# mvnw support: call mvnw if found in current or parent dir, else mvn
# -----------------------------------------------------------------------------

mvn-or-mvnw() {
    local dir="$PWD"
    while [[ ! -x "$dir/mvnw" && "$dir" != "/" ]]; do
        dir="$(dirname "$dir")"
    done

    if [[ -x "$dir/mvnw" ]]; then
        log_info "Running \`$dir/mvnw\`..." >&2
        "$dir/mvnw" "$@"
        return $?
    fi

    command mvn "$@"
}

# Run mvn against root POM in git repo (optional)
mvn-root() {
    local root
    root="$(git rev-parse --show-toplevel 2>/dev/null)" || root="."
    mvn-or-mvnw -f "$root/pom.xml" "$@"
}

# -----------------------------------------------------------------------------
# Plugin commands (cbash mvn ...)
# -----------------------------------------------------------------------------

mvn_help() {
    _describe command 'mvn' \
        'help    Show this help' \
        'list    List Maven aliases' \
        'Maven wrapper and aliases (mvnw when present, else mvn)'
}

mvn_list() {
    echo "Maven aliases:"
    echo "  mvn, mci, mi, mcp, mp, mdep, mpom, mcisk, mcpsk"
    echo "  mrprep, mrperf, mrrb, install, build, test, clean, run, run_debug_app"
    echo "  mvnag, mvnboot, mvnc, mvnci, mvncp, mvncom, mvndt, mvnt, mvnqdev"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") mvn_help ;;
        list)              mvn_list ;;
        *)                 mvn_help ;;
    esac
}
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
