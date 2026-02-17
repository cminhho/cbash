#!/usr/bin/env bash
# npm plugin for CBASH - npm/npx aliases

# Help and router
npm_help() {
    _describe command 'npm' \
        'list    List npm/npx aliases' \
        'npm and npx aliases for Node.js'
}

npm_list() {
    echo "npm: n, ni, nis, nid, nit, nu, nus, nusd, np, nup, nlk, nod, nrb, nud, nr, nls, nlsg, nt, npmg, npmS, npmD, npmF, npmE, npmO, npmU, npmL, npmL0, npmst, npmt, npmR, npmP, npmI, npmi, npmSe, npmrd, npmrb, npmV"
    echo "npx: nx, nxplease, nxn, nxp, nxnp, nxq, nxnq, nxqp, nxnqp, nxni, nxip, nxnip, nxqi, nxniq, nxiqp, nxniqp"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") npm_help ;;
        list) npm_list ;;
        *)    npm_help ;;
    esac
}

