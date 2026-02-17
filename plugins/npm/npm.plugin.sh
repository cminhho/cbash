#!/usr/bin/env bash
# npm plugin for CBASH
# Node.js / npm / npx aliases. Inspired by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm

[[ -n "$CBASH_DIR" ]] && [[ -f "$CBASH_DIR/lib/common.sh" ]] && source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Aliases (from aliases/npm.sh + ohmyzsh-style)
# -----------------------------------------------------------------------------

alias n='npm'

# npm install / uninstall
alias ni='npm install'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias nit='npm install-test'
alias nits='npm install-test --save'
alias nitd='npm install-test --save-dev'
alias nu='npm uninstall'
alias nus='npm uninstall --save'
alias nusd='npm uninstall --save-dev'
alias npmg='npm i -g '
alias npmS='npm i -S '
alias npmD='npm i -D '
alias npmF='npm i -f'

# npm run / scripts
alias nr='npm run'
alias npmst='npm start'
alias nt='npm test'
alias npmt='npm test'
alias npmR='npm run'
alias npmrd='npm run dev'
alias npmrb='npm run build'

# npm publish / list / info
alias np='npm publish'
alias nup='npm unpublish'
alias npmP='npm publish'
alias nlk='npm link'
alias nod='npm outdated'
alias npmO='npm outdated'
alias nrb='npm rebuild'
alias nud='npm update'
alias npmU='npm update'
alias nls='npm list --depth=0 2>/dev/null'
alias nlsg='npm list -g --depth=0 2>/dev/null'
alias npmL='npm list'
alias npmL0='npm ls --depth=0'
alias npmI='npm init'
alias npmi='npm info'
alias npmSe='npm search'
alias npmV='npm -v'

# Run bin from node_modules: npmE gulp
alias npmE='PATH="$(npm bin):$PATH"'

# npx
alias nx='npx'
alias nxplease='npx $(fc -ln -1 2>/dev/null || history 1 | sed "s/^[[:space:]]*[0-9]*[[:space:]]*//")'
alias nxn='npx --no-install '
alias nxp='npx -p '
alias nxnp='npx --no-install -p '
alias nxq='npx -q '
alias nxnq='npx --no-install -q '
alias nxqp='npx -q -p '
alias nxnqp='npx --no-install -q -p '
alias nxni='npx --no-install --ignore-existing '
alias nxip='npx --ignore-existing -p '
alias nxnip='npx --no-install --ignore-existing -p '
alias nxqi='npx -q --ignore-existing '
alias nxniq='npx --no-install --ignore-existing -q '
alias nxiqp='npx --ignore-existing -q -p '
alias nxniqp='npx --no-install --ignore-existing -q -p '

# -----------------------------------------------------------------------------
# Plugin commands (cbash npm ...)
# -----------------------------------------------------------------------------

npm_help() {
    _describe command 'npm' \
        'help    Show this help' \
        'list    List npm/npx aliases' \
        'npm and npx aliases for Node.js'
}

npm_list() {
    echo "npm aliases: n, ni, nis, nid, nit, nu, nus, nusd, np, nup, nlk, nod, nrb, nud, nr, nls, nlsg, nt"
    echo "  npmg, npmS, npmD, npmF, npmE, npmO, npmU, npmL, npmL0, npmst, npmt, npmR, npmP, npmI, npmi, npmSe, npmrd, npmrb, npmV"
    echo "npx aliases: nx, nxplease, nxn, nxp, nxnp, nxq, nxnq, nxqp, nxnqp, nxni, nxip, nxnip, nxqi, nxniq, nxiqp, nxniqp"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") npm_help ;;
        list)              npm_list ;;
        *)                 npm_help ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
