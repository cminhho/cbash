# CBASH Architecture

## Overview

```
cbash-cli/
├── cbash.sh              # Main entry point
├── lib/                  # Core libraries
│   ├── common.sh         # Shared utilities (logging, colors)
│   ├── help.sh           # Help system (minimal + full)
│   ├── colors.sh         # Terminal colors
│   └── cli.sh            # CLI management (update, version)
├── plugins/              # Feature plugins
│   └── <name>/
│       ├── <name>.plugin.sh    # Plugin logic
│       └── <name>.aliases.sh   # Plugin aliases
├── templates/            # Scaffolding templates
├── tools/                # Install/upgrade scripts
└── test/                 # Test suite
```

## Core Components

### Entry Point (`cbash.sh`)

- Detects shell (Bash/Zsh)
- Sets `CBASH_DIR` and `CBASH_VERSION`
- Auto-discovers and loads plugins
- Routes commands to plugins

### Plugin System

Each plugin is self-contained:

```bash
plugins/<name>/
├── <name>.plugin.sh      # Main logic + _main() router
└── <name>.aliases.sh     # Shell aliases (sourced on init)
```

**Plugin contract:**
- Must define `_main()` function
- Receives args from `cbash <plugin> <args...>`
- Uses `lib/common.sh` for logging

### Help System (`lib/help.sh`)

- `help_show()` — Minimal help (~35 commands)
- `help_show_full()` — Full help (~70 commands)
- Triggered by `cbash` or `cbash --full`

## Data Flow

```
User → cbash.sh → _run() → _plugin() → plugin.sh → _main()
                    ↓
              lib/common.sh (logging, colors)
```

## Adding a Plugin

1. Create `plugins/<name>/<name>.plugin.sh`
2. Define `_main()` with command router
3. Optionally add `<name>.aliases.sh`
4. Plugin auto-discovered on next `cbash` run
