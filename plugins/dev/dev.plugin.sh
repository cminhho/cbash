#!/usr/bin/env bash
# Dev plugin for CBASH - Docker Compose development environment

# Compose file: CBASH_DEV_COMPOSE_FILE > ~/.cbash/dev/development.yml > templates/
COMPOSE_FILE="${CBASH_DEV_COMPOSE_FILE:-}"
[[ ! -f "${COMPOSE_FILE:-}" ]] && COMPOSE_FILE="${CBASH_DATA_DIR:-$HOME/.cbash}/dev/development.yml"
[[ ! -f "${COMPOSE_FILE:-}" ]] && COMPOSE_FILE="$CBASH_DIR/templates/dev/development.yml"
readonly COMPOSE_FILE

# Helpers
_dev_check_docker() {
    command -v docker &>/dev/null || { log_error "Docker not installed"; return 1; }
    docker info &>/dev/null && return 0
    log_info "Starting Docker..."; open -a Docker 2>/dev/null
    for _ in {1..30}; do docker info &>/dev/null && return 0; sleep 1; done
    log_error "Docker failed to start"; return 1
}

_dev_compose() {
    _dev_check_docker || return 1
    [[ -f "$COMPOSE_FILE" ]] || { log_error "Compose file not found"; return 1; }
    docker compose -f "$COMPOSE_FILE" "$@"
}

# Commands
dev_start()   { _dev_compose up -d "$@"; }
dev_stop()    { _dev_compose stop "$@"; }
dev_restart() { _dev_compose restart "$@"; }
dev_reload()  { _dev_compose up -d --force-recreate "$@"; }
dev_status()  { _dev_compose ps; }
dev_list()    { _dev_compose config --services; }
dev_logs()    { _dev_compose logs --tail=100 -f "$@"; }

dev_exec() {
    [[ -n "$1" ]] || { log_error "Usage: dev exec <service>"; return 1; }
    _dev_compose exec "$1" "${2:-/bin/sh}"
}

dev_stats() {
    _dev_check_docker || return 1
    [[ -n "$(docker ps -q)" ]] || { log_info "No containers"; return 0; }
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
}

dev_ip() {
    _dev_check_docker || return 1
    local containers
    containers=$(_dev_compose ps -q 2>/dev/null)
    [[ -z "$containers" ]] && { log_info "No containers"; return 0; }
    for c in $containers; do
        echo "$(docker inspect -f '{{.Name}}' "$c" | tr -d '/'): $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$c")"
    done
}

dev_kill_all() {
    _dev_check_docker || return 1
    log_info "Killing all..."
    local ids
    ids=$(docker ps -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker stop 2>/dev/null
    ids=$(docker ps -aq 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker rm 2>/dev/null
    ids=$(docker volume ls -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker volume rm 2>/dev/null
    log_success "Done"
}

# Help and router
dev_help() {
    _describe command 'dev' \
        'start [svc]     Start services' \
        'stop [svc]      Stop services' \
        'restart [svc]   Restart services' \
        'reload [svc]    Recreate services' \
        'status          Service status' \
        'list            List services' \
        'logs [svc]      Follow logs' \
        'exec <svc>      Shell into service' \
        'stats           Container stats' \
        'ip              Container IPs' \
        'kill-all        Remove all' \
        'Docker Compose dev environment'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") dev_help ;;
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
        *)        log_error "Unknown: $1"; return 1 ;;
    esac
}

