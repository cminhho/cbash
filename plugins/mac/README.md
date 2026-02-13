# mac

This plugin provides macOS system utilities including system info, network tools,
file operations, and software updates.

To use it, the plugin is automatically loaded by CBASH. No additional configuration required.

## Plugin commands

* `cbash mac info`: displays macOS version information using `sw_vers`.

* `cbash mac lock`: locks the screen immediately.

* `cbash mac speedtest`: tests internet connection speed using macOS built-in `networkQuality`.

* `cbash mac memory`: shows processes sorted by memory usage using `top`.

* `cbash mac ports`: lists all listening TCP ports. Requires sudo.

* `cbash mac ip-local`: shows local IP address from en0 or en1 interface.

* `cbash mac ip-public`: shows public IP address using ipinfo.io.

* `cbash mac users`: lists all system users with their UIDs.

* `cbash mac size`: shows current directory size.

* `cbash mac tree`: lists subdirectories sorted by size (largest first).

* `cbash mac clean-empty`: finds and removes empty directories. Prompts for confirmation.

* `cbash mac find <text> <ext>`: searches for text in files with given extension.
  Interactively prompts if arguments not provided.

* `cbash mac replace <file> <search> <replace>`: replaces text in a file.
  Interactively prompts if arguments not provided.

* `cbash mac update`: updates Homebrew, npm global packages, and pip packages.

## Prerequisites

Most commands use built-in macOS tools. Optional dependencies:

- `brew` - Required for update command
- `npm` - Optional, updated if available
- `pip3` - Optional, updated if available

## Examples

Check macOS version:

```bash
cbash mac info
```

Test internet speed:

```bash
cbash mac speedtest
```

Find all occurrences of "TODO" in Python files:

```bash
cbash mac find TODO py
```

List folders by size:

```bash
cbash mac tree
```

Update all package managers:

```bash
cbash mac update
```

## Troubleshooting

**Permission denied on ports:**
```bash
# ports command requires sudo
cbash mac ports
```

**speedtest not working:**
- Requires macOS 12 (Monterey) or later
- `networkQuality` is built into macOS

**update fails:**
- Ensure Homebrew is installed: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
