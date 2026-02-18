# CBASH CLI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE) [![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-blue?style=flat-square)](https://github.com/cminhho/cbash) [![macOS](https://img.shields.io/badge/macOS-Linux-lightgrey?style=flat-square)](https://github.com/cminhho/cbash)

> 🚀 **Shell productivity toolkit for developers** — Automate Git workflows, manage Docker/K8s, connect to AWS, and save hours with 200+ ready-to-use aliases. Works with Bash & Zsh on macOS, Linux, and WSL.

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

## Commands

CLI: `cbash <plugin> <subcommand>`. Run `cbash --full` for full list, `cbash <plugin> help` for plugin help.

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
| Docs | `cbash docs cheat <name>` | View cheatsheet |
| Docs | `cbash docs cheat-list` | List cheatsheets |
| Docs | `cbash docs cheat-setup` | Download community cheatsheets |
| Docs | `cbash docs cheat-edit <name>` | Edit personal cheatsheet |
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

## Documentation

- [Architecture](docs/ARCHITECTURE.md) — System design, plugin structure
- [Commands Reference](docs/COMMANDS.md) — Full command list

## Contributing

PRs welcome! See [CONTRIBUTING.md](.github/CONTRIBUTING.md).

## Support

[![GitHub Sponsors](https://img.shields.io/github/sponsors/cminhho?logo=githubsponsors&style=flat-square)](https://github.com/sponsors/cminhho)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=flat-square&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/chungho)

## License

[MIT](LICENSE)
