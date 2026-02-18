#!/usr/bin/env bash
# Maven plugin for CBASH - Maven wrapper and aliases

# Helpers: use mvnw if found in current or parent dir
mvn-or-mvnw() {
    local dir="$PWD"
    while [[ ! -x "$dir/mvnw" && "$dir" != "/" ]]; do dir="$(dirname "$dir")"; done
    [[ -x "$dir/mvnw" ]] && { "$dir/mvnw" "$@"; return $?; }
    command mvn "$@"
}

mvn-root() {
    local root
    root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
    mvn-or-mvnw -f "$root/pom.xml" "$@"
}

# Help and router
mvn_help() {
    _describe command 'mvn' \
        'list    List Maven aliases' \
        'Maven wrapper (mvnw when present)'
}

mvn_list() {
    echo "Maven: mvn, mci, mi, mcp, mp, mdep, mpom, mcisk, mcpsk, mrprep, mrperf, mrrb, install, build, test, clean, run, run_debug_app, mvnag, mvnboot, mvnc, mvnci, mvncp, mvncom, mvndt, mvnt, mvnqdev"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") mvn_help ;;
        list) mvn_list ;;
        *)    mvn_help ;;
    esac
}
