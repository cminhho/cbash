#!/usr/bin/env bash
# Git plugin for CBASH
# Git workflow utilities and repository management

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"
[[ -n "$CBASH_DIR" ]] && [[ -f "$CBASH_DIR/plugins/git/git-aliases.sh" ]] && source "$CBASH_DIR/plugins/git/git-aliases.sh"

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_git_in_repo() {
    git rev-parse --git-dir &>/dev/null || { log_error "Not a git repository"; return 1; }
}

# Run cmd in each repo. Per-repo: log_info (context); end: log_success.
# Usage: _git_each_repo <root> <cmd> [action]. action e.g. "pulled", "completed".
_git_each_repo() {
    local root="$1" cmd="$2" action="${3:-done}" repo_dir name out ret
    while read -r gitdir; do
        repo_dir=$(dirname "$gitdir"); name=$(basename "$repo_dir")
        _label "▸ $name"; _muted " ($repo_dir)"; _br
        _muted_nl "  \$ $cmd"
        out=$(cd "$repo_dir" && eval "$cmd" 2>&1); ret=$?
        echo "$out" | _indent
        [[ $ret -eq 0 ]] && log_info "$name: $action" || log_error "$name: failed (exit $ret)"
        _gap
    done < <(find "$root" -maxdepth 2 -name ".git" -type d)
    log_success "Done"
}

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

git_config() {
    git config --list
}

git_log() {
    git log --pretty=oneline -20
}

git_undo() {
    _git_in_repo || return 1
    git reset --soft HEAD~
    log_success "Undone last commit (changes preserved)"
}

git_branches() {
    _git_in_repo || return 1
    git for-each-ref --sort=committerdate refs/heads/ \
        --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))'
}

git_branch() {
    local name="$1"
    [[ -z "$name" ]] && { log_error "Usage: git branch <name>"; return 1; }

    _git_in_repo || return 1
    git checkout master && git pull && git checkout -b "$name"
    log_success "Created branch: $name"
}

git_rename() {
    local name="$1"
    [[ -z "$name" ]] && { log_error "Usage: git rename <new-name>"; return 1; }

    _git_in_repo || return 1
    git branch -m "$name"
    log_success "Renamed current branch to: $name"
}

git_size() {
    _git_in_repo || return 1
    git bundle create tmp.bundle --all 2>/dev/null
    log_info "Repository size:"
    du -sh tmp.bundle
    rm -f tmp.bundle
}

git_clean() {
    _git_in_repo || return 1
    log_info "Cleaning repository..."
    git remote prune origin
    git repack
    git prune-packed
    git reflog expire --expire=1.month.ago
    git gc --aggressive
    log_success "Repository cleaned"
}

git_backup() {
    _git_in_repo || return 1

    if [[ -z "$(git status --porcelain)" ]]; then
        log_info "Nothing to commit"
        return 0
    fi

    git add --all
    git commit -m "chore: backup $(date +%Y-%m-%d)"
    git push
    log_success "Backup complete"
}

git_auto_commit() {
    _git_in_repo || return 1

    if [[ -z "$(git status --porcelain)" ]]; then
        log_info "Nothing to commit"
        return 0
    fi

    local branch
    branch=$(git rev-parse --abbrev-ref HEAD)
    local date
    date=$(date '+%Y-%m-%d')

    log_info "Changes:"
    git status --short

    git add .
    git commit -m "chore: auto-commit work in progress ($date)"
    git push origin "$branch"
    log_success "Pushed to $branch"
}

git_squash() {
    _git_in_repo || return 1

    local branch msg
    read -rp "Branch to squash: " branch
    [[ -z "$branch" ]] && { log_error "Branch required"; return 1; }

    read -rp "Commit message: " msg
    [[ -z "$msg" ]] && { log_error "Message required"; return 1; }

    local temp_branch="${branch}_temp"
    local backup_branch="${branch}_backup"

    log_info "Squashing $branch..."
    git branch -D "$backup_branch" 2>/dev/null
    git checkout master
    git checkout -b "$temp_branch"
    git merge --squash "$branch"
    git commit -am "$msg"
    git branch -m "$branch" "$backup_branch"
    git branch -m "$temp_branch" "$branch"
    git push --force

    log_success "Squashed $branch"
}

git_auto_squash() {
    _git_in_repo || return 1

    local current_branch default_branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "master")

    [[ "$current_branch" == "$default_branch" ]] && { log_info "Already on $default_branch"; return 1; }

    local commit_count
    commit_count=$(git rev-list --count "$default_branch".."$current_branch")
    [[ "$commit_count" -eq 0 ]] && { log_info "No commits to squash"; return 0; }

    log_info "Squashing $commit_count commits on $current_branch..."
    read -rp "Commit message: " msg
    [[ -z "$msg" ]] && msg="Squashed $current_branch"

    git reset --soft "$default_branch"
    git commit -m "$msg"
    git push --force

    log_success "Squashed $commit_count commits into 1"
}

git_pull_all() {
    local root="${1:-$(pwd)}"
    _gap; _heading_muted "▸ Pulling all repos" "in %s" "$root"; _br
    _git_each_repo "$root" "git pull --rebase 2>&1 || git pull 2>&1" "pulled"
}

git_for() {
    local cmd="${1:?Usage: git for \"<command>\" [root_dir]}" root="${2:-$(pwd)}"
    _gap; _heading_muted "▸ Running in all repos" "(%s)" "$root"; _br
    _label "  Command:"; _muted_nl " $cmd"; _br
    _git_each_repo "$root" "$cmd" "completed"
}

git_sync() {
    _git_in_repo || return 1
    log_info "Syncing..."
    git fetch --all --prune || { log_error "Fetch failed"; return 1; }
    git pull || { log_error "Pull failed"; return 1; }
    log_success "Synced"
}

git_open() {
    _git_in_repo || return 1

    local url
    url=$(git config --get remote.origin.url)
    [[ -z "$url" ]] && { log_error "No remote.origin.url"; return 1; }

    # Convert SSH to HTTPS
    url=${url/git@github.com:/https://github.com/}
    url=${url/git@bitbucket.org:/https://bitbucket.org/}
    url=${url/git@gitlab.com:/https://gitlab.com/}
    url=${url%.git}

    open "$url" 2>/dev/null || xdg-open "$url" 2>/dev/null || echo "$url"
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        _describe command 'git' \
            'config          Show git config' \
            'log             Show recent commits' \
            'branches        List branches with dates' \
            'branch <name>   Create branch from master' \
            'rename <name>   Rename current branch' \
            'undo            Undo last commit (soft)' \
            'backup          Quick commit and push' \
            'auto-commit     Auto commit all changes' \
            'squash          Squash commits interactively' \
            'auto-squash     Squash all commits on feature branch' \
            'pull-all [dir]  Pull all repos in directory' \
            'for "cmd" [dir] Run command in every repo (e.g. for "git pull")' \
            'clean           Clean and optimize repo' \
            'size            Show repo size' \
            'sync            Sync current repo' \
            'open            Open repo in browser' \
            'Git workflow utilities'
        return 0
    fi

    case "$cmd" in
        config)         git_config ;;
        log)            git_log ;;
        branches)       git_branches ;;
        branch)         shift; git_branch "$@" ;;
        rename)         shift; git_rename "$@" ;;
        undo|undo-commit) git_undo ;;
        backup)         git_backup ;;
        auto-commit)    git_auto_commit ;;
        squash)         git_squash ;;
        auto-squash)    git_auto_squash ;;
        pull-all)       shift; git_pull_all "$@" ;;
        for)            shift; git_for "$@" ;;
        clean)          git_clean ;;
        size)           git_size ;;
        sync)           git_sync ;;
        open)           git_open ;;
        *)              log_error "Unknown command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
