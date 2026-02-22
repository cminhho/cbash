<h1 align="center">
  <code style="font-size:1.15em;letter-spacing:0.15em;font-weight:600;color:#00aa00">CBASH</code> <code style="font-size:1.15em;font-weight:600;color:#00aa00">CLI</code>
</h1>

<p align="center">
  <strong>Command. Compose. Control.</strong><br />
  A composable CLI toolkit for Bash automation.
</p>

<p align="center">
  <a href="#overview">Overview</a> •
  <a href="#why-cbash">Why CBASH</a> •
  <a href="#features">Features</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#commands">Commands</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#development">Development</a> •
  <a href="#contributing">Contributing</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20WSL-blue" alt="Platform" />
  <img src="https://img.shields.io/badge/shell-Bash%20%7C%20Zsh-4EAA25?logo=gnubash" alt="Shell" />
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT" /></a>
</p>

A composable CLI toolkit for Bash automation — no runtime, no config files. One entry point, 15+ plugins, 200+ aliases. Works with Bash 4+ and Zsh on macOS, Linux, and WSL.

```
200+ aliases · 15+ plugins · Bash & Zsh · Zero config · Git · Docker · K8s · AWS · Ollama
```

---

## Overview

**CBASH CLI** turns repetitive terminal workflows into short, memorable commands. Automate Git (clone from lists, pull-all, run commands across repos), manage Docker and Kubernetes, connect to AWS via SSM, scaffold workspaces and docs, and chat with local AI—all through a single plugin-based CLI.

Works with Bash 4+ and Zsh on macOS, Linux, and WSL. No config files required to get started.

---

## Why CBASH

- **Composable by default:** One binary entry (`cbash`), plugins for Git, Docker, K8s, AWS, dev, docs, AI. Add your own in `plugins/<name>/`.
- **Zero config:** No config files to get started. Optional aliases and env vars when you need them.
- **Shell-native:** Bash 4+ and Zsh. Sourced aliases, no daemon, no runtime. Fits your existing workflow.
- **Copy-paste friendly:** Short commands and 200+ aliases so you type less and ship faster.

| Task | Without CBASH | With CBASH |
|------|---------------|------------|
| Clone from list | Manual clone each repo | `clone_all repos.txt` |
| Pull all repos | `for d in */; do cd "$d" && git pull && cd ..; done` | `pull_all` |
| Run cmd in all repos | Loop + cd + eval | `gitfor "cmd"` |
| Sync repo | `git fetch && git pull` | `gitsync` |
| Auto-commit & push | `git add . && git commit -m "..." && git push` | `commit` |
| Squash feature branch | Interactive rebase, force push | `auto_squash` |

**Quick examples:**

```bash
clone_all repos.txt     # Clone repos from a list file
pull_all ~/repos        # Pull all repos in a directory
gitfor "git status"     # Run command in all repos
gitsync                 # Fetch and pull current repo
commit                  # Auto-commit all changes with timestamp
auto_squash             # Squash all commits on feature branch
```

---

## Features

| Category | Description |
|----------|-------------|
| **Git & repos** | Batch clone from a file, pull-all in a directory, run any command across repos, auto-commit with timestamp, squash feature branches, sync, undo, backup, open repo in browser |
| **Docker & Dev** | Start/stop/restart Docker Compose services, follow logs, exec into containers, list running containers, prune images, manage local dev stacks from one CLI |
| **Kubernetes** | List pods, follow logs, describe, exec into pods, rollout restart deployments, kubectl cheat commands |
| **AWS** | SSH via SSM, read SSM parameters; with LocalStack: create and test SQS queues |
| **Scaffolding & docs** | Generate feature/troubleshooting dirs, workspace and project structures, docs from templates; view, list, edit docs in DOCS_DIR |
| **AI (Ollama)** | Chat with local models, list and pull Ollama models from the shell |
| **System & proxy** | macOS: lock screen, speedtest, memory/ports, IP (local/public), system update, password generator. Proxy: enable/disable/show |

---

## Quick Start

```bash
# Install (Homebrew recommended)
brew install cminhho/tap/cbash-cli

# Or one-liner
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"

# First run
cbash                           # Minimal help
cbash --full                    # All commands
cbash onboard welcome            # Welcome and quick start
cbash onboard check              # Verify setup

# Daily use
cbash git sync                   # Fetch and pull
cbash git pull-all ~/repos       # Pull all repos
cbash dev start                  # Start Docker Compose
cbash setup check                # Check dev environment

# Upgrade
cbash cli update                 # Self-upgrade
brew upgrade cbash-cli            # If installed via Homebrew
```

> **Requirements:** macOS, Linux (e.g. Ubuntu 20.04+), or WSL2 · Bash 4.0+ or Zsh · Git

---

## Commands

CLI form: `cbash <plugin> <subcommand>`. Use `cbash --full` for the full list and `cbash <plugin> help` for plugin help.

| Plugin | Command | Description |
|--------|---------|-------------|
| Setup | `cbash setup check` | Check dev environment |
| Setup | `cbash setup brew [group]` | Install tools (dev, cloud, ide, apps, all) |
| Setup | `cbash setup workspace [name]` | Create workspace structure |
| Aliases | `cbash aliases list` | List alias files |
| Aliases | `cbash aliases show <name>` | Show aliases in file |
| Aliases | `cbash aliases edit <name>` | Edit alias file |
| Aliases | `cbash aliases load` | Load all aliases |
| Git | `cbash git auto-commit` | Auto commit and push |
| Git | `cbash git auto-squash` | Squash feature branch |
| Git | `cbash git squash` | Squash commits interactively |
| Git | `cbash git pull-all [dir]` | Pull all repos |
| Git | `cbash git clone-all <file>` | Clone repos from file |
| Git | `cbash git for "<cmd>"` | Run command in all repos |
| Git | `cbash git branch <name>` | Create branch from master |
| Git | `cbash git rename <name>` | Rename current branch |
| Git | `cbash git undo` | Undo last commit |
| Git | `cbash git backup` | Quick commit and push |
| Git | `cbash git config` | Show git config |
| Git | `cbash git log` | Recent commits |
| Git | `cbash git branches` | List branches with dates |
| Git | `cbash git clean` | Clean and optimize repo |
| Git | `cbash git size` | Show repo size |
| Git | `cbash git sync` | Fetch and pull |
| Git | `cbash git open` | Open repo in browser |
| Dev | `cbash dev start [svc]` | Start Docker services |
| Dev | `cbash dev stop [svc]` | Stop services |
| Dev | `cbash dev restart [svc]` | Restart services |
| Dev | `cbash dev reload [svc]` | Recreate and start |
| Dev | `cbash dev status` | Service status |
| Dev | `cbash dev list` | List services |
| Dev | `cbash dev logs [svc]` | Follow logs |
| Dev | `cbash dev exec <svc>` | Shell into service |
| Dev | `cbash dev stats` | Container stats |
| Dev | `cbash dev ip` | Container IPs |
| Dev | `cbash dev kill-all` | Stop and remove all |
| Docker | `cbash docker running` | List running containers |
| Docker | `cbash docker stop-all` | Stop all containers |
| Docker | `cbash docker remove-stopped` | Remove stopped containers |
| Docker | `cbash docker prune-images` | Remove unused images |
| Docker | `cbash docker kill-all` | Stop, remove all and volumes |
| K8s | `cbash k8s pods [opts]` | List pods |
| K8s | `cbash k8s logs <pod>` | Follow pod logs |
| K8s | `cbash k8s desc <pod>` | Describe pod |
| K8s | `cbash k8s exec <pod>` | Shell into pod |
| K8s | `cbash k8s restart <deploy>` | Rollout restart |
| K8s | `cbash k8s cheat [pod]` | Show kubectl commands |
| AWS | `cbash aws ssh <profile>` | Connect via SSM |
| AWS | `cbash aws ssm-get` | Get SSM parameter |
| AWS | `cbash aws sqs-create` | Create SQS queue (localstack) |
| AWS | `cbash aws sqs-test` | Test SQS (localstack) |
| Gen | `cbash gen feat [name]` | Create feature dir |
| Gen | `cbash gen trouble [name]` | Create troubleshooting dir |
| Gen | `cbash gen workspace [name]` | Create workspace structure |
| Gen | `cbash gen project [name]` | Create project structure |
| Gen | `cbash gen doc [type]` | Generate doc from template |
| Docs | `cbash docs <name>` | View document |
| Docs | `cbash docs list` | List documents |
| Docs | `cbash docs edit <name>` | Edit document |
| AI | `cbash ai chat [model]` | Chat with AI (Ollama) |
| AI | `cbash ai list` | List Ollama models |
| AI | `cbash ai pull <model>` | Pull model |
| MacOS | `cbash macos info` | macOS version |
| MacOS | `cbash macos lock` | Lock screen |
| MacOS | `cbash macos speedtest` | Internet speed |
| MacOS | `cbash macos memory` | Processes by memory |
| MacOS | `cbash macos ports` | List listening ports |
| MacOS | `cbash macos ip-local` | Local IP |
| MacOS | `cbash macos ip-public` | Public IP |
| MacOS | `cbash macos update` | Update Homebrew, npm, pip |
| MacOS | `cbash macos passgen [n]` | Random password (n words) |
| Proxy | `cbash proxy enable [url]` | Enable proxy |
| Proxy | `cbash proxy disable` | Disable proxy |
| Proxy | `cbash proxy show` | Show proxy settings |
| Build | `cbash mvn` | Maven wrapper + aliases (mci, build, …) |
| Build | `cbash npm` | npm/npx aliases (ni, nr, nx, …) |
| CLI | `cbash cli update` | Upgrade CBASH CLI |

---

## Architecture

Single entry script discovers and loads plugins. Each plugin lives in `plugins/<name>/` with a main script and optional aliases file. The entry point sets `CBASH_DIR`, detects shell (Bash/Zsh), and routes `cbash <plugin> <args...>` to the plugin’s `_main()`.

| Layer | Purpose | Extend |
|-------|---------|--------|
| **Entry** | `cbash.sh` — shell detection, plugin discovery, routing | — |
| **Lib** | `common`, `help`, `colors`, `cli` — logging, help, styles | — |
| **Plugins** | Git, dev, docker, k8s, aws, setup, gen, docs, ai, macos, onboard, … | Add `plugins/<name>/<name>.plugin.sh` with `_main()` |
| **Aliases** | Optional per-plugin `*.aliases.sh` sourced on init | Add `<name>.aliases.sh` next to plugin |

```
User → cbash.sh → plugin loader → plugin.sh → _main()
                    ↓
              lib/ (common, help, colors, cli)
```

Full system design and plugin contract: [Architecture](docs/ARCHITECTURE.md).

---

## Development

**Prerequisites:** Bash 4+ or Zsh, Git

```bash
# Clone and run (no install)
git clone https://github.com/cminhho/cbash.git
cd cbash
CBASH_DIR="$PWD" ./cbash.sh onboard check
CBASH_DIR="$PWD" ./cbash.sh git sync
```

### Project structure

```
cbash-cli/
├── VERSION               # Single source of truth for version (SemVer)
├── cbash.sh              # Main entry point
├── assets/               # Demo and media (e.g. demo.tape for VHS GIFs)
├── lib/                  # Core (common, help, colors, cli)
├── plugins/              # Feature plugins
│   └── <name>/
│       ├── <name>.plugin.sh
│       └── <name>.aliases.sh
├── templates/            # Scaffolding templates (repos-sample.txt, dotfiles, …)
├── tools/                # Install/upgrade scripts
└── test/                 # Test suite
```

### Releasing

From repo root, use the release script (tags and pushes; CI creates the GitHub Release):

```bash
./tools/release.sh           # tag using version from VERSION
./tools/release.sh 1.2.0      # set VERSION to 1.2.0, commit, tag v1.2.0, push
./tools/release.sh --dry-run # show what would run
./tools/release.sh --no-push # create tag locally only
```

Then update the Homebrew formula with the tarball URL and SHA256 printed by the [Release workflow](.github/workflows/release.yml).

### Adding a plugin

1. Add `plugins/<name>/<name>.plugin.sh` with a `_main()` that handles subcommands.
2. Optionally add `plugins/<name>/<name>.aliases.sh` for shell aliases.
3. Plugins are auto-discovered on the next `cbash` run.
4. Register in `lib/help.sh` for minimal and full help.

---

## Documentation

- [Architecture](docs/ARCHITECTURE.md) — System design, plugin structure
- [Commands Reference](docs/COMMANDS.md) — Full command list
- [Config](docs/CONFIG.md) — Optional `~/.config/cbash/config` and `CBASH_*` variables

---

## Contributing

Add a plugin or improve an existing one:

- **New plugin** → `plugins/<name>/<name>.plugin.sh` + optional `*.aliases.sh`, then register in `lib/help.sh`
- **New command** → Add a case in the plugin’s `_main()` and a line in the plugin’s help
- **Docs or fixes** → Open a PR

1. Fork the repository  
2. Create a branch (`git checkout -b feature/your-feature`)  
3. Commit with clear messages  
4. Push and open a Pull Request  

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for guidelines and code style.

---

## Support

[![GitHub Sponsors](https://img.shields.io/github/sponsors/cminhho?logo=githubsponsors&style=flat-square)](https://github.com/sponsors/cminhho)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=flat-square&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/chungho)

---

## License

[MIT](LICENSE)

---

**CBASH CLI** — Command. Compose. Control. One entry point, plug in the rest.
