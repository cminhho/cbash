# K8s plugin for CBASH - Kubernetes helpers

List pods, follow logs, describe, exec into pods, restart deployments, and print kubectl command cheats. Uses `K8S_NAMESPACE` (default: `default`). Source CBASH to get aliases.

## Commands

| Command | Description |
|---------|-------------|
| `cbash k8s` / `help` | Show help |
| `cbash k8s aliases` | List aliases |
| `cbash k8s pods [opts]` | kubectl get pods -n \$K8S_NAMESPACE |
| `cbash k8s logs <pod>` | kubectl logs -f \<pod\> --tail=100 |
| `cbash k8s desc <pod>` | kubectl describe pod \<pod\> |
| `cbash k8s exec <pod>` | kubectl exec -it \<pod\> -- /bin/sh |
| `cbash k8s restart <deploy>` | kubectl rollout restart deployment \<deploy\> |
| `cbash k8s cheat [pod]` | Print kubectl commands (optionally for a pod name prefix) |
| `cbash k8s <name>` | Same as cheat \<name\> (pod prefix for context) |

## Aliases

| Alias | Command |
|-------|--------|
| `k8pods [opts]` | k8s pods |
| `k8logs <pod>` | k8s logs |
| `k8desc <pod>` | k8s desc |
| `k8exec <pod>` | k8s exec |
| `k8restart <deploy>` | k8s restart |
| `k8cheat [pod]` | k8s cheat |

## Configuration

```bash
export K8S_NAMESPACE="my-namespace"   # default: default
```

Requires `kubectl` and a valid kubeconfig (e.g. `~/.kube/config`).

## Examples

```bash
k8pods
k8logs my-app-abc123
k8exec my-app-abc123
k8restart my-app
k8cheat
k8cheat my-app
cbash k8s aliases
```
