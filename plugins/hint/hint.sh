#!/usr/bin/env bash
# Hint plugin for CBASH
# Display help and command reference

# Colors
RST='\033[0m'
BLD='\033[1m'
GRN='\033[32m'
YLW='\033[33m'
BLU='\033[34m'
CYN='\033[36m'

# Helpers
title() { printf "\n${BLD}%s${RST}\n" "$(echo "$1" | tr '[:lower:]' '[:upper:]')"; }
cmd()   { printf "  ${BLU}%-18s${RST} ${GRN}%-10s${RST} %s\n" "$1" "$2" "$3"; }
alias_cmd() { printf "  ${GRN}%-25s${RST} %s\n" "$1" "$2"; }

printf "${BLD}CBASH CLI${RST} ${CYN}(%s)${RST} – macOS command line tools for developers\n\n" "${CBASH_VERSION:-1.0}"
printf "${BLD}USAGE${RST}\n"
printf "  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]\n"

title "Setup"
cmd "setup"          ""          "Setup plugin (aliases: scheck, sbrew, sws, sdot)"
cmd "setup check"   ""          "Check dev environment"
cmd "setup brew"    "[group]"   "Install tools (dev|cloud|ide|apps|all)"
cmd "setup workspace" "[dir]"   "Create workspace structure"
cmd "setup dotfiles" ""          "Import dotfiles"

title "Aliases"
cmd "aliases"        ""          "Aliases plugin"
cmd "aliases list"  ""          "List alias files"
cmd "aliases show"  "<name>"    "Show aliases in file"
cmd "aliases edit"  "<name>"    "Edit alias file"
cmd "aliases load"  ""          "Load all aliases"

title "Git"
cmd "git"            ""          "Git plugin (aliases: g, gst, gco, commit, auto_squash, ...)"
cmd "git config"    ""          "Show git config"
cmd "git log"       ""          "Recent commits"
cmd "git branches"  ""          "List branches with dates"
cmd "git branch"    "<name>"    "Create branch from master"
cmd "git rename"    "<name>"    "Rename current branch"
cmd "git undo"      ""          "Undo last commit (soft)"
cmd "git backup"    ""          "Quick commit and push"
cmd "git auto-commit" ""        "Auto commit and push"
cmd "git squash"    ""          "Squash commits interactively"
cmd "git auto-squash" ""       "Squash feature branch"
cmd "git pull-all"  "[dir]"     "Pull all repos in directory"
cmd "git clean"     ""          "Clean and optimize repo"
cmd "git size"      ""          "Show repo size"
cmd "git sync"      ""          "Fetch and pull"
cmd "git open"      ""          "Open repo in browser"
cmd "clone"         "<url>"     "Git clone (cbash clone)"
cmd "pull"          ""          "Git pull (cbash pull)"

title "Development"
cmd "dev"            ""          "Dev plugin (aliases: start, stop, devlogs, ...)"
cmd "dev start"      "[svc]"     "Start Docker services"
cmd "dev stop"       "[svc]"     "Stop services"
cmd "dev restart"    "[svc]"     "Restart services"
cmd "dev reload"     "[svc]"     "Recreate and start"
cmd "dev status"     ""          "Service status"
cmd "dev list"       ""          "List services"
cmd "dev logs"       "[svc]"     "Follow logs"
cmd "dev exec"       "<svc>"     "Shell into service"
cmd "dev stats"      ""          "Container stats"
cmd "dev ip"         ""          "Container IPs"
cmd "dev kill-all"   ""          "Stop and remove all"

title "Docker"
cmd "docker"         ""          "Docker plugin (aliases: dps, dr, drm, ...)"
cmd "docker list"    ""          "List Docker aliases"
cmd "docker running" ""         "List running containers"
cmd "docker stop-all" ""        "Stop all containers"
cmd "docker remove-stopped" ""  "Remove stopped containers"
cmd "docker prune-images" ""    "Remove unused images"
cmd "docker kill-all" ""        "Stop, remove all and volumes"

title "Maven"
cmd "mvn"            ""          "Maven plugin (mvnw when present; aliases: mci, build, run, ...)"
cmd "mvn list"       ""          "List Maven aliases"

title "npm"
cmd "npm"            ""          "npm plugin (aliases: ni, nr, nx, nls, nt, ...)"
cmd "npm list"       ""          "List npm/npx aliases"

title "AWS"
cmd "aws"            ""          "AWS plugin (aliases: awsssh, awssqscreate, ...)"
cmd "aws ssh"        "<profile> <env>" "Connect to SSH gateway (SSM)"
cmd "aws sqs-create" ""          "Create SQS queue (localstack)"
cmd "aws sqs-test"   ""          "Test SQS (localstack)"
cmd "aws ssm-get"    ""          "Get SSM parameter"

title "Kubernetes (k8s)"
cmd "k8s"            ""          "K8s plugin (aliases: k8pods, k8logs, k8exec, ...)"
cmd "k8s pods"      "[opts]"    "List pods"
cmd "k8s logs"      "<pod>"     "Follow pod logs"
cmd "k8s desc"      "<pod>"     "Describe pod"
cmd "k8s exec"      "<pod>"     "Shell into pod"
cmd "k8s restart"   "<deploy>"  "Rollout restart deployment"
cmd "k8s cheat"     "[pod]"     "Show kubectl commands"

title "Generators (gen)"
cmd "gen"            ""          "Gen plugin (aliases: gfeat, gtrouble, gws, gproject, gdoc)"
cmd "gen trouble"   "[name]"    "Create troubleshooting dir"
cmd "gen feat"      "[name]"    "Create feature dir"
cmd "gen workspace" "[name]"    "Create workspace structure"
cmd "gen project"   "[name]"    "Create project structure"
cmd "gen doc"       "[type] [name]" "Generate doc from template"

title "Docs"
cmd "doc"            "<name>"    "View doc (cbash doc|docs)"
cmd "docs"           ""          "Docs plugin"
cmd "docs list"     ""          "List documents"
cmd "docs edit"     "<name>"    "Edit document"
cmd "docs conf"     ""          "Show docs config"

title "Cheat"
cmd "cheat"          "<name>"    "View cheatsheet (or: cbash cheat <name>)"
cmd "cheat list"    ""          "List cheatsheets"
cmd "cheat setup"    ""          "Download community cheatsheets"
cmd "cheat edit"     "<name>"   "Edit personal cheatsheet"
cmd "cheat conf"     ""         "Show cheat config"

title "AI"
cmd "ai"             ""          "AI plugin (aliases: chat, aichat, ailist, aipull)"
cmd "ai chat"       "[model]"   "Chat with AI (Ollama)"
cmd "ai list"       ""          "List Ollama models"
cmd "ai pull"       "<model>"   "Pull model"

title "MacOS / misc"
cmd "macos"          ""          "MacOS plugin (aliases: mlock, mip, mports, mupdate, ...)"
cmd "misc"           ""          "Same as macos"
cmd "macos info"     ""          "macOS version"
cmd "macos lock"     ""          "Lock screen"
cmd "macos speedtest" ""         "Internet speed"
cmd "macos memory"   ""          "Processes by memory"
cmd "macos ports"    ""          "List listening ports"
cmd "macos ip-local" ""         "Local IP"
cmd "macos ip-public" ""        "Public IP"
cmd "macos update"   ""          "Update Homebrew, npm, pip"
cmd "macos ips"      ""          "All local IPs"
cmd "macos myip"     ""          "Public IP (fallbacks)"
cmd "macos passgen"  "[n]"       "Random password (n words)"
cmd "macos list"     ""          "List macos aliases"
cmd "macos users"    ""          "Logged-in users"
cmd "macos size"     "[path]"    "Directory size"
cmd "macos tree"     "[path]"    "Tree view"
cmd "macos clean-empty" ""       "Remove empty dirs"
cmd "macos find"     "<path> <name>" "Find files"
cmd "macos replace"  ""          "Find and replace in files"

title "Proxy"
cmd "proxy"          ""          "Proxy plugin (aliases: proxon, proxoff, proxshow)"
cmd "proxy enable"  "[url]"     "Enable proxy (env, npm, git)"
cmd "proxy disable" ""          "Disable proxy"
cmd "proxy show"    ""          "Show proxy settings"

title "Quick Commands"
alias_cmd "scheck, sbrew, sws, sdot"                "Setup"
alias_cmd "start, stop, restart, devlogs, devkill" "Dev"
alias_cmd "commit, auto_squash"                     "Git"
alias_cmd "dps, dr, drm, dlo"                       "Docker"
alias_cmd "gfeat, gtrouble, gws, gproject, gdoc"   "Gen"
alias_cmd "awsssh, awssqscreate, awsssmget"        "AWS"
alias_cmd "k8pods, k8logs, k8exec, k8cheat"        "K8s"
alias_cmd "ch, chlist, chsetup"                    "Cheat"
alias_cmd "chat, aichat, ailist"                   "AI"
alias_cmd "mlock, mip, mports, mupdate, minfo"     "MacOS"
alias_cmd "proxon, proxoff, proxshow"              "Proxy"

echo ""
echo -e "Run ${BLU}cbash <plugin>${RST} for detailed help on each plugin."