# npm

Node.js / npm / npx aliases. Inspired by [ohmyzsh npm plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm).

Loaded automatically when you source CBASH.

## Commands

* `cbash npm` or `cbash npm help`: show plugin help.
* `cbash npm list`: list npm/npx aliases.

## Aliases

### Short (n / ni / nr / nx)

| Alias | Command |
|-------|--------|
| `n` | npm |
| `ni` | npm install |
| `nis` | npm install --save |
| `nid` | npm install --save-dev |
| `nit` | npm install-test |
| `nu` | npm uninstall |
| `nus` | npm uninstall --save |
| `nusd` | npm uninstall --save-dev |
| `np` | npm publish |
| `nup` | npm unpublish |
| `nlk` | npm link |
| `nod` | npm outdated |
| `nrb` | npm rebuild |
| `nud` | npm update |
| `nr` | npm run |
| `nls` | npm list --depth=0 |
| `nlsg` | npm list -g --depth=0 |
| `nt` | npm test |
| `nx` | npx |

### npm* (ohmyzsh-style)

| Alias | Command |
|-------|--------|
| `npmg` | npm i -g |
| `npmS` | npm i -S |
| `npmD` | npm i -D |
| `npmF` | npm i -f |
| `npmE` | PATH="$(npm bin):$PATH" (run local bin) |
| `npmO` | npm outdated |
| `npmU` | npm update |
| `npmL` | npm list |
| `npmL0` | npm ls --depth=0 |
| `npmst` | npm start |
| `npmt` | npm test |
| `npmR` | npm run |
| `npmP` | npm publish |
| `npmI` | npm init |
| `npmi` | npm info |
| `npmSe` | npm search |
| `npmrd` | npm run dev |
| `npmrb` | npm run build |
| `npmV` | npm -v |

### npx variants

| Alias | Description |
|-------|-------------|
| `nxplease` | npx \<last shell command\> |
| `nxn` | npx --no-install |
| `nxp` | npx -p |
| `nxq` | npx -q |
| `nxni` | npx --no-install --ignore-existing |
| … | nxnq, nxnp, nxqp, nxip, etc. |

## Prerequisites

* [Node.js](https://nodejs.org/) and npm on PATH.

## Examples

```bash
ni              # npm install
nid lodash      # npm install --save-dev lodash
nr dev          # npm run dev
nx vitest       # npx vitest
cbash npm list
```
