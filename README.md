# CBASH CLI

[![GitHub release](https://img.shields.io/github/v/release/cminhho/cbash?style=flat-square)](https://github.com/cminhho/cbash/releases) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/cminhho/cbash/pulls) [![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-blue?style=flat-square)](https://github.com/cminhho/cbash)

> 🚀 **Developer productivity toolkit** — Git workflows, Docker/K8s helpers, AWS tools, and 200+ aliases in one CLI.

![CBASH CLI Demo](demo.gif)

## Why CBASH?

**Stop typing long commands. Start shipping faster.**

```bash
commit              # Auto-commit all changes with timestamp
auto_squash         # Squash all commits on feature branch
squash              # Interactive squash
pull_all ~/repos    # Pull all repos in a directory
clone_all repos.txt # Clone repos from a list file
git_for "git status"  # Run command in all repos
git_sync            # Fetch and pull current repo
git_clean           # Clean and optimize repo
```

| Task | Without CBASH | With CBASH |
|------|---------------|------------|
| Auto-commit & push | `git add . && git commit -m "..." && git push` | `commit` |
| Pull all repos | `for d in */; do cd "$d" && git pull && cd ..; done` | `pull_all` |
| Run cmd in all repos | Loop + cd + eval | `git_for "cmd"` |
| Squash feature branch | Interactive rebase, force push | `auto_squash` |
| Clone from list | Manual clone each | `clone_all repos.txt` |

**200+ aliases** included — type less, do more.

## Features

- **Git workflows** — branch, squash, auto-commit, pull-all, clone-all
- **Dev services** — Docker Compose start/stop/logs/exec
- **Docker/K8s** — container management, kubectl shortcuts
- **Build tools** — Maven wrapper, npm/npx aliases
- **AWS** — SSM connect, SQS testing, parameter store
- **Generators** — scaffold projects, features, docs
- **Docs & Cheat** — personal docs, community cheatsheets
- **AI** — Ollama chat integration
- **macOS** — system info, ports, updates, passwords
- **Proxy** — manage proxy for shell, npm, git

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
cbash                   # Show all commands
cbash <plugin>          # Run plugin
cbash <plugin> help     # Plugin help
cbash list-plugins      # List plugins
```

**Available plugins:** `git`, `dev`, `docker`, `k8s`, `aws`, `gen`, `docs`, `ai`, `macos`, `proxy`, `mvn`, `npm`, `setup`, `aliases`

Run `cbash` for full command reference.

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
