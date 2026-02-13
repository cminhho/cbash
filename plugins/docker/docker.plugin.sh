#!/usr/bin/env bash
# Docker plugin for CBASH
# Helper functions and short aliases for Docker CLI. Inspired by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker

[[ -n "$CBASH_DIR" ]] && [[ -f "$CBASH_DIR/lib/common.sh" ]] && source "$CBASH_DIR/lib/common.sh"

# -----------------------------------------------------------------------------
# Helper functions (from aliases/docker.sh)
# -----------------------------------------------------------------------------

docker_running() {
    docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Image}}"
}

docker_stop_all() {
    docker stop $(docker ps -q) 2>/dev/null || true
    log_success "All running containers stopped."
}

docker_remove_stopped() {
    docker rm $(docker ps -a -q) 2>/dev/null || true
    log_success "All stopped containers removed."
}

docker_remove_unused_images() {
    docker image prune -a -f
    log_success "All unused images removed."
}

docker_kill_all() {
    log_info "Performing action 'kill all services'"
    docker ps -a -q | xargs -n 1 -P 8 -I {} docker stop {} 2>/dev/null || true
    docker kill $(docker ps -q) 2>/dev/null || true
    docker rm $(docker ps -a -q) 2>/dev/null || true
    docker volume rm $(docker volume ls -q) 2>/dev/null || true
    log_success "Successfully killed all services"
}

# -----------------------------------------------------------------------------
# Short aliases (ohmyzsh-style)
# -----------------------------------------------------------------------------

alias d='docker'
alias dbl='docker build'
alias dcin='docker container inspect'
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dib='docker image build'
alias dii='docker image inspect'
alias dils='docker image ls'
alias dipu='docker image push'
alias dipru='docker image prune -a'
alias dirm='docker image rm'
alias dit='docker image tag'
alias dlo='docker container logs'
alias dnc='docker network create'
alias dncn='docker network connect'
alias dndcn='docker network disconnect'
alias dni='docker network inspect'
alias dnls='docker network ls'
alias dnrm='docker network rm'
alias dpo='docker container port'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpu='docker pull'
alias dr='docker container run'
alias drit='docker container run -it'
alias drm='docker container rm'
alias dst='docker container start'
alias drs='docker container restart'
alias dstp='docker container stop'
alias dsts='docker stats'
alias dtop='docker top'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvprune='docker volume prune'
alias dxc='docker container exec'
alias dxcit='docker container exec -it'

# -----------------------------------------------------------------------------
# Plugin commands (cbash docker ...)
# -----------------------------------------------------------------------------

docker_help() {
    _describe command 'docker' \
        'help            Show this help' \
        'list            List Docker aliases' \
        'running         List running containers (table)' \
        'stop-all        Stop all running containers' \
        'remove-stopped  Remove all stopped containers' \
        'prune-images    Remove unused images' \
        'kill-all        Stop, remove containers and volumes' \
        'Docker helpers and short aliases (dps, dr, drm, ...)'
}

docker_list_aliases() {
    echo "Docker aliases: dbl, dcin, dcls, dclsa, dib, dii, dils, dlo, dps, dpsa, dpu, dr, drit, drm, dst, drs, dstp, dsts, dtop, dvls, dxc, dxcit, ..."
}

_main() {
    local cmd="${1:-help}"

    case "$cmd" in
        help|--help|-h)   docker_help ;;
        list)             docker_list_aliases ;;
        running)          docker_running ;;
        stop-all)         docker_stop_all ;;
        remove-stopped)   docker_remove_stopped ;;
        prune-images)     docker_remove_unused_images ;;
        kill-all)         docker_kill_all ;;
        *)                docker_help ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
