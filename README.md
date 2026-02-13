# CBASH CLI

🚀 Command-line tools for developers (macOS/Linux). Automate tasks, manage git repos, run dev services, and use helpers for AWS, K8s, and docs.

## Quick Install

**via curl:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
```

**via wget:**
```bash
sh -c "$(wget -qO- https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
```

**Manual:**
```bash
git clone https://github.com/cminhho/cbash.git ~/.cbash
echo 'export CBASH_DIR="$HOME/.cbash" && source "$CBASH_DIR/cbash.sh"' >> ~/.zshrc
source ~/.zshrc
```

## Requirements

- Unix-like OS (macOS, Linux, WSL2)
- Bash 4.0+ or Zsh
- Git, curl or wget

## What Gets Installed

- `~/.cbash/` - Installation directory
- Shell config updated (`.zshrc`, `.bashrc`, `.bash_profile`)

After install, restart terminal and run `cbash` for help.

## Usage

```bash
cbash                   # Show all commands
cbash <plugin>          # Run plugin (auto-discovery)
cbash list-plugins      # List available plugins
```

```
cbash
CBASH CLI (1.0) – macOS command line tools for developers

USAGE
  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]

DEVELOPMENT
  dev start                     Start Docker services
  dev stop / restart            Stop or restart services
  dev logs           [service]  View container logs
  dev exec           <service>  Execute command in container
  dev status / stats            Service status, container stats
  Aliases: start, stop, restart, devlogs, devstatus, devkill

SETUP (Mac Setup Guide)
  setup check                   Check dev environment
  setup brew         [group]    Install tools (dev|cloud|ide|apps|all)
  setup workspace    [dir]      Create workspace structure
  setup dotfiles                Import dotfiles
  Aliases: scheck, sbrew, sws, sdot

GIT
  git                            Git plugin (aliases: g, gst, gco, commit, auto_squash, ...)
  git squash / auto-commit       Squash commits, auto commit and push
  git open / sync                Open repo in browser, pull latest
  git branches                   List branches with dates

AWS
  aws login / aws keys           Login, manage credentials
  ssm                <env>      SSH to environment (sit|uat|prod)

GENERATORS (gen — structure + doc)
  gen feat           [name]     Create feature directory
  gen trouble        [name]     Create troubleshooting directory
  gen workspace      [name]     Create workspace structure
  gen project        [name]     Create project structure
  gen doc            [type]     Generate doc from template (adr|meeting|design|cab|...)
  Aliases: gtrouble, gfeat, gws, gproject, gdoc

UTILITIES
  macos / misc                  MacOS plugin (ips, myip, passgen, lock, update, ...)
  macos update / ports          Update Homebrew npm pip, list ports
  macos ip-local / ip-public     Local and public IP
  docker                        Docker helpers (dps, dr, drm, docker running, kill-all)
  mvn / npm                     Maven (mvnw) and npm/npx aliases
  doc / docs                    Docs plugin: list, edit, view
  k8s                <pod>      Kubernetes helper
  cheat              <name>     View cheatsheet
  ai chat                       Chat with AI

ALIASES
  aliases list / show <name>    List or show alias files
  proxy enable [url] / disable  Enable or disable proxy

QUICK COMMANDS
  start, stop, restart, devlogs     Dev / Docker
  scheck, sbrew, sws, sdot          Setup
  gfeat, gtrouble, gws, gdoc        Gen
  sit, uat, prod                    SSH to AWS
  commit, auto_squash               Git
  chat                              AI chat

Run cbash <plugin> for detailed help on each plugin.
```

## Upgrade & Uninstall

```bash
# Upgrade
cbash cli update
# or
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/upgrade.sh)"

# Uninstall
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/uninstall.sh)"
```

## License

MIT — see [LICENSE](LICENSE).
