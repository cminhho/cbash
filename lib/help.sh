#!/usr/bin/env bash
# CBASH Help - Display help and command reference

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

help_show() {
    printf "${bldwht}CBASH CLI${clr} ${bldcyn}(%s)${clr} – macOS command line tools for developers\n\n" "${CBASH_VERSION:-1.0}"
    printf "${bldwht}USAGE${clr}\n"
    printf "  cbash [COMMAND] [SUBCOMMAND] [OPTIONS]\n"

    _h_title "Setup"
    _h_cmd "setup"            ""              "Show help"
    _h_cmd "setup check"      ""              "Check dev environment"                    "scheck"
    _h_cmd "setup brew"       "[group]"       "Install tools (dev|cloud|ide|apps|all)"   "sbrew"
    _h_cmd "setup workspace"  "[name]"        "Create workspace structure"               "sws"

    _h_title "Aliases"
    _h_cmd "aliases"          ""              "Show help"
    _h_cmd "aliases list"     ""              "List alias files"
    _h_cmd "aliases show"     "<name>"        "Show aliases in file"
    _h_cmd "aliases edit"     "<name>"        "Edit alias file"
    _h_cmd "aliases load"     ""              "Load all aliases"

    _h_title "Git"
    _h_cmd "git"              ""              "Show help (aliases: g, gst, gco, ...)"
    _h_cmd "git config"       ""              "Show git config"
    _h_cmd "git log"          ""              "Recent commits"
    _h_cmd "git branches"     ""              "List branches with dates"
    _h_cmd "git branch"       "<name>"        "Create branch from master"
    _h_cmd "git rename"       "<name>"        "Rename current branch"
    _h_cmd "git undo"         ""              "Undo last commit (soft)"
    _h_cmd "git backup"       ""              "Quick commit and push"
    _h_cmd "git auto-commit"  ""              "Auto commit and push"
    _h_cmd "git squash"       ""              "Squash commits interactively"
    _h_cmd "git auto-squash"  ""              "Squash feature branch"
    _h_cmd "git pull-all"     "[dir]"         "Pull all repos in directory"
    _h_cmd "git clone-all"    "<file> [dir]"  "Clone repos from file"
    _h_cmd "git for"          "\"<cmd>\""     "Run command in every repo"
    _h_cmd "git clean"        ""              "Clean and optimize repo"
    _h_cmd "git size"         ""              "Show repo size"
    _h_cmd "git sync"         ""              "Fetch and pull"
    _h_cmd "git open"         ""              "Open repo in browser"

    _h_title "Development"
    _h_cmd "dev"              ""              "Show help"
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
    _h_cmd "docker"           ""              "Show help (aliases: d, dps, dr, ...)"
    _h_cmd "docker list"      ""              "List Docker aliases"
    _h_cmd "docker running"   ""              "List running containers"
    _h_cmd "docker stop-all"  ""              "Stop all containers"
    _h_cmd "docker remove-stopped" ""         "Remove stopped containers"
    _h_cmd "docker prune-images" ""           "Remove unused images"
    _h_cmd "docker kill-all"  ""              "Stop, remove all and volumes"

    _h_title "Maven"
    _h_cmd "mvn"              ""              "Maven wrapper + aliases (mci, build, ...)"
    _h_cmd "mvn list"         ""              "List Maven aliases"

    _h_title "npm"
    _h_cmd "npm"              ""              "npm/npx aliases (ni, nr, nx, ...)"
    _h_cmd "npm list"         ""              "List npm/npx aliases"

    _h_title "AWS"
    _h_cmd "aws"              ""              "Show help"
    _h_cmd "aws ssh"          "<profile> <env>" "Connect to SSH gateway (SSM)"           "awsssh"
    _h_cmd "aws sqs-create"   ""              "Create SQS queue (localstack)"            "awssqscreate"
    _h_cmd "aws sqs-test"     ""              "Test SQS (localstack)"                    "awssqstest"
    _h_cmd "aws ssm-get"      ""              "Get SSM parameter"                        "awsssmget"

    _h_title "Kubernetes (k8s)"
    _h_cmd "k8s"              ""              "Show help"
    _h_cmd "k8s pods"         "[opts]"        "List pods"                                "k8pods"
    _h_cmd "k8s logs"         "<pod>"         "Follow pod logs"                          "k8logs"
    _h_cmd "k8s desc"         "<pod>"         "Describe pod"                             "k8desc"
    _h_cmd "k8s exec"         "<pod>"         "Shell into pod"                           "k8exec"
    _h_cmd "k8s restart"      "<deploy>"      "Rollout restart deployment"               "k8restart"
    _h_cmd "k8s cheat"        "[pod]"         "Show kubectl commands"                    "k8cheat"

    _h_title "Generators (gen)"
    _h_cmd "gen"              ""              "Show help"
    _h_cmd "gen trouble"      "[name]"        "Create troubleshooting dir"               "gtrouble"
    _h_cmd "gen feat"         "[name]"        "Create feature dir"                       "gfeat"
    _h_cmd "gen workspace"    "[name]"        "Create workspace structure"               "gws"
    _h_cmd "gen project"      "[name]"        "Create project structure"                 "gproject"
    _h_cmd "gen doc"          "[type] [name]" "Generate doc from template"               "gdoc"

    _h_title "Docs & Cheat"
    _h_cmd "docs"             ""              "Show help"                                "doc"
    _h_cmd "docs <name>"      ""              "View document"
    _h_cmd "docs list"        ""              "List documents"
    _h_cmd "docs edit"        "<name>"        "Edit document"
    _h_cmd "docs cheat"       "<name>"        "View cheatsheet"                          "ch"
    _h_cmd "docs cheat-list"  ""              "List cheatsheets"                         "chlist"
    _h_cmd "docs cheat-setup" ""              "Download community cheatsheets"           "chsetup"
    _h_cmd "docs cheat-edit"  "<name>"        "Edit personal cheatsheet"                 "chedit"
    _h_cmd "docs conf"        ""              "Show configuration"

    _h_title "AI"
    _h_cmd "ai"               ""              "Show help"
    _h_cmd "ai chat"          "[model]"       "Chat with AI (Ollama)"                    "chat, aichat"
    _h_cmd "ai list"          ""              "List Ollama models"                       "ailist"
    _h_cmd "ai pull"          "<model>"       "Pull model"                               "aipull"

    _h_title "MacOS / misc"
    _h_cmd "macos"            ""              "Show help"
    _h_cmd "macos info"       ""              "macOS version"                            "minfo"
    _h_cmd "macos lock"       ""              "Lock screen"                              "mlock"
    _h_cmd "macos speedtest"  ""              "Internet speed"                           "mspeedtest"
    _h_cmd "macos memory"     ""              "Processes by memory"                      "mmemory"
    _h_cmd "macos ports"      ""              "List listening ports"                     "mports"
    _h_cmd "macos ip-local"   ""              "Local IP"                                 "mip"
    _h_cmd "macos ip-public"  ""              "Public IP"                                "mipublic"
    _h_cmd "macos update"     ""              "Update Homebrew, npm, pip"                "mupdate"
    _h_cmd "macos passgen"    "[n]"           "Random password (n words)"
    _h_cmd "macos list"       ""              "List macos aliases"

    _h_title "Proxy"
    _h_cmd "proxy"            ""              "Show help"
    _h_cmd "proxy enable"     "[url]"         "Enable proxy (env, npm, git)"             "proxon"
    _h_cmd "proxy disable"    ""              "Disable proxy"                            "proxoff"
    _h_cmd "proxy show"       ""              "Show proxy settings"                      "proxshow"

    _h_title "Quick reference (alias → section)"
    _h_quick "scheck, sbrew, sws"                      "Setup"
    _h_quick "start, stop, devlogs, devkill"           "Dev"
    _h_quick "g, gst, gco, gp, gpush"                  "Git"
    _h_quick "d, dps, dr, drm, dlo"                    "Docker"
    _h_quick "gfeat, gtrouble, gws, gproject, gdoc"    "Gen"
    _h_quick "awsssh, awssqscreate, awsssmget"         "AWS"
    _h_quick "k8pods, k8logs, k8exec, k8cheat"         "K8s"
    _h_quick "doc, ch, chlist, chsetup, chedit"        "Docs"
    _h_quick "chat, aichat, ailist"                    "AI"
    _h_quick "mlock, mip, mports, mupdate, minfo"      "MacOS"
    _h_quick "proxon, proxoff, proxshow"               "Proxy"

    echo ""
    echo -e "Run ${bldblu}cbash <plugin>${clr} or ${bldblu}cbash <plugin> help${clr} for detailed help."
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && help_show
