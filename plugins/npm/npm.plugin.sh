#!/usr/bin/env bash
# npm plugin for CBASH - npm/npx aliases

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
