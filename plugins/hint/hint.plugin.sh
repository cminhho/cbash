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

# Helpers
_title() { printf "\n${BLD}%s${RST}\n" "$(echo "$1" | tr '[:lower:]' '[:upper:]')"; }
_cmd() {
    if [[ -n "$4" ]]; then
        printf "  ${BLU}%-22s${RST} ${GRN}%-14s${RST} %s  ${DIM}→ %s${RST}\n" "$1" "$2" "$3" "$4"
    else
        printf "  ${BLU}%-22s${RST} ${GRN}%-14s${RST} %s\n" "$1" "$2" "$3"
    fi
}
_quick() { printf "  ${GRN}%-28s${RST} %s\n" "$1" "$2"; }

hint_show() {
    printf "${BLD}CBASH CLI${RST} ${CYN}(%s)${RST} – macOS command line tools for developers\n\n" "${CBASH_VERSION:-1.0}"
    printf "${BLD}USAGE${RST}\n"
    printf "  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]\n"

    _title "Setup"
    _cmd "setup"            ""              "Show help"
    _cmd "setup check"      ""              "Check dev environment"                    "scheck"
    _cmd "setup brew"       "[group]"       "Install tools (dev|cloud|ide|apps|all)"   "sbrew"
    _cmd "setup workspace"  "[name]"        "Create workspace structure"               "sws"

    _title "Aliases"
    _cmd "aliases"          ""              "Show help"
    _cmd "aliases list"     ""              "List alias files"
    _cmd "aliases show"     "<name>"        "Show aliases in file"
    _cmd "aliases edit"     "<name>"        "Edit alias file"
    _cmd "aliases load"     ""              "Load all aliases"

    _title "Git"
    _cmd "git"              ""              "Show help (aliases: g, gst, gco, ...)"
    _cmd "git config"       ""              "Show git config"
    _cmd "git log"          ""              "Recent commits"
    _cmd "git branches"     ""              "List branches with dates"
    _cmd "git branch"       "<name>"        "Create branch from master"
    _cmd "git rename"       "<name>"        "Rename current branch"
    _cmd "git undo"         ""              "Undo last commit (soft)"
    _cmd "git backup"       ""              "Quick commit and push"
    _cmd "git auto-commit"  ""              "Auto commit and push"
    _cmd "git squash"       ""              "Squash commits interactively"
    _cmd "git auto-squash"  ""              "Squash feature branch"
    _cmd "git pull-all"     "[dir]"         "Pull all repos in directory"
    _cmd "git clone-all"    "<file> [dir]"  "Clone repos from file"
    _cmd "git for"          "\"<cmd>\""     "Run command in every repo"
    _cmd "git clean"        ""              "Clean and optimize repo"
    _cmd "git size"         ""              "Show repo size"
    _cmd "git sync"         ""              "Fetch and pull"
    _cmd "git open"         ""              "Open repo in browser"

    _title "Development"
    _cmd "dev"              ""              "Show help"
    _cmd "dev start"        "[svc]"         "Start Docker services"                    "start"
    _cmd "dev stop"         "[svc]"         "Stop services"                            "stop"
    _cmd "dev restart"      "[svc]"         "Restart services"                         "restart"
    _cmd "dev reload"       "[svc]"         "Recreate and start"                       "devreload"
    _cmd "dev status"       ""              "Service status"                           "devstatus"
    _cmd "dev list"         ""              "List services"                            "devlist"
    _cmd "dev logs"         "[svc]"         "Follow logs"                              "devlogs"
    _cmd "dev exec"         "<svc>"         "Shell into service"                       "devexec"
    _cmd "dev stats"        ""              "Container stats"                          "devstats"
    _cmd "dev ip"           ""              "Container IPs"                            "devip"
    _cmd "dev kill-all"     ""              "Stop and remove all"                      "devkill"

    _title "Docker"
    _cmd "docker"           ""              "Show help (aliases: d, dps, dr, ...)"
    _cmd "docker list"      ""              "List Docker aliases"
    _cmd "docker running"   ""              "List running containers"
    _cmd "docker stop-all"  ""              "Stop all containers"
    _cmd "docker remove-stopped" ""         "Remove stopped containers"
    _cmd "docker prune-images" ""           "Remove unused images"
    _cmd "docker kill-all"  ""              "Stop, remove all and volumes"

    _title "Maven"
    _cmd "mvn"              ""              "Maven wrapper + aliases (mci, build, ...)"
    _cmd "mvn list"         ""              "List Maven aliases"

    _title "npm"
    _cmd "npm"              ""              "npm/npx aliases (ni, nr, nx, ...)"
    _cmd "npm list"         ""              "List npm/npx aliases"

    _title "AWS"
    _cmd "aws"              ""              "Show help"
    _cmd "aws ssh"          "<profile> <env>" "Connect to SSH gateway (SSM)"           "awsssh"
    _cmd "aws sqs-create"   ""              "Create SQS queue (localstack)"            "awssqscreate"
    _cmd "aws sqs-test"     ""              "Test SQS (localstack)"                    "awssqstest"
    _cmd "aws ssm-get"      ""              "Get SSM parameter"                        "awsssmget"

    _title "Kubernetes (k8s)"
    _cmd "k8s"              ""              "Show help"
    _cmd "k8s pods"         "[opts]"        "List pods"                                "k8pods"
    _cmd "k8s logs"         "<pod>"         "Follow pod logs"                          "k8logs"
    _cmd "k8s desc"         "<pod>"         "Describe pod"                             "k8desc"
    _cmd "k8s exec"         "<pod>"         "Shell into pod"                           "k8exec"
    _cmd "k8s restart"      "<deploy>"      "Rollout restart deployment"               "k8restart"
    _cmd "k8s cheat"        "[pod]"         "Show kubectl commands"                    "k8cheat"

    _title "Generators (gen)"
    _cmd "gen"              ""              "Show help"
    _cmd "gen trouble"      "[name]"        "Create troubleshooting dir"               "gtrouble"
    _cmd "gen feat"         "[name]"        "Create feature dir"                       "gfeat"
    _cmd "gen workspace"    "[name]"        "Create workspace structure"               "gws"
    _cmd "gen project"      "[name]"        "Create project structure"                 "gproject"
    _cmd "gen doc"          "[type] [name]" "Generate doc from template"               "gdoc"

    _title "Docs"
    _cmd "doc"              "<name>"        "View doc (cbash doc|docs <name>)"
    _cmd "docs"             ""              "Show help"
    _cmd "docs list"        ""              "List documents"
    _cmd "docs edit"        "<name>"        "Edit document"
    _cmd "docs conf"        ""              "Show docs config"

    _title "Cheat"
    _cmd "cheat"            "<name>"        "View cheatsheet"                          "ch"
    _cmd "cheat list"       ""              "List cheatsheets"                         "chlist"
    _cmd "cheat setup"      ""              "Download community cheatsheets"           "chsetup"
    _cmd "cheat edit"       "<name>"        "Edit personal cheatsheet"                 "chedit"
    _cmd "cheat conf"       ""              "Show cheat config"                        "chconf"

    _title "AI"
    _cmd "ai"               ""              "Show help"
    _cmd "ai chat"          "[model]"       "Chat with AI (Ollama)"                    "chat, aichat"
    _cmd "ai list"          ""              "List Ollama models"                       "ailist"
    _cmd "ai pull"          "<model>"       "Pull model"                               "aipull"

    _title "MacOS / misc"
    _cmd "macos"            ""              "Show help"
    _cmd "macos info"       ""              "macOS version"                            "minfo"
    _cmd "macos lock"       ""              "Lock screen"                              "mlock"
    _cmd "macos speedtest"  ""              "Internet speed"                           "mspeedtest"
    _cmd "macos memory"     ""              "Processes by memory"                      "mmemory"
    _cmd "macos ports"      ""              "List listening ports"                     "mports"
    _cmd "macos ip-local"   ""              "Local IP"                                 "mip"
    _cmd "macos ip-public"  ""              "Public IP"                                "mipublic"
    _cmd "macos update"     ""              "Update Homebrew, npm, pip"                "mupdate"
    _cmd "macos passgen"    "[n]"           "Random password (n words)"
    _cmd "macos list"       ""              "List macos aliases"

    _title "Proxy"
    _cmd "proxy"            ""              "Show help"
    _cmd "proxy enable"     "[url]"         "Enable proxy (env, npm, git)"             "proxon"
    _cmd "proxy disable"    ""              "Disable proxy"                            "proxoff"
    _cmd "proxy show"       ""              "Show proxy settings"                      "proxshow"

    _title "Quick reference (alias → section)"
    _quick "scheck, sbrew, sws"                      "Setup"
    _quick "start, stop, devlogs, devkill"           "Dev"
    _quick "commit, auto_squash"                     "Git"
    _quick "d, dps, dr, drm, dlo"                    "Docker"
    _quick "gfeat, gtrouble, gws, gproject, gdoc"    "Gen"
    _quick "awsssh, awssqscreate, awsssmget"         "AWS"
    _quick "k8pods, k8logs, k8exec, k8cheat"         "K8s"
    _quick "ch, chlist, chsetup"                     "Cheat"
    _quick "chat, aichat, ailist"                    "AI"
    _quick "mlock, mip, mports, mupdate, minfo"      "MacOS"
    _quick "proxon, proxoff, proxshow"               "Proxy"

    echo ""
    echo -e "Run ${BLU}cbash <plugin>${RST} or ${BLU}cbash <plugin> help${RST} for detailed help."
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") hint_show ;;
        *)                 hint_show ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
