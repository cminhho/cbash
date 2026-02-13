#!/usr/bin/env bash
# Maven plugin for CBASH
# Uses mvnw when present in project, otherwise system mvn. Defines Maven aliases.
# Inspired by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/mvn

[[ -n "$CBASH_DIR" ]] && [[ -f "$CBASH_DIR/lib/common.sh" ]] && source "$CBASH_DIR/lib/common.sh"

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
# Aliases (same as previous aliases/mvn.sh + common ohmyzsh-style)
# -----------------------------------------------------------------------------

alias mvn='mvn-or-mvnw'

# Project lifecycle
alias install='mvn clean install'
alias build='mvn clean install -DskipTests'
alias test='mvn test'
alias clean='mvn clean'
alias run='mvn spring-boot:run -Plocal'
alias run_debug_app='mvn spring-boot:run -Plocal -Drun.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=$PORT_NUMBER"'

# Short Maven aliases
alias mci='mvn clean install'
alias mi='mvn install'
alias mcp='mvn clean package'
alias mp='mvn package'
alias mrprep='mvn release:prepare'
alias mrperf='mvn release:perform'
alias mrrb='mvn release:rollback'
alias mdep='mvn dependency:tree'
alias mpom='mvn help:effective-pom'
alias mcisk='mci -Dmaven.test.skip=true'
alias mcpsk='mcp -Dmaven.test.skip=true'

# Extra ohmyzsh-style aliases
alias mvnag='mvn archetype:generate'
alias mvnboot='mvn spring-boot:run'
alias mvnc='mvn clean'
alias mvnci='mvn clean install'
alias mvncp='mvn clean package'
alias mvncom='mvn compile'
alias mvndt='mvn dependency:tree'
alias mvnp='mvn package'
alias mvnt='mvn test'
alias mvnqdev='mvn quarkus:dev'

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
    local cmd="${1:-help}"

    case "$cmd" in
        help|--help|-h) mvn_help ;;
        list)           mvn_list ;;
        *)              mvn_help ;;
    esac
}

# Run _main only when script is executed (cbash mvn), not when sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
