# CBASH CLI

[![GitHub release](https://img.shields.io/github/v/release/cminhho/cbash?style=flat-square)](https://github.com/cminhho/cbash/releases) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/cminhho/cbash/pulls) [![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-blue?style=flat-square)](https://github.com/cminhho/cbash)

> 🚀 **Developer productivity toolkit** — Git workflows, Docker/K8s helpers, AWS tools, and 200+ aliases in one CLI.

![CBASH CLI Demo](assets/demo.gif)

## Why CBASH?

**Stop typing long commands. Start shipping faster.**

```bash
clone_all repos.txt     # Clone repos from a list file
pull_all ~/repos        # Pull all repos in a directory
gitfor "git status"     # Run command in all repos
gitsync                 # Fetch and pull current repo
commit                  # Auto-commit all changes with timestamp
auto_squash             # Squash all commits on feature branch
```

| Task | Without CBASH | With CBASH |
|------|---------------|------------|
| Clone from list | Manual clone each | `clone_all repos.txt` |
| Pull all repos | `for d in */; do cd "$d" && git pull && cd ..; done` | `pull_all` |
| Run cmd in all repos | Loop + cd + eval | `gitfor "cmd"` |
| Sync repo | `git fetch && git pull` | `gitsync` |
| Auto-commit & push | `git add . && git commit -m "..." && git push` | `commit` |
| Squash feature branch | Interactive rebase, force push | `auto_squash` |

**200+ aliases** included — type less, do more.

## Features

| Feature | Description | Commands |
|---------|-------------|----------|
| 🔀 **Git Automation** | Batch operations across repos, auto-commit with timestamps, squash before PR | `commit`, `auto_squash`, `pull_all`, `clone_all`, `gitfor`, `gitsync` |
| 🐳 **Docker & Dev** | Start/stop Docker Compose, follow logs, shell into containers | `start`, `stop`, `devlogs`, `devexec`, `devkill` |
| ☸️ **Kubernetes** | Quick access to pods, logs, exec, rollout restarts | `k8pods`, `k8logs`, `k8exec`, `k8restart` |
| ☁️ **AWS & Cloud** | SSM session manager, parameter store access | `awsssh`, `awsssmget` |
| 🛠️ **Generators** | Scaffold projects, features, generate docs from templates | `gfeat`, `gproject`, `gdoc` |
| 📚 **Docs & Cheat** | Personal docs, community cheatsheets (tldr, cheat.sh) | `doc`, `ch`, `chsetup` |
| 🤖 **AI Chat** | Chat with local LLMs via Ollama | `chat`, `aipull` |
| 🍎 **macOS Utils** | Ports, updates, lock screen, IP info | `mports`, `mupdate`, `mlock` |
| 🌐 **Proxy** | Toggle proxy for shell, npm, git | `proxon`, `proxoff` |
| 🔨 **Build Tools** | Maven and npm/npx shortcuts | `mci`, `ni`, `nr`, `nx` |

## Installation

**Homebrew (recommended):**
```bash
brew install cminhho/tap/cbash-cli
```

**One-liner:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
```

> **Requirements:** macOS/Linux/WSL2, Bash 4.0+ or Zsh, Git

## Usage

```bash
cbash                   # Show help (minimal)
cbash --full            # Show all commands
cbash <plugin>          # Run plugin
cbash <plugin> help     # Plugin help
```

## Upgrade & Uninstall

```bash
cbash cli update        # Upgrade
brew upgrade cbash-cli  # Homebrew upgrade
```

## Contributing

PRs welcome! See [CONTRIBUTING.md](.github/CONTRIBUTING.md).

## Support

[![GitHub Sponsors](https://img.shields.io/github/sponsors/cminhho?logo=githubsponsors&style=flat-square)](https://github.com/sponsors/cminhho)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=flat-square&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/chungho)

## License

[MIT](LICENSE)
