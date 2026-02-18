# Git plugin

Git workflow utilities: branch management, batch pull/clone, auto-commit, squash, sync. Loaded automatically by CBASH.

## Plugin commands

| Command | Description |
|---------|-------------|
| `cbash git config` | Show local git config |
| `cbash git log` | Last 20 commits (oneline) |
| `cbash git branches` | List branches with dates |
| `cbash git branch <name>` | Create branch from default (main/master), pull, then checkout new branch |
| `cbash git rename <name>` | Rename current branch |
| `cbash git undo` | Undo last commit (soft), keep changes |
| `cbash git backup` | Add all, commit `chore: backup YYYY-MM-DD`, push |
| `cbash git auto-commit` | Add all, commit with timestamp, push |
| `cbash git squash` | Interactive squash; prompts branch + message, then force push |
| `cbash git auto-squash` | Squash all on feature branch |
| `cbash git clean` | Prune, repack, gc |
| `cbash git size` | Repo size (bundle of refs) |
| `cbash git sync` | Fetch all + pull |
| `cbash git open` | Open repo in browser (GitHub/GitLab/Bitbucket) |
| `cbash git pull-all [dir]` | Pull in all repos under dir (default: cwd) |
| `cbash git clone-all <file> [dir]` | Clone from list file |
| `cbash git for "<cmd>" [dir]` | Run command in every repo under dir |

## Shortcuts (aliases)

When the plugin is loaded, these aliases call the plugin:

| Alias | Runs |
|-------|------|
| `commit` | `cbash git auto-commit` |
| `undo` | `cbash git undo` |
| `pull_all` | `cbash git pull-all` |
| `repos_pull` | `cbash git pull-all $WORKSPACE_ROOT` |
| `clone_all` | `cbash git clone-all` |
| `gitfor` | `cbash git for` |
| `gitsync` | `cbash git sync` |
| `gitclean` | `cbash git clean` |
| `auto_squash`, `squash` | `cbash git auto-squash`, `cbash git squash` |

Plus many `g*` aliases (e.g. `g`, `gs`, `gp`, `gcom`) — see `plugins/git/git.aliases.sh`.

## Prerequisites

[Git](https://git-scm.com/) — `brew install git` (macOS) or `apt-get install git` (Linux).

## Examples

```bash
cbash git branch feature/user-auth   # create branch from default, pull, checkout
cbash git backup                      # quick commit + push
undo                                 # or: cbash git undo (undo last commit, keep changes)
commit                               # or: cbash git auto-commit
cbash git branches                    # branches by recent activity
cbash git squash                      # interactive squash (prompts branch + message)
cbash git clean                       # prune, repack, gc
cbash git open                        # open repo in browser
gitfor "git pull"                     # pull in every repo (or: cbash git for "git pull")
gitfor "git status" ~/workspace       # run in custom dir
```

## Troubleshooting

- **Git not found:** `brew install git`
- **Not a git repo:** run from a dir with `.git` or `git init`
- **Push failed:** `git remote -v`, check SSH/credentials, run `gitsync` or `cbash git sync`
- **Squash failed:** ensure branch exists, commit first, check push access
