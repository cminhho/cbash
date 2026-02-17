#!/usr/bin/env bash
# Dev plugin for CBASH
# Docker Compose development environment management

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# Configuration
readonly COMPOSE_FILE="$CBASH_DIR/plugins/dev/development.yml"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias start='dev_start'
alias stop='dev_stop'
alias restart='dev_restart'
alias devreload='dev_reload'
alias devstatus='dev_status'
alias devlist='dev_list'
alias devlogs='dev_logs'
alias devexec='dev_exec'
alias devstats='dev_stats'
alias devip='dev_ip'
alias devkill='dev_kill_all'

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_dev_check_docker() {
    command -v docker &>/dev/null || { log_error "Docker not installed"; return 1; }
    docker info &>/dev/null || {
        log_info "Starting Docker..."
        open -a Docker 2>/dev/null
        for i in {1..30}; do
            docker info &>/dev/null && return 0
            sleep 1
        done
        log_error "Docker failed to start"
        return 1
    }
}

_dev_compose() {
    _dev_check_docker || return 1
    [[ -f "$COMPOSE_FILE" ]] || { log_error "Compose file not found: $COMPOSE_FILE"; return 1; }
    docker compose -f "$COMPOSE_FILE" "$@"
}

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

dev_start() {
    _dev_compose up -d "$@"
}

dev_stop() {
    _dev_compose stop "$@"
}

dev_restart() {
    _dev_compose restart "$@"
}

dev_reload() {
    _dev_compose up -d --force-recreate "$@"
}

dev_status() {
    _dev_compose ps
}

dev_list() {
    _dev_compose config --services
}

dev_logs() {
    _dev_compose logs --tail=100 -f "$@"
}

dev_exec() {
    local service="$1"
    [[ -z "$service" ]] && { log_error "Usage: dev exec <service> [cmd]"; return 1; }
    shift
    _dev_compose exec "$service" "${@:-/bin/sh}"
}

dev_stats() {
    _dev_check_docker || return 1
    local containers
    containers=$(docker ps -q)
    [[ -z "$containers" ]] && { log_info "No running containers"; return 0; }
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"
}

dev_ip() {
    _dev_check_docker || return 1
    local containers
    containers=$(_dev_compose ps -q 2>/dev/null)
    [[ -z "$containers" ]] && { log_info "No running containers"; return 0; }

    for c in $containers; do
        local name networks
        name=$(docker inspect -f '{{.Name}}' "$c" | sed 's/^\///')
        networks=$(docker inspect -f '{{range $n, $conf := .NetworkSettings.Networks}}{{$n}}:{{$conf.IPAddress}} {{end}}' "$c")
        echo "$name: $networks"
    done
}

dev_kill_all() {
    _dev_check_docker || return 1
    log_info "Stopping all containers..."
    docker stop $(docker ps -q) 2>/dev/null
    docker rm $(docker ps -aq) 2>/dev/null
    docker volume rm $(docker volume ls -q) 2>/dev/null
    log_success "Cleaned all containers and volumes"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

dev_help() {
    _describe command 'dev' \
        'start [svc]     Start services' \
        'stop [svc]      Stop services' \
        'restart [svc]   Restart services' \
        'reload [svc]    Recreate services' \
        'status          Show service status' \
        'list            List services' \
        'aliases         List dev aliases' \
        'logs [svc]      Follow logs' \
        'exec <svc>      Shell into service' \
        'stats           Container stats' \
        'ip              Show container IPs' \
        'kill-all        Remove all containers' \
        'Docker Compose dev environment'
}

dev_list_aliases() {
    echo "Dev aliases: start, stop, restart, devreload, devstatus, devlist, devlogs, devexec, devstats, devip, devkill"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") dev_help ;;
        list)              dev_list ;;
        aliases)           dev_list_aliases ;;
        start)             shift; dev_start "$@" ;;
        stop)              shift; dev_stop "$@" ;;
        restart)           shift; dev_restart "$@" ;;
        reload)            shift; dev_reload "$@" ;;
        status)            dev_status ;;
        logs)              shift; dev_logs "$@" ;;
        exec)              shift; dev_exec "$@" ;;
        stats)             dev_stats ;;
        ip)                dev_ip ;;
        kill-all)          dev_kill_all ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
