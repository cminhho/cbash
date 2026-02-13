#!/usr/bin/env bash
# K8s plugin for CBASH
# Kubernetes command helper and cheatsheet generator

source "$CBASH_DIR/lib/common.sh"

# Configuration
readonly K8S_NS="${K8S_NAMESPACE:-default}"

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

k8s_pods() {
    kubectl get pods -n "$K8S_NS" "$@"
}

k8s_logs() {
    local pod="$1"
    [[ -z "$pod" ]] && { echo "Usage: k8s logs <pod>"; return 1; }
    kubectl logs -f "$pod" -n "$K8S_NS" --tail=100
}

k8s_desc() {
    local pod="$1"
    [[ -z "$pod" ]] && { echo "Usage: k8s desc <pod>"; return 1; }
    kubectl describe pod "$pod" -n "$K8S_NS"
}

k8s_exec() {
    local pod="$1"
    [[ -z "$pod" ]] && { echo "Usage: k8s exec <pod>"; return 1; }
    kubectl exec -it "$pod" -n "$K8S_NS" -- /bin/sh
}

k8s_restart() {
    local deploy="$1"
    [[ -z "$deploy" ]] && { echo "Usage: k8s restart <deployment>"; return 1; }
    kubectl rollout restart deployment "$deploy" -n "$K8S_NS"
    success "Restarted $deploy"
}

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

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'k8s' \
            'pods            List pods' \
            'logs <pod>      Follow pod logs' \
            'desc <pod>      Describe pod' \
            'exec <pod>      Shell into pod' \
            'restart <deploy> Restart deployment' \
            'cheat [pod]     Show kubectl commands' \
            "Kubernetes helpers (ns: $K8S_NS)"
        return 0
    fi

    case "$cmd" in
        pods)    shift; k8s_pods "$@" ;;
        logs)    shift; k8s_logs "$@" ;;
        desc)    shift; k8s_desc "$@" ;;
        exec)    shift; k8s_exec "$@" ;;
        restart) shift; k8s_restart "$@" ;;
        cheat)   shift; k8s_cheat "$@" ;;
        *)       k8s_cheat "$cmd" ;;
    esac
}

_main "$@"