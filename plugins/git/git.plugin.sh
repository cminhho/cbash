#!/usr/bin/env bash
# Git plugin for CBASH - Git workflow utilities

# Helpers
_git_in_repo()     { git rev-parse --git-dir &>/dev/null || { log_error "Not a git repository"; return 1; }; }
_git_require()     { [[ -n "$1" ]] || { log_error "Usage: git $2"; return 1; }; }
_git_has_changes() { [[ -n "$(git status --porcelain)" ]]; }

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

# Derive directory name from repo URL (e.g. https://github.com/user/repo.git -> repo).
_git_basename_from_url() {
    local url="${1:?}"
    url="${url%/}"
    url="${url%.git}"
    echo "${url##*/}"
}

# Read repo list file: skip blank and # lines; each line URL [optional_dir].
# Outputs nothing; call _git_read_repo_list_loop or parse line-by-line.
# Usage: while read -r url dir; do ... done < <(_git_read_repo_list <file>)
_git_read_repo_list() {
    local file="${1:?}"
    [[ -f "$file" ]] || { log_error "File not found: $file"; return 1; }
    local line url dir
    while IFS= read -r line; do
        line="${line%%#*}"   # strip inline comment
        line="$(printf '%s' "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        [[ -z "$line" ]] && continue
        url="${line%%[[:space:]]*}"
        dir="${line#*[[:space:]]}"
        dir="$(printf '%s' "$dir" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        [[ -z "$url" ]] && continue
        [[ "$dir" == "$line" ]] && dir=""   # no second field
        [[ -z "$dir" ]] && dir="$(_git_basename_from_url "$url")"
        printf '%s\t%s\n' "$url" "$dir"
    done < "$file"
}

# Commands 
git_config()   { git config --list; }
git_log()      { git log --pretty=oneline -20; }
git_undo()     { _git_in_repo && git reset --soft HEAD~ && log_success "Undone last commit"; }
git_branches() { _git_in_repo && git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))'; }

git_branch() {
    _git_require "$1" "branch <name>" && _git_in_repo || return 1
    git checkout master && git pull && git checkout -b "$1" && log_success "Created branch: $1"
}

git_rename() {
    _git_require "$1" "rename <new-name>" && _git_in_repo || return 1
    git branch -m "$1" && log_success "Renamed to: $1"
}

git_size() {
    _git_in_repo || return 1
    git bundle create tmp.bundle --all 2>/dev/null
    log_info "Repository size:"; du -sh tmp.bundle; rm -f tmp.bundle
}

git_clean() {
    _git_in_repo || return 1
    log_info "Cleaning..."
    git remote prune origin && git repack && git prune-packed
    git reflog expire --expire=1.month.ago && git gc --aggressive
    log_success "Cleaned"
}

git_backup() {
    _git_in_repo || return 1
    _git_has_changes || { log_info "Nothing to commit"; return 0; }
    git add --all && git commit -m "chore: backup $(date +%Y-%m-%d)" && git push
    log_success "Backup complete"
}

git_auto_commit() {
    _git_in_repo || return 1
    _git_has_changes || { log_info "Nothing to commit"; return 0; }
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD)
    log_info "Changes:"; git status --short
    git add . && git commit -m "chore: auto-commit $(date +%Y-%m-%d)" && git push origin "$branch"
    log_success "Pushed to $branch"
}

git_squash() {
    _git_in_repo || return 1
    local branch msg; read -rp "Branch to squash: " branch
    [[ -z "$branch" ]] && { log_error "Branch required"; return 1; }
    read -rp "Commit message: " msg
    [[ -z "$msg" ]] && { log_error "Message required"; return 1; }
    log_info "Squashing $branch..."
    git branch -D "${branch}_backup" 2>/dev/null
    git checkout master && git checkout -b "${branch}_temp" && git merge --squash "$branch"
    git commit -am "$msg" && git branch -m "$branch" "${branch}_backup"
    git branch -m "${branch}_temp" "$branch" && git push --force
    log_success "Squashed $branch"
}

git_auto_squash() {
    _git_in_repo || return 1
    local cur def count
    cur=$(git rev-parse --abbrev-ref HEAD)
    def=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "master")
    [[ "$cur" == "$def" ]] && { log_info "Already on $def"; return 1; }
    count=$(git rev-list --count "$def".."$cur")
    [[ "$count" -eq 0 ]] && { log_info "No commits to squash"; return 0; }
    log_info "Squashing $count commits..."
    local msg; read -rp "Commit message: " msg; [[ -z "$msg" ]] && msg="Squashed $cur"
    git reset --soft "$def" && git commit -m "$msg" && git push --force
    log_success "Squashed $count commits"
}

# Commands (batch)
git_pull_all() {
    local root="${1:-$(pwd)}"
    _gap; _heading_muted "▸ Pulling all repos" "in %s" "$root"; _br
    _git_each_repo "$root" "git pull --rebase 2>&1 || git pull 2>&1" "pulled"
}

git_for() {
    local cmd="${1:?Usage: git for \"<command>\" [root_dir]}" root="${2:-$(pwd)}"
    _gap; _heading_muted "▸ Running in all repos" "(%s)" "$root"; _br
    _git_each_repo "$root" "$cmd" "completed"
}

git_clone_all() {
    local list="${1:?Usage: git clone-all <file> [dest]}" dest="${2:-$(pwd)}"
    [[ -f "$list" ]] || { log_error "File not found: $list"; return 1; }
    dest="${dest/#\~/$HOME}"; [[ -d "$dest" ]] || mkdir -p "$dest"
    dest="$(cd -P "$dest" && pwd)"
    _gap; _heading_muted "▸ Clone from list" "%s → %s" "$list" "$dest"; _br
    local url dir path out ret failed=0 count=0
    while IFS=$'\t' read -r url dir; do
        path="$dest/$dir"
        [[ -d "$path/.git" ]] && { log_info "$dir: exists (skip)"; ((count++)); continue; }
        _label "▸ $dir"; _muted " ($url)"; _br
        out=$(git clone --quiet "$url" "$path" 2>&1); ret=$?
        [[ $ret -eq 0 ]] && { log_info "$dir: cloned"; ((count++)); } || { log_error "$dir: failed"; ((failed++)); }
        _gap
    done < <(_git_read_repo_list "$list")
    [[ $failed -gt 0 ]] && { log_error "Done: $count cloned, $failed failed"; return 1; }
    log_success "Done: $count repo(s) cloned"
}

git_sync() {
    _git_in_repo || return 1
    log_info "Syncing..."
    git fetch --all --prune && git pull && log_success "Synced"
}

git_open() {
    _git_in_repo || return 1
    local url
    url=$(git config --get remote.origin.url)
    [[ -z "$url" ]] && { log_error "No remote.origin.url"; return 1; }
    url=${url/git@github.com:/https://github.com/}
    url=${url/git@bitbucket.org:/https://bitbucket.org/}
    url=${url/git@gitlab.com:/https://gitlab.com/}
    url=${url%.git}
    open "$url" 2>/dev/null || xdg-open "$url" 2>/dev/null || echo "$url"
}

# Help and router
git_help() {
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
        'clone-all <file> [dir] Clone repos from file' \
        'for "cmd" [dir] Run command in every repo' \
        'clean           Clean and optimize repo' \
        'size            Show repo size' \
        'sync            Sync current repo' \
        'open            Open repo in browser' \
        'Git workflow utilities'
}

_main() {
    case "${1:-}" in
        help|--help|-h|"") git_help ;;
        config)            git_config ;;
        log)               git_log ;;
        branches)          git_branches ;;
        branch)            shift; git_branch "$@" ;;
        rename)            shift; git_rename "$@" ;;
        undo|undo-commit)  git_undo ;;
        backup)            git_backup ;;
        auto-commit)       git_auto_commit ;;
        squash)            git_squash ;;
        auto-squash)       git_auto_squash ;;
        pull-all)          shift; git_pull_all "$@" ;;
        clone-all)         shift; git_clone_all "$@" ;;
        for)               shift; git_for "$@" ;;
        clean)             git_clean ;;
        size)              git_size ;;
        sync)              git_sync ;;
        open)              git_open ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

