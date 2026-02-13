# Docker plugin

Docker CLI helpers and short aliases. Inspired by [ohmyzsh docker plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker).

Loaded automatically when you source CBASH. Use `cbash docker` for helper commands.

## Commands

| Command | Description |
|---------|-------------|
| `cbash docker` / `help` | Show help |
| `cbash docker list` | List Docker aliases |
| `cbash docker running` | List running containers (table) |
| `cbash docker stop-all` | Stop all running containers |
| `cbash docker remove-stopped` | Remove all stopped containers |
| `cbash docker prune-images` | Remove unused images |
| `cbash docker kill-all` | Stop containers, remove containers and volumes |

## Helper functions (also in shell)

- `docker_running` – table of running containers
- `docker_stop_all` – stop all running containers
- `docker_remove_stopped` – remove stopped containers
- `docker_remove_unused_images` – `docker image prune -a -f`
- `docker_kill_all` – stop, kill, rm containers and volumes

## Aliases (ohmyzsh-style)

| Alias | Command |
|-------|--------|
| `dps` | docker ps |
| `dpsa` | docker ps -a |
| `dcls` | docker container ls |
| `dclsa` | docker container ls -a |
| `dbl` | docker build |
| `dpu` | docker pull |
| `dr` | docker container run |
| `drit` | docker container run -it |
| `drm` | docker container rm |
| `dst` | docker container start |
| `dstp` | docker container stop |
| `drs` | docker container restart |
| `dlo` | docker container logs |
| `dxc` | docker container exec |
| `dxcit` | docker container exec -it |
| `dils` | docker image ls |
| `dipru` | docker image prune -a |
| `dnls` | docker network ls |
| `dvls` | docker volume ls |
| `dvprune` | docker volume prune |
| `dsts` | docker stats |
| `dtop` | docker top |

And more: `dcin`, `dii`, `dipu`, `dirm`, `dit`, `dnc`, `dncn`, `dndcn`, `dni`, `dnrm`, `dpo`, `dvi`.

## Prerequisites

* [Docker](https://docs.docker.com/get-docker/) installed and running.

## Examples

```bash
dps                    # docker ps
docker_running         # table of running containers
cbash docker stop-all  # stop all containers
cbash docker list      # list aliases
```
