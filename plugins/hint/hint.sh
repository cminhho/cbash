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

title "Development"
cmd "dev start"     ""          "Start Docker services"
cmd "dev stop"      ""          "Stop Docker services"
cmd "dev restart"   ""          "Restart services"
cmd "dev logs"      "[service]" "View container logs"
cmd "dev exec"      "<service>" "Execute command in container"
cmd "dev status"    ""          "Show service status"
cmd "dev stats"     ""          "Show container resource usage"

title "Setup"
cmd "setup"           ""        "Mac Setup (aliases: scheck, sbrew, sws, sdot)"
cmd "setup check"     ""        "Check dev environment"
cmd "setup brew"      "[group]" "Install tools (dev|cloud|ide|apps|all)"
cmd "setup workspace" "[dir]"   "Create workspace structure"
cmd "setup dotfiles"  ""        "Import dotfiles"

title "Git"
cmd "git"             ""        "Git plugin (aliases: g, gst, gco, commit, auto_squash, ...)"
cmd "git squash"      ""        "Squash commits interactively"
cmd "git auto-commit" ""       "Auto commit and push changes"
cmd "git open"        ""        "Open repo in browser"
cmd "git sync"        ""        "Pull latest changes"
cmd "git branches"    ""        "List branches with dates"

title "AWS"
cmd "aws login"  ""       "Login with Azure AD SSO"
cmd "aws keys"   ""       "Manage AWS credentials"
cmd "ssm"        "<env>"  "SSH to environment (sit|uat|prod)"

title "Generators"
cmd "gen"            ""       "Structure + doc (aliases: gfeat, gtrouble, gws, gproject, gdoc)"
cmd "gen feat"       "[name]" "Create feature directory"
cmd "gen trouble"    "[name]" "Create troubleshooting directory"
cmd "gen workspace"  "[name]" "Create workspace structure"
cmd "gen project"    "[name]" "Create project structure"
cmd "gen doc"        "[type]" "Generate doc from template (adr|meeting|design|cab|...)"

title "Utilities"
cmd "macos"          ""       "MacOS (aliases: mlock, mip, mports, mupdate, ...)"
cmd "misc"           ""       "Same as macos (ips, myip, passgen)"
cmd "macos update"   ""       "Update Homebrew, npm, pip"
cmd "macos ports"    ""       "List used ports"
cmd "macos ip-local" ""       "Get local IP"
cmd "macos ip-public" ""      "Get public IP"
cmd "docs"           "[cmd]"  "Docs: list, edit, view (cbash doc|docs)"
cmd "k8s"            "<pod>"  "Kubernetes helper"
cmd "cheat"          "<name>" "View cheatsheet"
cmd "ai chat"        ""       "Chat with AI"

title "Maven"
cmd "mvn"           ""       "Maven plugin (mvnw when present, aliases: mci, build, run)"
cmd "mvn list"      ""       "List Maven aliases"

title "npm"
cmd "npm"           ""       "npm/npx aliases (ni, nr, nx, nls, nt, ...)"
cmd "npm list"      ""       "List npm/npx aliases"

title "Docker"
cmd "docker"              ""       "Docker helpers and aliases (dps, dr, drm, ...)"
cmd "docker running"     ""       "List running containers"
cmd "docker stop-all"     ""       "Stop all containers"
cmd "docker kill-all"     ""       "Stop, remove containers and volumes"

title "Aliases"
cmd "aliases list"  ""       "List alias files"
cmd "aliases show"  "<name>" "Show aliases in file"
cmd "proxy enable"  "[url]"  "Enable proxy"
cmd "proxy disable" ""       "Disable proxy"

title "Quick Commands"
alias_cmd "start, stop, restart, devlogs" "Dev / Docker"
alias_cmd "scheck, sbrew, sws, sdot"      "Setup (check, brew, workspace, dotfiles)"
alias_cmd "gfeat, gtrouble, gws, gdoc"    "Gen (feat, trouble, workspace, doc)"
alias_cmd "sit, uat, prod"                "SSH to AWS"
alias_cmd "commit, auto_squash"           "Git"
alias_cmd "chat"                          "AI chat"

echo ""
echo -e "Run ${BLU}cbash <plugin>${RST} for detailed help on each plugin."