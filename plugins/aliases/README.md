# Aliases plugin

Manage shell alias files and load them. Plugin-specific aliases (docker, git, npm, etc.) live in their plugins; this plugin holds **generic** aliases and the commands to list/show/edit/load alias files.

## Commands

| Command | Description |
| ------- | ----------- |
| `cbash aliases` | Show help |
| `cbash aliases list` | List alias files and alias count per file |
| `cbash aliases show <name>` | Show aliases in `<name>.sh` |
| `cbash aliases edit <name>` | Edit `<name>.sh` with `$EDITOR` |
| `cbash aliases load` | Source all alias files in this plugin |

## Alias files

- **common.sh** – Generic shell aliases (ls, cd, grep, history, etc.). No plugin-specific aliases (e.g. Docker `d` is in the docker plugin).

## common.sh reference

### ls

| Alias | Command |
| ----- | ------- |
| ls | `/bin/ls $LS_OPTIONS` |
| ll | `ls -l` |
| lsd | `ls -ld` |
| la | `ls -a` |
| lf | `ls -F` |
| lr | `ls -alFRt` |
| lx | `ls -xF` |
| llar | `ls -laFR` |
| lt | `ls -lartF` |
| lrt | `ls -lrt` |

### cd / navigation

| Alias | Command |
| ----- | ------- |
| up .. up5 | `cd ..` through `cd ../../../../..` |
| pe | `printenv` |
| senv | `env \| sort` |
| pu, po, pud, rot | pushd / popd |
| jobs | `jobs -l` |

### Shortcuts

| Alias | Command |
| ----- | ------- |
| l, f, c, m, j, k, h | ls, file, cat, more, jobs, kill, history |
| his, hm | history, history \| less |
| mroe, lses, lsse | more, less (typos) |
| del | `rm -i` |
| bye, ciao | exit |
| sy3 | sync x3 |

### macOS

| Alias | Command |
| ----- | ------- |
| o, open | `open -a TextEdit` |

### grep

| Alias | Command |
| ----- | ------- |
| grep, egrep, fgrep | `--color=auto` variants |

To add more alias files, create `<name>.sh` in `plugins/aliases/` and use `cbash aliases list` / `show` / `edit` / `load`.
