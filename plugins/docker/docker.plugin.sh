#!/usr/bin/env bash
# Docker plugin for CBASH - Docker CLI helpers

# Commands
docker_running()       { docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Image}}"; }
docker_stop_all()      { local ids; ids=$(docker ps -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker stop 2>/dev/null; log_success "Stopped all"; }
docker_remove_stopped(){ local ids; ids=$(docker ps -a -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker rm 2>/dev/null; log_success "Removed stopped"; }
docker_prune_images()  { docker image prune -a -f && log_success "Pruned images"; }

docker_kill_all() {
    log_info "Killing all..."
    local ids
    docker ps -a -q 2>/dev/null | xargs -n 1 -P 8 -I {} docker stop {} 2>/dev/null || true
    ids=$(docker ps -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker kill 2>/dev/null || true
    ids=$(docker ps -a -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker rm 2>/dev/null || true
    ids=$(docker volume ls -q 2>/dev/null); [[ -n "$ids" ]] && echo "$ids" | xargs docker volume rm 2>/dev/null || true
    log_success "Done"
}

# Help and router
docker_help() {
    _describe command 'docker' \
        'running         List running containers' \
        'stop-all        Stop all containers' \
        'remove-stopped  Remove stopped containers' \
        'prune-images    Remove unused images' \
        'kill-all        Stop, remove all and volumes' \
        'Docker helpers'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") docker_help ;;
        running)           docker_running ;;
        stop-all)          docker_stop_all ;;
        remove-stopped)    docker_remove_stopped ;;
        prune-images)      docker_prune_images ;;
        kill-all)          docker_kill_all ;;
        *)                 docker_help ;;
    esac
}

