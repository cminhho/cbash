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
cbash                   # Show help (same as cbash help)
cbash help              # Show help
cbash <plugin>          # Run plugin (auto-discovery)
cbash <plugin> help     # Plugin-specific help
cbash list-plugins      # List available plugins
```

Sample output of `cbash` / `cbash help`:

```
CBASH CLI (1.0.0) – macOS command line tools for developers

USAGE
  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]

SETUP
  setup                      Show help
  setup check                Check dev environment                    → scheck
  setup brew       [group]   Install tools (dev|cloud|ide|apps|all)   → sbrew
  setup workspace  [dir]     Create workspace structure               → sws
  setup dotfiles             Import dotfiles                          → sdot

ALIASES
  aliases                    Show help
  aliases list               List alias files
  aliases show     <name>    Show aliases in file
  aliases edit     <name>    Edit alias file
  aliases load               Load all aliases

GIT
  git                        Show help (aliases: g, gst, gco, commit, …)
  git config                 Show git config
  git log                    Recent commits
  git branches               List branches with dates
  git open                   Open repo in browser
  clone            <url>     Git clone (cbash clone)
  pull                      Git pull (cbash pull)

DEVELOPMENT
  dev                        Show help
  dev start        [svc]     Start Docker services                     → start
  dev stop         [svc]     Stop services                             → stop
  dev logs         [svc]     Follow logs                               → devlogs
  dev kill-all               Stop and remove all                       → devkill

DOCKER
  docker                     Show help (aliases: d, dps, dr, drm, dlo, …)
  docker running             List running containers
  docker stop-all            Stop all containers
  docker kill-all            Stop, remove all and volumes

MAVEN
  mvn                        Maven wrapper + aliases (mci, build, run, …)
  mvn list                   List Maven aliases

NPM
  npm                        npm/npx aliases (ni, nr, nx, nls, nt, …)
  npm list                   List npm/npx aliases

AWS
  aws                        Show help
  aws ssh          <profile> <env>  Connect to SSH gateway (SSM)       → awsssh
  aws sqs-create             Create SQS queue (localstack)             → awssqscreate
  aws ssm-get                Get SSM parameter                         → awsssmget

KUBERNETES (K8S)
  k8s                        Show help
  k8s pods         [opts]    List pods                                 → k8pods
  k8s logs         <pod>     Follow pod logs                           → k8logs
  k8s exec         <pod>     Shell into pod                            → k8exec
  k8s cheat        [pod]     Show kubectl commands                     → k8cheat

GENERATORS (GEN)
  gen                        Show help
  gen trouble      [name]    Create troubleshooting dir                → gtrouble
  gen feat         [name]    Create feature dir                        → gfeat
  gen project      [name]    Create project structure                  → gproject
  gen doc          [type] [name]  Generate doc from template           → gdoc

DOCS
  doc              <name>    View doc (cbash doc|docs <name>)
  docs list                  List documents
  docs edit        <name>    Edit document

CHEAT
  cheat            <name>    View cheatsheet                           → ch
  cheat list                  List cheatsheets                         → chlist
  cheat setup                 Download community cheatsheets           → chsetup

AI
  ai                         Show help
  ai chat          [model]   Chat with AI (Ollama)                     → chat, aichat
  ai list                    List Ollama models                        → ailist
  ai pull          <model>   Pull model                                → aipull

MACOS / MISC
  macos / misc               Show help
  macos lock                 Lock screen                               → mlock
  macos ports                List listening ports                      → mports
  macos update               Update Homebrew, npm, pip                 → mupdate
  macos myip                 Public IP (fallbacks)

PROXY
  proxy enable     [url]     Enable proxy (env, npm, git)              → proxon
  proxy disable              Disable proxy                             → proxoff
  proxy show                 Show proxy settings                       → proxshow

QUICK REFERENCE (ALIAS → SECTION)
  scheck, sbrew, sws, sdot                Setup
  start, stop, devlogs, devkill           Dev
  commit, auto_squash                     Git
  d, dps, dr, drm, dlo                    Docker
  gfeat, gtrouble, gws, gproject, gdoc    Gen
  awsssh, awssqscreate, awsssmget         AWS
  k8pods, k8logs, k8exec, k8cheat         K8s
  ch, chlist, chsetup                     Cheat
  chat, aichat, ailist                    AI
  mlock, mip, mports, mupdate, minfo      MacOS
  proxon, proxoff, proxshow               Proxy

Run cbash <plugin> or cbash <plugin> help for detailed help.
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
