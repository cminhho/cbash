#!/usr/bin/env bash
# CBASH Help - Display help and command reference
# shellcheck disable=SC2154
# (SC2154: color vars from colors.sh, sourced at runtime)

source "$CBASH_DIR/lib/colors.sh"

# Helpers
_h_title() { printf "\n${bldwht}%s${clr}\n" "$(echo "$1" | tr '[:lower:]' '[:upper:]')"; }
_h_cmd() {
    if [[ -n "$4" ]]; then
        printf "  ${bldblu}%-22s${clr} ${txtgrn}%-14s${clr} %s  ${dim}→ %s${clr}\n" "$1" "$2" "$3" "$4"
    else
        printf "  ${bldblu}%-22s${clr} ${txtgrn}%-14s${clr} %s\n" "$1" "$2" "$3"
    fi
}
_h_quick() { printf "  ${txtgrn}%-28s${clr} %s\n" "$1" "$2"; }

help_show_full() {
    printf "${bldwht}CBASH CLI${clr} ${bldcyn}(%s)${clr} – macOS command line tools for developers\n\n" "${CBASH_VERSION:-1.0.0}"
    printf "${bldwht}USAGE${clr}\n"
    printf "  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]\n"

    _h_title "Onboard"
    _h_cmd "onboard"          ""              "Quick setup (check + workspace)"
    _h_cmd "onboard -i"       ""              "Interactive wizard"
    _h_cmd "onboard --force"  ""              "Re-run even if already done"
    _h_cmd "onboard --workspace-only" ""      "Only check + workspace"
    _h_cmd "onboard --tools-only" ""          "Only check + install dev tools"
    _h_cmd "onboard welcome"  ""              "Welcome and quick start"
    _h_cmd "onboard check"    ""              "Verify CBASH and env setup"
    _h_cmd "onboard guide"    ""              "Short usage guide"

    _h_title "Setup"
    _h_cmd "setup check"      ""              "Check dev environment"                    "scheck"
    _h_cmd "setup brew"       "[group]"       "Install tools (dev|cloud|ide|apps|all)"   "sbrew"
    _h_cmd "setup workspace"  "[name]"        "Create workspace structure"               "sws"

    _h_title "Aliases"
    _h_cmd "aliases list"     ""              "List alias files"
    _h_cmd "aliases show"     "<name>"        "Show aliases in file"
    _h_cmd "aliases edit"     "<name>"        "Edit alias file"
    _h_cmd "aliases load"     ""              "Load all aliases"

    _h_title "Git"
    _h_cmd "git auto-commit"  ""              "Auto commit and push"                     "commit"
    _h_cmd "git auto-squash"  ""              "Squash feature branch"                    "auto_squash"
    _h_cmd "git squash"       ""              "Squash commits interactively"             "squash"
    _h_cmd "git pull-all"     "[dir]"         "Pull all repos"                           "pull_all"
    _h_cmd "git clone-all"    "<file>"        "Clone repos from file"                    "clone_all"
    _h_cmd "git for"          "\"<cmd>\""     "Run command in all repos"                 "gitfor"
    _h_cmd "git branch"       "<name>"        "Create branch from master"
    _h_cmd "git rename"       "<name>"        "Rename current branch"
    _h_cmd "git undo"         ""              "Undo last commit"
    _h_cmd "git backup"       ""              "Quick commit and push"
    _h_cmd "git config"       ""              "Show git config"
    _h_cmd "git log"          ""              "Recent commits"
    _h_cmd "git branches"     ""              "List branches with dates"
    _h_cmd "git clean"        ""              "Clean and optimize repo"
    _h_cmd "git size"         ""              "Show repo size"
    _h_cmd "git sync"         ""              "Fetch and pull"                           "gitsync"
    _h_cmd "git open"         ""              "Open repo in browser"

    _h_title "Development"
    _h_cmd "dev start"        "[svc]"         "Start Docker services"                    "start"
    _h_cmd "dev stop"         "[svc]"         "Stop services"                            "stop"
    _h_cmd "dev restart"      "[svc]"         "Restart services"                         "restart"
    _h_cmd "dev reload"       "[svc]"         "Recreate and start"                       "devreload"
    _h_cmd "dev status"       ""              "Service status"                           "devstatus"
    _h_cmd "dev list"         ""              "List services"                            "devlist"
    _h_cmd "dev logs"         "[svc]"         "Follow logs"                              "devlogs"
    _h_cmd "dev exec"         "<svc>"         "Shell into service"                       "devexec"
    _h_cmd "dev stats"        ""              "Container stats"                          "devstats"
    _h_cmd "dev ip"           ""              "Container IPs"                            "devip"
    _h_cmd "dev kill-all"     ""              "Stop and remove all"                      "devkill"

    _h_title "Docker"
    _h_cmd "docker running"   ""              "List running containers"                  "dps"
    _h_cmd "docker stop-all"  ""              "Stop all containers"
    _h_cmd "docker remove-stopped" ""         "Remove stopped containers"
    _h_cmd "docker prune-images" ""           "Remove unused images"
    _h_cmd "docker kill-all"  ""              "Stop, remove all and volumes"

    _h_title "K8s"
    _h_cmd "k8s pods"         "[opts]"        "List pods"                                "k8pods"
    _h_cmd "k8s logs"         "<pod>"         "Follow pod logs"                          "k8logs"
    _h_cmd "k8s desc"         "<pod>"         "Describe pod"                             "k8desc"
    _h_cmd "k8s exec"         "<pod>"         "Shell into pod"                           "k8exec"
    _h_cmd "k8s restart"      "<deploy>"      "Rollout restart"                          "k8restart"
    _h_cmd "k8s cheat"        "[pod]"         "Show kubectl commands"                    "k8cheat"

    _h_title "AWS"
    _h_cmd "aws ssh"          "<profile>"     "Connect via SSM"                          "awsssh"
    _h_cmd "aws sqs-create"   ""              "Create SQS queue (localstack)"            "awssqscreate"
    _h_cmd "aws sqs-test"     ""              "Test SQS (localstack)"                    "awssqstest"
    _h_cmd "aws ssm-get"      ""              "Get SSM parameter"                        "awsssmget"

    _h_title "Generators"
    _h_cmd "gen feat"         "[name]"        "Create feature dir"                       "gfeat"
    _h_cmd "gen trouble"      "[name]"        "Create troubleshooting dir"               "gtrouble"
    _h_cmd "gen workspace"    "[name]"        "Create workspace structure"               "gws"
    _h_cmd "gen project"      "[name]"        "Create project structure"                 "gproject"
    _h_cmd "gen doc"          "[type]"        "Generate doc from template"               "gdoc"

    _h_title "Docs"
    _h_cmd "docs"             "<name>"        "View document"                            "doc"
    _h_cmd "docs list"        ""              "List documents"
    _h_cmd "docs edit"        "<name>"        "Edit document"

    _h_title "AI"
    _h_cmd "ai chat"          "[model]"       "Chat with AI (Ollama)"                    "chat"
    _h_cmd "ai list"          ""              "List Ollama models"                       "ailist"
    _h_cmd "ai pull"          "<model>"       "Pull model"                               "aipull"

    _h_title "MacOS"
    _h_cmd "macos info"       ""              "macOS version"                            "minfo"
    _h_cmd "macos lock"       ""              "Lock screen"                              "mlock"
    _h_cmd "macos speedtest"  ""              "Internet speed"                           "mspeedtest"
    _h_cmd "macos memory"     ""              "Processes by memory"                      "mmemory"
    _h_cmd "macos ports"      ""              "List listening ports"                     "mports"
    _h_cmd "macos ip-local"   ""              "Local IP"                                 "mip"
    _h_cmd "macos ip-public"  ""              "Public IP"                                "mipublic"
    _h_cmd "macos update"     ""              "Update Homebrew, npm, pip"                "mupdate"
    _h_cmd "macos passgen"    "[n]"           "Random password (n words)"

    _h_title "Proxy"
    _h_cmd "proxy enable"     "[url]"         "Enable proxy"                             "proxon"
    _h_cmd "proxy disable"    ""              "Disable proxy"                            "proxoff"
    _h_cmd "proxy show"       ""              "Show proxy settings"                      "proxshow"

    _h_title "Build Tools"
    _h_cmd "mvn"              ""              "Maven wrapper + aliases (mci, build, ...)"
    _h_cmd "npm"              ""              "npm/npx aliases (ni, nr, nx, ...)"

    echo ""
    echo -e "Run ${bldblu}cbash <plugin>${clr} or ${bldblu}cbash <plugin> help${clr} for detailed help."
}

help_show() {
    printf "${bldwht}CBASH CLI${clr} ${bldcyn}(%s)${clr} – macOS command line tools for developers\n\n" "${CBASH_VERSION:-1.0.0}"
    printf "${bldwht}USAGE${clr}\n"
    printf "  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]\n"

    _h_title "Git"
    _h_cmd "git auto-commit"  ""              "Auto commit and push"                     "commit"
    _h_cmd "git auto-squash"  ""              "Squash feature branch"                    "auto_squash"
    _h_cmd "git pull-all"     "[dir]"         "Pull all repos"                           "pull_all"
    _h_cmd "git clone-all"    "<file>"        "Clone repos from file"                    "clone_all"
    _h_cmd "git for"          "\"<cmd>\""     "Run command in all repos"                 "gitfor"
    _h_cmd "git branch"       "<name>"        "Create branch from master"
    _h_cmd "git undo"         ""              "Undo last commit"
    _h_cmd "git open"         ""              "Open repo in browser"

    _h_title "Development"
    _h_cmd "dev start"        "[svc]"         "Start Docker services"                    "start"
    _h_cmd "dev stop"         "[svc]"         "Stop services"                            "stop"
    _h_cmd "dev logs"         "[svc]"         "Follow logs"                              "devlogs"
    _h_cmd "dev exec"         "<svc>"         "Shell into service"                       "devexec"
    _h_cmd "dev kill-all"     ""              "Stop and remove all"                      "devkill"

    _h_title "Docker"
    _h_cmd "docker running"   ""              "List running containers"                  "dps"
    _h_cmd "docker stop-all"  ""              "Stop all containers"
    _h_cmd "docker kill-all"  ""              "Stop, remove all and volumes"

    _h_title "K8s"
    _h_cmd "k8s pods"         "[opts]"        "List pods"                                "k8pods"
    _h_cmd "k8s logs"         "<pod>"         "Follow pod logs"                          "k8logs"
    _h_cmd "k8s exec"         "<pod>"         "Shell into pod"                           "k8exec"
    _h_cmd "k8s restart"      "<deploy>"      "Rollout restart"                          "k8restart"

    _h_title "AWS"
    _h_cmd "aws ssh"          "<profile>"     "Connect via SSM"                          "awsssh"
    _h_cmd "aws ssm-get"      ""              "Get SSM parameter"                        "awsssmget"

    _h_title "Generators"
    _h_cmd "gen feat"         "[name]"        "Create feature dir"                       "gfeat"
    _h_cmd "gen project"      "[name]"        "Create project structure"                 "gproject"
    _h_cmd "gen doc"          "[type]"        "Generate doc from template"               "gdoc"

    _h_title "Docs"
    _h_cmd "docs"             "<name>"        "View document"                            "doc"

    _h_title "AI"
    _h_cmd "ai chat"          "[model]"       "Chat with AI (Ollama)"                    "chat"
    _h_cmd "ai pull"          "<model>"       "Pull model"                               "aipull"

    _h_title "MacOS"
    _h_cmd "macos ports"      ""              "List listening ports"                     "mports"
    _h_cmd "macos update"     ""              "Update Homebrew, npm, pip"                "mupdate"
    _h_cmd "macos lock"       ""              "Lock screen"                              "mlock"

    _h_title "Proxy"
    _h_cmd "proxy enable"     "[url]"         "Enable proxy"                             "proxon"
    _h_cmd "proxy disable"    ""              "Disable proxy"                            "proxoff"

    _h_title "More"
    _h_cmd "onboard"          ""              "Quick setup (check + workspace)"           "onboard"
    _h_cmd "onboard -i"       ""              "Interactive wizard"
    _h_cmd "onboard check"    ""              "Verify CBASH and env"
    _h_cmd "setup check"      ""              "Check dev environment"                    "scheck"
    _h_cmd "aliases list"     ""              "List all aliases"
    _h_cmd "mvn / npm"        ""              "Build tool aliases (mci, ni, nr, ...)"

    echo ""
    echo -e "Run ${bldblu}cbash --full${clr} for all commands, or ${bldblu}cbash <plugin> help${clr} for plugin help."
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && help_show
