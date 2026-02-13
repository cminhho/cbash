# cheat — Cheatsheet viewer

View and manage command-line cheatsheets. Uses community sheets (from [cheat/cheatsheets](https://github.com/cheat/cheatsheets)) and personal sheets. Source CBASH to get aliases.

## Commands

| Command | Description |
|---------|-------------|
| `cbash cheat` / `help` | Show help |
| `cbash cheat aliases` | List aliases |
| `cbash cheat <name>` | View cheatsheet (searches personal then community) |
| `cbash cheat list` | List available cheatsheets (community + personal) |
| `cbash cheat edit <name>` | Edit or create personal cheatsheet |
| `cbash cheat setup` | Download or update community cheatsheets |
| `cbash cheat conf` | Show cheatpaths config (for cheat CLI) |

## Aliases

| Alias | Command |
|-------|--------|
| `ch <name>` | View cheatsheet (ch git, ch docker) |
| `chlist` | cheat list |
| `chsetup` | cheat setup |
| `chedit <name>` | cheat edit |
| `chconf` | cheat conf |

## Configuration

```bash
export CHEAT_COMMUNITY_DIR="$HOME/.config/cbash/cheatsheets/community"  # default
export CHEAT_PERSONAL_DIR="$HOME/.config/cbash/cheatsheets/personal"     # default
```

## Prerequisites

None. Uses `cat` and optional `$EDITOR` (default vim) for edit. Community sheets are cloned via git.

## Examples

```bash
chsetup                    # download community cheatsheets first
ch git
ch docker
chlist
chedit my-notes
cbash cheat aliases
```
