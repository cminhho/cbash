#!/usr/bin/env bash
# Dev plugin for CBASH
# Docker Compose development environment management

source "$CBASH_DIR/lib/common.sh"

# Configuration
readonly COMPOSE_FILE="$CBASH_DIR/plugins/dev/development.yml"

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_dev_check_docker() {
    command -v docker &>/dev/null || { echo "Docker not installed"; return 1; }
    docker info &>/dev/null || {
        echo "Starting Docker..."
        open -a Docker 2>/dev/null
        for i in {1..30}; do
            docker info &>/dev/null && return 0
            sleep 1
        done
        echo "Docker failed to start"
        return 1
    }
}

_dev_compose() {
    _dev_check_docker || return 1
    [[ -f "$COMPOSE_FILE" ]] || { echo "Compose file not found: $COMPOSE_FILE"; return 1; }
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
    [[ -z "$service" ]] && { echo "Usage: dev exec <service> [cmd]"; return 1; }
    shift
    _dev_compose exec "$service" "${@:-/bin/sh}"
}

dev_stats() {
    _dev_check_docker || return 1
    local containers
    containers=$(docker ps -q)
    [[ -z "$containers" ]] && { echo "No running containers"; return 0; }
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"
}

dev_ip() {
    _dev_check_docker || return 1
    local containers
    containers=$(_dev_compose ps -q 2>/dev/null)
    [[ -z "$containers" ]] && { echo "No running containers"; return 0; }

    for c in $containers; do
        local name networks
        name=$(docker inspect -f '{{.Name}}' "$c" | sed 's/^\///')
        networks=$(docker inspect -f '{{range $n, $conf := .NetworkSettings.Networks}}{{$n}}:{{$conf.IPAddress}} {{end}}' "$c")
        echo "$name: $networks"
    done
}

dev_kill_all() {
    _dev_check_docker || return 1
    echo "Stopping all containers..."
    docker stop $(docker ps -q) 2>/dev/null
    docker rm $(docker ps -aq) 2>/dev/null
    docker volume rm $(docker volume ls -q) 2>/dev/null
    success "Cleaned all containers and volumes"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'dev' \
            'start [svc]     Start services' \
            'stop [svc]      Stop services' \
            'restart [svc]   Restart services' \
            'reload [svc]    Recreate services' \
            'status          Show service status' \
            'list            List services' \
            'logs [svc]      Follow logs' \
            'exec <svc>      Shell into service' \
            'stats           Container stats' \
            'ip              Show container IPs' \
            'kill-all        Remove all containers' \
            'Docker Compose dev environment'
        return 0
    fi

    case "$cmd" in
        start)    shift; dev_start "$@" ;;
        stop)     shift; dev_stop "$@" ;;
        restart)  shift; dev_restart "$@" ;;
        reload)   shift; dev_reload "$@" ;;
        status)   dev_status ;;
        list)     dev_list ;;
        logs)     shift; dev_logs "$@" ;;
        exec)     shift; dev_exec "$@" ;;
        stats)    dev_stats ;;
        ip)       dev_ip ;;
        kill-all) dev_kill_all ;;
        *)        echo "Unknown command: $cmd"; return 1 ;;
    esac
}

_main "$@"
