# Dev plugin for CBASH - Docker Compose development environment

Docker Compose development environment. Uses `plugins/dev/development.yml` to start, stop, and manage local services (e.g. Localstack).

Source CBASH to get aliases. Use `cbash dev` or `cbash log|logs|stop|exec|status|kill|kill-all` for commands.

## Aliases

| Alias | Command |
|-------|--------|
| `start` | Start services (up -d) |
| `stop` | Stop services |
| `restart` | Restart services |
| `devreload` | Recreate and start services |
| `devstatus` | Show service status (ps) |
| `devlist` | List service names |
| `devlogs` | Follow logs (tail -f) |
| `devexec` | Shell into service (dev exec \<svc\>) |
| `devstats` | Container CPU/memory stats |
| `devip` | Show container IPs |
| `devkill` | Stop and remove all containers/volumes |

## Plugin commands

* `cbash dev` / `cbash dev help`: show help.

* `cbash dev start [svc]`: start all or one service (`docker compose up -d`).

* `cbash dev stop [svc]`: stop services.

* `cbash dev restart [svc]`: restart services.

* `cbash dev reload [svc]`: recreate and start.

* `cbash dev status`: show status (`docker compose ps`).

* `cbash dev list`: list service names.

* `cbash dev aliases`: list dev aliases.

* `cbash dev logs [svc]`: follow logs (tail 100).

* `cbash dev exec <svc> [cmd]`: run command in service (default `/bin/sh`).

* `cbash dev stats`: container stats (CPU, memory, I/O).

* `cbash dev ip`: show container names and IPs.

* `cbash dev kill-all`: stop and remove all containers and volumes.

Shortcuts from cbash: `cbash log`, `cbash logs`, `cbash stop`, `cbash exec`, `cbash status`, `cbash kill`, `cbash kill-all` all route to this plugin.

## Prerequisites

* Docker and Docker Compose.
* Compose file: `$CBASH_DIR/plugins/dev/development.yml`.

## Examples

```bash
start              # start all services
stop               # stop services
devlogs            # follow all logs
devlogs localstack # follow localstack logs
devexec localstack # shell into localstack
cbash dev status
```

## Configuration

Edit `development.yml` in this directory to add or change services. Default includes Localstack (S3, SQS, SNS, SSM) on port 4566.
