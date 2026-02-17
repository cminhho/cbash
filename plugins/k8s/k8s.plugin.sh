#!/usr/bin/env bash
# K8s plugin for CBASH - Kubernetes helpers

readonly K8S_NS="${K8S_NAMESPACE:-default}"

# Helper: require argument
_k8s_require() { [[ -n "$1" ]] || { log_error "Usage: k8s $2"; return 1; }; }

# Commands
k8s_pods()    { kubectl get pods -n "$K8S_NS" "$@"; }
k8s_logs()    { _k8s_require "$1" "logs <pod>" && kubectl logs -f "$1" -n "$K8S_NS" --tail=100; }
k8s_desc()    { _k8s_require "$1" "desc <pod>" && kubectl describe pod "$1" -n "$K8S_NS"; }
k8s_exec()    { _k8s_require "$1" "exec <pod>" && kubectl exec -it "$1" -n "$K8S_NS" -- /bin/sh; }
k8s_restart() { _k8s_require "$1" "restart <deploy>" && kubectl rollout restart deployment "$1" -n "$K8S_NS" && log_success "Restarted $1"; }

k8s_cheat() {
    local pod="$1"
    local ns="$K8S_NS"

    if [[ -n "$pod" ]]; then
        local name="${pod%%-*}"
        cat <<EOF
# Pods
kubectl get pods -n $ns
kubectl describe pod $pod -n $ns
kubectl logs -f $pod -n $ns --tail=100

# Exec
kubectl exec -it $pod -n $ns -- /bin/sh

# Deployment
kubectl rollout restart deployment ${name} -n $ns
kubectl rollout status deployment ${name} -n $ns
EOF
    else
        cat <<EOF
# Common kubectl commands
kubectl get pods -n $ns
kubectl get pods -o wide -n $ns
kubectl get deployments -n $ns
kubectl get services -n $ns
kubectl get events -n $ns --sort-by='.lastTimestamp'

# Logs
kubectl logs -f <pod> -n $ns --tail=100
kubectl logs -f -l app=<name> -n $ns

# Describe
kubectl describe pod <pod> -n $ns
kubectl describe deployment <deploy> -n $ns

# Exec
kubectl exec -it <pod> -n $ns -- /bin/sh

# Rollout
kubectl rollout restart deployment <deploy> -n $ns
kubectl rollout status deployment <deploy> -n $ns
kubectl rollout undo deployment <deploy> -n $ns
EOF
    fi
}

# Help and router
k8s_help() {
    _describe command 'k8s' \
        'pods            List pods' \
        'logs <pod>      Follow pod logs' \
        'desc <pod>      Describe pod' \
        'exec <pod>      Shell into pod' \
        'restart <deploy> Restart deployment' \
        'cheat [pod]     Show kubectl commands' \
        "Kubernetes helpers (ns: $K8S_NS)"
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") k8s_help ;;
        pods)    shift; k8s_pods "$@" ;;
        logs)    shift; k8s_logs "$@" ;;
        desc)    shift; k8s_desc "$@" ;;
        exec)    shift; k8s_exec "$@" ;;
        restart) shift; k8s_restart "$@" ;;
        cheat)   shift; k8s_cheat "$@" ;;
        *)       k8s_cheat "$1" ;;
    esac
}

