# git

This plugin provides Git workflow utilities including branch management, repository maintenance,
and automated commit workflows.

To use it, the plugin is automatically loaded by CBASH. No additional configuration required.

## Plugin commands

* `cbash git config`: displays local Git configuration settings using `git config --list`.

* `cbash git log`: shows the last 20 commits in one-line format for quick history review.

* `cbash git branches`: lists all local branches sorted by last commit date, showing branch name,
  short commit hash, commit message, and relative time.

* `cbash git branch <name>`: creates a new branch from master. Checks out master, pulls latest
  changes, then creates and switches to the new branch.

* `cbash git rename <name>`: renames the current branch to the specified name.

* `cbash git undo`: undoes the last commit while preserving changes in the working directory
  (soft reset). Useful for fixing commit mistakes.

* `cbash git backup`: quick commit and push workflow. Adds all changes, commits with message
  `chore: backup YYYY-MM-DD`, and pushes to remote.

* `cbash git auto-commit`: automated commit workflow. Shows changed files, adds all changes,
  commits with timestamp message, and pushes to current branch.

* `cbash git squash`: interactively squashes commits on a branch. Prompts for branch name and
  commit message, then squashes all commits into one and force pushes.

* `cbash git clean`: cleans and optimizes the repository by pruning remote branches, repacking,
  expiring old reflogs, and running aggressive garbage collection.

* `cbash git size`: calculates repository size by creating a temporary bundle of all refs.

* `cbash git sync`: syncs current repository by fetching all remotes with prune and pulling.

* `cbash git open`: opens the repository in browser. Converts SSH URLs to HTTPS and opens in
  default browser. Supports GitHub, GitLab, and Bitbucket.

## Prerequisites

The plugin requires [Git](https://git-scm.com/) to be installed:

```bash
# Install Git
brew install git  # macOS
apt-get install git  # Linux
```

## Examples

Create a feature branch:

```bash
cbash git branch feature/user-auth
```

Quick backup of work in progress:

```bash
cbash git backup
```

Undo last commit (keep changes):

```bash
cbash git undo
```

View branches by recent activity:

```bash
cbash git branches
```

Squash commits before merge:

```bash
cbash git squash
# Branch to squash: feature/my-feature
# Commit message: feat: add user authentication
```

Clean up repository:

```bash
cbash git clean
```

Open repository in browser:

```bash
cbash git open
```

## Troubleshooting

**Git not found:**
```bash
brew install git
```

**Not a git repository:**
- Ensure you're in a directory with `.git` folder
- Run `git init` to initialize a new repository

**Push failed:**
- Check remote is configured: `git remote -v`
- Verify SSH keys or credentials are set up
- Pull latest changes first: `cbash git sync`

**Squash failed:**
- Ensure branch exists: `git branch -a`
- Commit any uncommitted changes first
- Check you have push access to remote
