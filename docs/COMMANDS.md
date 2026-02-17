# CBASH Commands Reference

## Quick Reference

| Alias | Command | Description |
|-------|---------|-------------|
| `commit` | `cbash git auto-commit` | Auto-commit with timestamp |
| `auto_squash` | `cbash git auto-squash` | Squash feature branch |
| `pull_all` | `cbash git pull-all` | Pull all repos |
| `clone_all` | `cbash git clone-all` | Clone repos from file |
| `gitfor` | `cbash git for` | Run command in all repos |
| `gitsync` | `cbash git sync` | Fetch and pull |
| `start` | `cbash dev start` | Start Docker services |
| `stop` | `cbash dev stop` | Stop services |
| `devlogs` | `cbash dev logs` | Follow logs |
| `devexec` | `cbash dev exec` | Shell into container |
| `k8pods` | `cbash k8s pods` | List pods |
| `k8logs` | `cbash k8s logs` | Follow pod logs |
| `awsssh` | `cbash aws ssh` | SSM connect |
| `chat` | `cbash ai chat` | Chat with Ollama |

## By Plugin

### Git
```bash
cbash git auto-commit       # Auto-commit and push
cbash git auto-squash       # Squash feature branch
cbash git pull-all [dir]    # Pull all repos
cbash git clone-all <file>  # Clone from list
cbash git for "<cmd>"       # Run in all repos
cbash git sync              # Fetch and pull
cbash git branch <name>     # Create branch
cbash git undo              # Undo last commit
```

### Dev (Docker Compose)
```bash
cbash dev start [svc]       # Start services
cbash dev stop [svc]        # Stop services
cbash dev logs [svc]        # Follow logs
cbash dev exec <svc>        # Shell into container
cbash dev kill-all          # Stop and remove all
```

### K8s
```bash
cbash k8s pods              # List pods
cbash k8s logs <pod>        # Follow logs
cbash k8s exec <pod>        # Shell into pod
cbash k8s restart <deploy>  # Rollout restart
```

### AWS
```bash
cbash aws ssh <profile>     # SSM connect
cbash aws ssm-get           # Get parameter
```

### AI
```bash
cbash ai chat [model]       # Chat with Ollama
cbash ai pull <model>       # Pull model
```

## Help

```bash
cbash                       # Minimal help
cbash --full                # Full help
cbash <plugin> help         # Plugin help
```
