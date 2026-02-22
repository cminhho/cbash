# Configuration

One config file, like `.zshrc`: **`~/.cbashrc`**. Created by `tools/install.sh` if missing. All CBASH config goes here.

Precedence (highest first):

1. **Environment** — variables set in the shell before running `cbash`
2. **Config file** — shell script sourced at startup; set or export variables
3. **Defaults** — built into each plugin


---

## Config file: ~/.cbashrc

| Aspect | Behavior |
|--------|----------|
| **Location** | `~/.cbashrc`. Override with `CBASH_CONFIG_FILE` (e.g. in your shell before sourcing cbash). |
| **Setup** | **`tools/install.sh`** creates `~/.cbashrc` with commented examples if the file does not exist (never overwrites). |
| **Format** | Shell script (sourced). Use `export VAR=value` or `VAR=value`. |
| **Missing file** | Ignored; plugins use env or defaults. |

Use a `CBASH_*` prefix for plugin variables so they don’t clash with other tools.

---

## Global data directory

Templates live in **`templates/`** in the repo (e.g. `templates/dev/development.yml`). **`tools/install.sh`** copies the whole `templates/` tree to the **global data dir** so you can edit files without touching the repo. Upgrades won't overwrite your copy.

| Aspect | Behavior |
|--------|----------|
| **Source** | Repo dir `templates/`. Add any file under `templates/<path>`; install copies it to `$CBASH_DATA_DIR/<path>`. No list to maintain. |
| **Location** | `$CBASH_DATA_DIR` or default `~/.cbash`. Override in config file. |
| **When copied** | **`tools/install.sh`** copies every file under `templates/` to `$CBASH_DATA_DIR` when you install or update, **only if the destination does not exist** (never overwrite). |
| **Plugin priority** | Plugins use: 1) env/config path if set, 2) file in global dir if present, 3) repo `templates/` file. |

Example: `templates/dev/development.yml` → after install, `~/.cbash/dev/development.yml`. Edit `~/.cbash/dev/development.yml` for your stack; repo updates don't change it.

---

## Variable reference

Plugins read these if set; otherwise they use the default in the table.

**Paths**

| Variable | Used by | Default |
|----------|---------|---------|
| `CBASH_DATA_DIR` | install.sh, dev | `~/.cbash` (global template copies) |
| `CBASH_DEV_COMPOSE_FILE` | dev | (none) → then `$CBASH_DATA_DIR/dev/development.yml` if present → else `$CBASH_DIR/templates/dev/development.yml` |
| `CBASH_GIT_DEFAULT_REPO_LIST` | git | (none) |
| `CBASH_GIT_DEFAULT_PULL_DIR` | git | (none) |
| `DOCS_DIR` | docs | `$HOME/.config/cbash/docs` |

**Proxy**

| Variable | Used by | Default |
|----------|---------|---------|
| `CBASH_PROXY_DEFAULT_URL` | proxy | (none) |
| `CBASH_PROXY_NO_PROXY` | proxy | `127.0.0.1,localhost` |

**AWS (SSM, SSH gateway, LocalStack)**

| Variable | Used by | Default |
|----------|---------|---------|
| `AWS_SSM_REGION` | aws | `ap-southeast-1` (SSM/SSH region) |
| `AWS_LOCALSTACK_ENDPOINT` | aws | `http://localhost:4566` (SQS local) |
| `CBASH_AWS_SSH_TARGET_PREFIX` | aws | `ssh-gateway` (SSM target name prefix) |
| `CBASH_AWS_SSH_ENVS` | aws | `dev test staging production` (allowed envs for `aws ssh`) |

**AI (Ollama)**

| Variable | Used by | Default |
|----------|---------|---------|
| `CBASH_AI_DEFAULT_MODEL` | ai | `deepseek-r1:14b` |

**Other**

| Variable | Used by | Default |
|----------|---------|---------|
| `K8S_NAMESPACE` | k8s | `default` |

---

## Example: ~/.cbashrc

```bash
# CBASH CLI config (sourced by cbash at startup)

# Paths
# export CBASH_DATA_DIR="$HOME/.cbash"
export CBASH_DEV_COMPOSE_FILE="$HOME/.cbash/dev/development.yml"
# export CBASH_GIT_DEFAULT_PULL_DIR="$HOME/repos"

# Proxy
# export CBASH_PROXY_DEFAULT_URL="http://proxy:8080"

# AWS
# export AWS_SSM_REGION="us-east-1"
# export CBASH_AWS_SSH_TARGET_PREFIX="bastion"

# AI (Ollama)
# export CBASH_AI_DEFAULT_MODEL="llama3.2"
```
