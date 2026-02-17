# CBASH CLI

🚀 Command-line tools for developers (macOS/Linux). Automate tasks, manage git repos, run dev services, and use helpers for AWS, K8s, and docs.

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

## Quick Install

**via Homebrew (macOS):**
```bash
brew install cminhho/tap/cbash-cli
```

**via curl:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
```

**via wget:**
```bash
sh -c "$(wget -qO- https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
```

## Requirements

- Unix-like OS (macOS, Linux, WSL2)
- Bash 4.0+ or Zsh
- Git, curl or wget

## What Gets Installed

- **Homebrew:** `cbash` on PATH, aliases optional via `source "$(brew --prefix cbash-cli)/libexec/cbash.sh"`
- **curl/wget:** `~/.cbash/`, auto-updates shell config

Restart terminal and run `cbash` for help.

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
CBASH CLI (1.0) – macOS command line tools for developers

USAGE
  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]

SETUP
  setup                                 Show help
  setup check                           Check dev environment  → scheck
  setup brew             [group]        Install tools (dev|cloud|ide|apps|all)  → sbrew
  setup workspace        [name]         Create workspace structure  → sws

ALIASES
  aliases                               Show help
  aliases list                          List alias files
  aliases show           <name>         Show aliases in file
  aliases edit           <name>         Edit alias file
  aliases load                          Load all aliases

GIT
  git                                   Show help (aliases: g, gst, gco, ...)
  git config                            Show git config
  git log                               Recent commits
  git branches                          List branches with dates
  git branch             <name>         Create branch from master
  git rename             <name>         Rename current branch
  git undo                              Undo last commit (soft)
  git backup                            Quick commit and push
  git auto-commit                       Auto commit and push
  git squash                            Squash commits interactively
  git auto-squash                       Squash feature branch
  git pull-all           [dir]          Pull all repos in directory
  git clone-all          <file> [dir]   Clone repos from file
  git for                "<cmd>"        Run command in every repo
  git clean                             Clean and optimize repo
  git size                              Show repo size
  git sync                              Fetch and pull
  git open                              Open repo in browser

DEVELOPMENT
  dev                                   Show help
  dev start              [svc]          Start Docker services  → start
  dev stop               [svc]          Stop services  → stop
  dev restart            [svc]          Restart services  → restart
  dev reload             [svc]          Recreate and start  → devreload
  dev status                            Service status  → devstatus
  dev list                              List services  → devlist
  dev logs               [svc]          Follow logs  → devlogs
  dev exec               <svc>          Shell into service  → devexec
  dev stats                             Container stats  → devstats
  dev ip                                Container IPs  → devip
  dev kill-all                          Stop and remove all  → devkill

DOCKER
  docker                                Show help (aliases: d, dps, dr, ...)
  docker list                           List Docker aliases
  docker running                        List running containers
  docker stop-all                       Stop all containers
  docker remove-stopped                 Remove stopped containers
  docker prune-images                   Remove unused images
  docker kill-all                       Stop, remove all and volumes

MAVEN
  mvn                                   Maven wrapper + aliases (mci, build, ...)
  mvn list                              List Maven aliases

NPM
  npm                                   npm/npx aliases (ni, nr, nx, ...)
  npm list                              List npm/npx aliases

AWS
  aws                                   Show help
  aws ssh                <profile> <env> Connect to SSH gateway (SSM)  → awsssh
  aws sqs-create                        Create SQS queue (localstack)  → awssqscreate
  aws sqs-test                          Test SQS (localstack)  → awssqstest
  aws ssm-get                           Get SSM parameter  → awsssmget

KUBERNETES (K8S)
  k8s                                   Show help
  k8s pods               [opts]         List pods  → k8pods
  k8s logs               <pod>          Follow pod logs  → k8logs
  k8s desc               <pod>          Describe pod  → k8desc
  k8s exec               <pod>          Shell into pod  → k8exec
  k8s restart            <deploy>       Rollout restart deployment  → k8restart
  k8s cheat              [pod]          Show kubectl commands  → k8cheat

GENERATORS (GEN)
  gen                                   Show help
  gen trouble            [name]         Create troubleshooting dir  → gtrouble
  gen feat               [name]         Create feature dir  → gfeat
  gen workspace          [name]         Create workspace structure  → gws
  gen project            [name]         Create project structure  → gproject
  gen doc                [type] [name]  Generate doc from template  → gdoc

DOCS & CHEAT
  docs                                  Show help  → doc
  docs <name>                           View document
  docs list                             List documents
  docs edit              <name>         Edit document
  docs cheat             <name>         View cheatsheet  → ch
  docs cheat-list                       List cheatsheets  → chlist
  docs cheat-setup                      Download community cheatsheets  → chsetup
  docs cheat-edit        <name>         Edit personal cheatsheet  → chedit
  docs conf                             Show configuration

AI
  ai                                    Show help
  ai chat                [model]        Chat with AI (Ollama)  → chat, aichat
  ai list                               List Ollama models  → ailist
  ai pull                <model>        Pull model  → aipull

MACOS
  macos                                 Show help
  macos info                            macOS version  → minfo
  macos lock                            Lock screen  → mlock
  macos speedtest                       Internet speed  → mspeedtest
  macos memory                          Processes by memory  → mmemory
  macos ports                           List listening ports  → mports
  macos ip-local                        Local IP  → mip
  macos ip-public                       Public IP  → mipublic
  macos update                          Update Homebrew, npm, pip  → mupdate
  macos passgen          [n]            Random password (n words)
  macos list                            List macos aliases

PROXY
  proxy                                 Show help
  proxy enable           [url]          Enable proxy (env, npm, git)  → proxon
  proxy disable                         Disable proxy  → proxoff
  proxy show                            Show proxy settings  → proxshow

QUICK REFERENCE (ALIAS → SECTION)
  scheck, sbrew, sws                    Setup
  start, stop, devlogs, devkill         Dev
  g, gst, gco, gp, gpush                Git
  d, dps, dr, drm, dlo                  Docker
  gfeat, gtrouble, gws, gproject, gdoc  Gen
  awsssh, awssqscreate, awsssmget       AWS
  k8pods, k8logs, k8exec, k8cheat       K8s
  doc, ch, chlist, chsetup, chedit      Docs
  chat, aichat, ailist                  AI
  mlock, mip, mports, mupdate, minfo    MacOS
  proxon, proxoff, proxshow             Proxy

Run cbash <plugin> or cbash <plugin> help for detailed help.
```

## Upgrade & Uninstall

**Homebrew:**
```bash
brew upgrade cbash-cli    # upgrade
brew uninstall cbash-cli  # uninstall
```

**curl/wget install:**
```bash
# Upgrade
cbash cli update
# or
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/upgrade.sh)"

# Uninstall
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/uninstall.sh)"
```

## Support the project

If CBASH CLI is useful to you:

[![GitHub Sponsors](https://img.shields.io/github/sponsors/cminhho?logo=githubsponsors&style=flat-square)](https://github.com/sponsors/cminhho)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=flat-square&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/chungho)

## License

MIT — see [LICENSE](LICENSE).
