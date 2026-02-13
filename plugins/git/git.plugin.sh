#!/usr/bin/env bash
# Git plugin for CBASH
# Git workflow utilities and repository management

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"
[[ -n "$CBASH_DIR" ]] && [[ -f "$CBASH_DIR/plugins/git/git-aliases.sh" ]] && source "$CBASH_DIR/plugins/git/git-aliases.sh"

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_git_check() {
    command -v git &>/dev/null || {
        echo "Error: Git not installed"
        return 1
    }
}

_git_in_repo() {
    git rev-parse --git-dir &>/dev/null || {
        echo "Error: Not a git repository"
        return 1
    }
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
    echo "Undone last commit (changes preserved)"
}

git_branches() {
    _git_in_repo || return 1
    git for-each-ref --sort=committerdate refs/heads/ \
        --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))'
}

git_branch() {
    local name="$1"
    [[ -z "$name" ]] && { echo "Usage: git branch <name>"; return 1; }

    _git_in_repo || return 1
    git checkout master && git pull && git checkout -b "$name"
    success "Created branch: $name"
}

git_rename() {
    local name="$1"
    [[ -z "$name" ]] && { echo "Usage: git rename <new-name>"; return 1; }

    _git_in_repo || return 1
    git branch -m "$name"
    success "Renamed current branch to: $name"
}

git_size() {
    _git_in_repo || return 1
    git bundle create tmp.bundle --all 2>/dev/null
    echo "Repository size:"
    du -sh tmp.bundle
    rm -f tmp.bundle
}

git_clean() {
    _git_in_repo || return 1
    echo "Cleaning repository..."
    git remote prune origin
    git repack
    git prune-packed
    git reflog expire --expire=1.month.ago
    git gc --aggressive
    success "Repository cleaned"
}

git_backup() {
    _git_in_repo || return 1

    if [[ -z "$(git status --porcelain)" ]]; then
        echo "Nothing to commit"
        return 0
    fi

    git add --all
    git commit -m "chore: backup $(date +%Y-%m-%d)"
    git push
    success "Backup complete"
}

git_auto_commit() {
    _git_in_repo || return 1

    if [[ -z "$(git status --porcelain)" ]]; then
        echo "Nothing to commit"
        return 0
    fi

    local branch
    branch=$(git rev-parse --abbrev-ref HEAD)
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "Changes:"
    git status --short

    git add .
    git commit -m "Auto-commit: $timestamp"
    git push origin "$branch"
    success "Pushed to $branch"
}

git_squash() {
    _git_in_repo || return 1

    local branch msg
    read -rp "Branch to squash: " branch
    [[ -z "$branch" ]] && { echo "Branch required"; return 1; }

    read -rp "Commit message: " msg
    [[ -z "$msg" ]] && { echo "Message required"; return 1; }

    local temp_branch="${branch}_temp"
    local backup_branch="${branch}_backup"

    echo "Squashing $branch..."
    git branch -D "$backup_branch" 2>/dev/null
    git checkout master
    git checkout -b "$temp_branch"
    git merge --squash "$branch"
    git commit -am "$msg"
    git branch -m "$branch" "$backup_branch"
    git branch -m "$temp_branch" "$branch"
    git push --force

    success "Squashed $branch"
}

git_auto_squash() {
    _git_in_repo || return 1

    local current_branch default_branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "master")

    [[ "$current_branch" == "$default_branch" ]] && { echo "Already on $default_branch"; return 1; }

    local commit_count
    commit_count=$(git rev-list --count "$default_branch".."$current_branch")
    [[ "$commit_count" -eq 0 ]] && { echo "No commits to squash"; return 0; }

    echo "Squashing $commit_count commits on $current_branch..."
    read -rp "Commit message: " msg
    [[ -z "$msg" ]] && msg="Squashed $current_branch"

    git reset --soft "$default_branch"
    git commit -m "$msg"
    git push --force

    success "Squashed $commit_count commits into 1"
}

git_pull_all() {
    local root="${1:-$(pwd)}"
    echo "Pulling all repos in $root..."
    
    find "$root" -maxdepth 2 -name ".git" -type d | while read -r gitdir; do
        local repo_dir
        repo_dir=$(dirname "$gitdir")
        echo "→ $(basename "$repo_dir")"
        (cd "$repo_dir" && git pull --rebase 2>/dev/null || git pull 2>/dev/null) || true
    done
    
    success "Done"
}

git_sync() {
    _git_in_repo || return 1
    echo "Syncing..."
    git fetch --all --prune
    git pull
    success "Synced"
}

git_open() {
    _git_in_repo || return 1

    local url
    url=$(git config --get remote.origin.url)
    [[ -z "$url" ]] && { echo "No remote.origin.url"; return 1; }

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
        clean)          git_clean ;;
        size)           git_size ;;
        sync)           git_sync ;;
        open)           git_open ;;
        *)              echo "Unknown command: $cmd"; return 1 ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
