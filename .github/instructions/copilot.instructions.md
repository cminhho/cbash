# cbash-cli Codebase Patterns

**Always reuse existing code - no redundancy!**

## Tech Stack

- **Runtime**: Bash 4.0+ or Zsh
- **Language**: Shell (Bash/Zsh–compatible scripts)
- **Lint**: shellcheck on all bash scripts
- **Entry**: `cbash.sh` (sources `lib/common.sh`, then routes to plugins)
- **Plugins**: One directory per plugin under `plugins/<name>/` with `<name>.plugin.sh` and optional `<name>.aliases.sh`

## Anti-Redundancy Rules

- Do not duplicate helpers that already exist in `lib/`. Use `lib/common.sh`, `lib/cli.sh`, `lib/help.sh`, `lib/log.sh`, `lib/colors.sh`.
- If a pattern exists in another plugin, reuse or generalize it instead of copying.
- Before adding a new utility or alias, search for an existing implementation in `lib/` or other plugins.

## Source of Truth Locations

### Shared Library (`lib/`)

- **Common helpers**: `lib/common.sh`
- **CLI/help**: `lib/cli.sh`, `lib/help.sh`
- **Logging / colors**: `lib/log.sh`, `lib/colors.sh`

**Do not create local copies of logging or color helpers - use the lib modules.**

### Plugins (`plugins/<name>/`)

- Entry: `<name>.plugin.sh` with `_main()` function
- Aliases: `<name>.aliases.sh` (optional, sourced into shell)
- Docs: `README.md` (optional)
- New plugins: start from `templates/plugin.template.sh`

### Install / Upgrade (`tools/`)

- Install: `tools/install.sh`
- Uninstall: `tools/uninstall.sh`
- Upgrade: `tools/upgrade.sh`
- Shared logic: `tools/common.sh`

## Plugin Conventions

- One plugin directory per capability (git, docker, k8s, aws, gen, docs, ai, macos, proxy, npm, mvn, dev, setup, aliases).
- Entry point: `_main()` in `<name>.plugin.sh`; no need to source `lib/common.sh` yourself - `cbash.sh` does it.
- Aliases live in a separate `.aliases.sh` file.

## Code Quality

- Run `shellcheck` on all `*.plugin.sh` and `*.sh` in `lib/` and `tools/`.
- Quote variables: `"$var"`
- Use meaningful function and variable names; add comments for complex logic.
- Handle errors (e.g. `set -e` where appropriate, check exit codes).
- Test on both Bash and Zsh when touching shared code.

## Commands

- **Lint**: `shellcheck plugins/*/*.plugin.sh lib/*.sh tools/*.sh`
- **Tests**: `./test/verify_commands.sh`
- **New plugin**: Copy `templates/plugin.template.sh` to `plugins/<name>/<name>.plugin.sh`

When coding with a human, run the above commands manually to ensure quality before committing.
