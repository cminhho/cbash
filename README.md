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
  dev stop                      Stop Docker services
  dev restart                   Restart services
  dev logs           [service]  View container logs
  dev exec           <service>  Execute command in container
  dev status                    Show service status
  dev stats                     Show container resource usage

SETUP
  setup check                   Check dev environment
  setup brew         [group]    Install tools (dev|cloud|ide|all)
  setup workspace    [dir]      Create workspace structure
  setup dotfiles                Import dotfiles

GIT
  git squash                    Squash commits interactively
  git auto:commit               Auto commit and push changes
  git open                      Open repo in browser
  git sync                      Pull latest changes
  git prune                     Delete merged branches
  git branches                  List branches with dates

AWS
  aws login                     Login with Azure AD SSO
  aws keys                      Manage AWS credentials
  ssm                <env>      SSH to environment (sit|uat|prod)

GENERATORS
  gen feat           [name]     Create feature directory
  gen trouble        [name]     Create troubleshooting directory
  gen workspace      [name]     Create workspace structure
  boilr doc          <type>     Generate document (adr|meeting|design|cab)

UTILITIES
  mac update                    Update macOS, Homebrew, npm
  mac ports                     List used ports
  mac ip:local                  Get local IP
  mac ip:public                 Get public IP
  k8s                <pod>      Kubernetes helper
  cheat              <name>     View cheatsheet
  ai chat                       Chat with AI

ALIASES
  aliases list                  List alias files
  aliases show       <name>     Show aliases in file
  proxy enable       [url]      Enable proxy
  proxy disable                 Disable proxy

QUICK COMMANDS
  start, stop, restart      Docker services
  sit, uat, prod            SSH to AWS environment
  chat                      Chat with AI
  commit                    Auto commit and push
  auto_squash               Squash feature branch

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
