#!/usr/bin/env bash
# Hint plugin for CBASH
# Display help and command reference

# Colors
RST='\033[0m'
BLD='\033[1m'
GRN='\033[32m'
BLU='\033[34m'
CYN='\033[36m'
DIM='\033[2m'

# Helpers: title, cmd( cmd, args, description [, alias] ), quick( aliases, section )
title() { printf "\n${BLD}%s${RST}\n" "$(echo "$1" | tr '[:lower:]' '[:upper:]')"; }
cmd() {
    if [[ -n "$4" ]]; then
        printf "  ${BLU}%-22s${RST} ${GRN}%-14s${RST} %s  ${DIM}→ %s${RST}\n" "$1" "$2" "$3" "$4"
    else
        printf "  ${BLU}%-22s${RST} ${GRN}%-14s${RST} %s\n" "$1" "$2" "$3"
    fi
}
quick() { printf "  ${GRN}%-28s${RST} %s\n" "$1" "$2"; }

printf "${BLD}CBASH CLI${RST} ${CYN}(%s)${RST} – macOS command line tools for developers\n\n" "${CBASH_VERSION:-1.0}"
printf "${BLD}USAGE${RST}\n"
printf "  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]\n"

# -----------------------------------------------------------------------------
# Setup
# -----------------------------------------------------------------------------
title "Setup"
cmd "setup"            ""              "Show help"
cmd "setup check"      ""              "Check dev environment"                    "scheck"
cmd "setup brew"       "[group]"       "Install tools (dev|cloud|ide|apps|all)"    "sbrew"
cmd "setup workspace"  "[dir]"         "Create workspace structure"               "sws"
cmd "setup dotfiles"   ""              "Import dotfiles"                           "sdot"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
title "Aliases"
cmd "aliases"          ""              "Show help"
cmd "aliases list"     ""              "List alias files"
cmd "aliases show"     "<name>"        "Show aliases in file"
cmd "aliases edit"     "<name>"        "Edit alias file"
cmd "aliases load"     ""              "Load all aliases"

# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------
title "Git"
cmd "git"              ""              "Show help (aliases: g, gst, gco, commit, …)"
cmd "git config"       ""              "Show git config"
cmd "git log"          ""              "Recent commits"
cmd "git branches"     ""              "List branches with dates"
cmd "git branch"       "<name>"        "Create branch from master"
cmd "git rename"       "<name>"        "Rename current branch"
cmd "git undo"         ""              "Undo last commit (soft)"
cmd "git backup"       ""              "Quick commit and push"
cmd "git auto-commit"  ""              "Auto commit and push"
cmd "git squash"      ""              "Squash commits interactively"
cmd "git auto-squash"  ""              "Squash feature branch"
cmd "git pull-all"     "[dir]"         "Pull all repos in directory"
cmd "git clean"        ""              "Clean and optimize repo"
cmd "git size"         ""              "Show repo size"
cmd "git sync"         ""              "Fetch and pull"
cmd "git open"         ""              "Open repo in browser"
cmd "clone"            "<url>"         "Git clone (cbash clone)"
cmd "pull"             ""              "Git pull (cbash pull)"

# -----------------------------------------------------------------------------
# Development
# -----------------------------------------------------------------------------
title "Development"
cmd "dev"              ""              "Show help"
cmd "dev start"        "[svc]"         "Start Docker services"                    "start"
cmd "dev stop"         "[svc]"         "Stop services"                            "stop"
cmd "dev restart"      "[svc]"         "Restart services"                         "restart"
cmd "dev reload"       "[svc]"         "Recreate and start"                       "devreload"
cmd "dev status"       ""              "Service status"                           "devstatus"
cmd "dev list"         ""              "List services"                            "devlist"
cmd "dev logs"         "[svc]"         "Follow logs"                              "devlogs"
cmd "dev exec"         "<svc>"         "Shell into service"                       "devexec"
cmd "dev stats"        ""              "Container stats"                          "devstats"
cmd "dev ip"           ""              "Container IPs"                            "devip"
cmd "dev kill-all"     ""              "Stop and remove all"                      "devkill"

# -----------------------------------------------------------------------------
# Docker
# -----------------------------------------------------------------------------
title "Docker"
cmd "docker"           ""              "Show help (aliases: d, dps, dr, drm, dlo, …)"
cmd "docker list"      ""              "List Docker aliases"
cmd "docker running"  ""              "List running containers"
cmd "docker stop-all"  ""              "Stop all containers"
cmd "docker remove-stopped" ""         "Remove stopped containers"
cmd "docker prune-images" ""           "Remove unused images"
cmd "docker kill-all"  ""              "Stop, remove all and volumes"

# -----------------------------------------------------------------------------
# Maven
# -----------------------------------------------------------------------------
title "Maven"
cmd "mvn"              ""              "Maven wrapper + aliases (mci, build, run, …)"
cmd "mvn list"         ""              "List Maven aliases"

# -----------------------------------------------------------------------------
# npm
# -----------------------------------------------------------------------------
title "npm"
cmd "npm"              ""              "npm/npx aliases (ni, nr, nx, nls, nt, …)"
cmd "npm list"         ""              "List npm/npx aliases"

# -----------------------------------------------------------------------------
# AWS
# -----------------------------------------------------------------------------
title "AWS"
cmd "aws"              ""              "Show help"
cmd "aws ssh"          "<profile> <env>" "Connect to SSH gateway (SSM)"            "awsssh"
cmd "aws sqs-create"   ""              "Create SQS queue (localstack)"            "awssqscreate"
cmd "aws sqs-test"     ""              "Test SQS (localstack)"                    "awssqstest"
cmd "aws ssm-get"      ""              "Get SSM parameter"                        "awsssmget"

# -----------------------------------------------------------------------------
# Kubernetes (k8s)
# -----------------------------------------------------------------------------
title "Kubernetes (k8s)"
cmd "k8s"              ""              "Show help"
cmd "k8s pods"         "[opts]"        "List pods"                               "k8pods"
cmd "k8s logs"         "<pod>"         "Follow pod logs"                          "k8logs"
cmd "k8s desc"         "<pod>"         "Describe pod"                            "k8desc"
cmd "k8s exec"         "<pod>"         "Shell into pod"                          "k8exec"
cmd "k8s restart"     "<deploy>"      "Rollout restart deployment"               "k8restart"
cmd "k8s cheat"        "[pod]"         "Show kubectl commands"                   "k8cheat"

# -----------------------------------------------------------------------------
# Generators (gen)
# -----------------------------------------------------------------------------
title "Generators (gen)"
cmd "gen"              ""              "Show help"
cmd "gen trouble"      "[name]"        "Create troubleshooting dir"               "gtrouble"
cmd "gen feat"         "[name]"        "Create feature dir"                       "gfeat"
cmd "gen workspace"    "[name]"        "Create workspace structure"               "gws"
cmd "gen project"      "[name]"        "Create project structure"                 "gproject"
cmd "gen doc"          "[type] [name]" "Generate doc from template"               "gdoc"

# -----------------------------------------------------------------------------
# Docs
# -----------------------------------------------------------------------------
title "Docs"
cmd "doc"              "<name>"        "View doc (cbash doc|docs <name>)"
cmd "docs"             ""              "Show help"
cmd "docs list"        ""              "List documents"
cmd "docs edit"        "<name>"        "Edit document"
cmd "docs conf"        ""              "Show docs config"

# -----------------------------------------------------------------------------
# Cheat
# -----------------------------------------------------------------------------
title "Cheat"
cmd "cheat"            "<name>"        "View cheatsheet"                         "ch"
cmd "cheat list"       ""              "List cheatsheets"                         "chlist"
cmd "cheat setup"      ""              "Download community cheatsheets"           "chsetup"
cmd "cheat edit"       "<name>"        "Edit personal cheatsheet"                 "chedit"
cmd "cheat conf"       ""              "Show cheat config"                       "chconf"

# -----------------------------------------------------------------------------
# AI
# -----------------------------------------------------------------------------
title "AI"
cmd "ai"               ""              "Show help"
cmd "ai chat"          "[model]"       "Chat with AI (Ollama)"                    "chat, aichat"
cmd "ai list"          ""              "List Ollama models"                      "ailist"
cmd "ai pull"          "<model>"       "Pull model"                             "aipull"

# -----------------------------------------------------------------------------
# MacOS / misc
# -----------------------------------------------------------------------------
title "MacOS / misc"
cmd "macos"            ""              "Show help"
cmd "misc"             ""              "Same as macos"
cmd "macos info"       ""              "macOS version"                           "minfo"
cmd "macos lock"       ""              "Lock screen"                             "mlock"
cmd "macos speedtest"  ""              "Internet speed"                          "mspeedtest"
cmd "macos memory"     ""              "Processes by memory"                     "mmemory"
cmd "macos ports"      ""              "List listening ports"                    "mports"
cmd "macos ip-local"   ""              "Local IP"                                "mip"
cmd "macos ip-public"   ""             "Public IP"                               "mipublic"
cmd "macos update"     ""              "Update Homebrew, npm, pip"               "mupdate"
cmd "macos ips"        ""              "All local IPs"
cmd "macos myip"       ""              "Public IP (fallbacks)"
cmd "macos passgen"    "[n]"           "Random password (n words)"
cmd "macos list"       ""              "List macos aliases"
cmd "macos users"      ""              "Logged-in users"                          "musers"
cmd "macos size"       "[path]"        "Directory size"                          "msize"
cmd "macos tree"       "[path]"        "Tree view"                                "mtree"
cmd "macos clean-empty" ""             "Remove empty dirs"                       "mcleanempty"
cmd "macos find"       "<path> <name>" "Find files"
cmd "macos replace"    ""              "Find and replace in files"

# -----------------------------------------------------------------------------
# Proxy
# -----------------------------------------------------------------------------
title "Proxy"
cmd "proxy"            ""              "Show help"
cmd "proxy enable"     "[url]"         "Enable proxy (env, npm, git)"             "proxon"
cmd "proxy disable"    ""              "Disable proxy"                            "proxoff"
cmd "proxy show"       ""              "Show proxy settings"                     "proxshow"

# -----------------------------------------------------------------------------
# Quick reference
# -----------------------------------------------------------------------------
title "Quick reference (alias → section)"
quick "scheck, sbrew, sws, sdot"                "Setup"
quick "start, stop, devlogs, devkill"           "Dev"
quick "commit, auto_squash"                     "Git"
quick "d, dps, dr, drm, dlo"                   "Docker"
quick "gfeat, gtrouble, gws, gproject, gdoc"   "Gen"
quick "awsssh, awssqscreate, awsssmget"        "AWS"
quick "k8pods, k8logs, k8exec, k8cheat"         "K8s"
quick "ch, chlist, chsetup"                    "Cheat"
quick "chat, aichat, ailist"                   "AI"
quick "mlock, mip, mports, mupdate, minfo"      "MacOS"
quick "proxon, proxoff, proxshow"              "Proxy"

echo ""
echo -e "Run ${BLU}cbash <plugin>${RST} or ${BLU}cbash <plugin> help${RST} for detailed help."
