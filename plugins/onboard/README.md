# onboard

Step-by-step onboarding in industry order: **1) Environment check → 2) Global templates (dotfiles, dev, …) → 3) Workspace → 4) Tools (optional, brew)**. Integrates with the **setup** plugin. Templates are copied from `templates/` to `~/.cbash/` (no overwrite).

## Usage

| Command | Description |
|---------|-------------|
| `cbash onboard` | **Quick setup (default):** run check + create default workspace. Safe: skips if already onboarded unless `--force`. |
| `cbash onboard --interactive` / `cbash onboard -i` | Wizard: check, then prompt for workspace creation and tool installation. If already onboarded, offers **Full** (re-run all) or **Tools only** (install/update brew packages). |
| `cbash onboard --force` / `cbash onboard -f` | Re-run onboarding even when already completed. |
| `cbash onboard --workspace-only` | Only run check + create default workspace (no sentinel, no tools). |
| `cbash onboard --tools-only` / `cbash onboard --brew-only` | Only run check + install dev tools via `setup brew dev`. |
| `cbash onboard welcome` | Show welcome and quick start. |
| `cbash onboard check` | Verify CBASH_DIR, Git, and shell. |
| `cbash onboard guide` | Print short usage guide. |

## Safety behavior

- **Already onboarded:** Completion is recorded in `~/.cbash-onboard-done`. If this file exists and you run `cbash onboard` (non-interactive, no flags), onboarding **refuses** and suggests `--force` or `--interactive`.
- **Interactive and already onboarded:** You get two modes: **Full onboarding** (check + workspace + tools again) or **Tools only** (update Homebrew packages, keep rest).
- **`--force`:** Ignores the sentinel and re-runs the requested steps.

## Steps (order)

| Step | Description |
|------|-------------|
| **1** | Environment check — CBASH_DIR, Git, shell |
| **2** | Global templates — copy `templates/` (dotfiles, dev, …) to `~/.cbash/`; never overwrites existing |
| **3** | Workspace — create default workspace via `setup workspace` |
| **4** | Tools (optional) — install dev tools via `setup brew dev` |

## What runs

- **Default (`cbash onboard`):** Step 1 → Step 2 → Step 3 → mark onboarded. Step 4 via `--interactive` or `--tools-only`.
- **`--interactive`:** Step 1 → Step 2 → prompt workspace (3) → prompt brew (4) → mark onboarded.
- **`--workspace-only`:** Step 1 → Step 2 → Step 3 only.
- **`--tools-only`:** Step 1 → Step 2 → Step 4 only.

Templates are also copied by **`tools/install.sh`** at install; onboard ensures they exist even when cbash was not installed via the script.

## Examples

```bash
cbash onboard                    # First-time quick setup
cbash onboard --interactive      # Wizard: choose workspace + tools
cbash onboard --force             # Re-run full quick setup
cbash onboard --workspace-only   # Only check + workspace
cbash onboard --tools-only       # Only check + brew dev
cbash onboard welcome            # Intro message
cbash onboard check              # Verify env only
cbash onboard guide              # Short command guide
```
