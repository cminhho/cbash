# Setup Plugin

CBASH plugin for development environment setup: check tools, install via Homebrew (by group), create workspace, import dotfiles. Used by the [Mac Setup Guide](Mac-Setup-Guide.md).

Loaded at init when you source CBASH (aliases available in shell).

## Commands

| Command | Description |
|---------|-------------|
| `cbash setup` / `help` | Show help |
| `cbash setup aliases` | List setup aliases |
| `cbash setup check` | Check dev environment (Git, Node, Python, Docker, Java, git config) |
| `cbash setup brew [group]` | Install tools. Groups: `dev`, `cloud`, `ide`, `apps`, `all` |
| `cbash setup workspace [dir]` | Create workspace (default `~/workspace`) with projects, tools, docs, scripts, sandbox |
| `cbash setup dotfiles` | Copy dotfiles from `$CBASH_DIR/dotfiles` to `$HOME` |

## Aliases

| Alias | Command |
|-------|--------|
| `scheck` | setup check |
| `sbrew` | setup brew (use: sbrew dev \| cloud \| ide \| apps \| all) |
| `sws` | setup workspace (optional: sws /path/to/dir) |
| `sdot` | setup dotfiles |

## Brew groups

- **dev** – zsh, git, tree, curl, jq, nvm, pnpm, python, pyenv, maven, dbeaver, etc.
- **cloud** – awscli, terraform, docker, completions
- **ide** – VS Code, IntelliJ, PyCharm, Postman, Mockoon
- **apps** – Chrome, Slack, Teams, Zoom, Notion, devtoys, mas
- **all** – dev + cloud + ide + apps

## Prerequisites

- macOS (Homebrew for `brew` commands)
- CBASH installed and `CBASH_DIR` set

## Examples

```bash
scheck              # check installed tools and git config
sbrew dev           # install dev group
sbrew all           # install all groups
sws                 # create ~/workspace structure
sws ~/myworkspace   # create workspace at custom path
sdot                # import dotfiles
cbash setup aliases
```

## See also

- [Mac-Setup-Guide.md](Mac-Setup-Guide.md) – full new Mac setup workflow (system preferences, Homebrew, CBASH, git, manual reference).
