# MacOS plugin

This plugin provides macOS system utilities including system info, network tools,
file operations, and software updates.

Loaded automatically when you source CBASH. Use `cbash macos` for commands and short aliases in your shell.

## Aliases

| Alias | Command |
|-------|--------|
| `mlock` | Lock screen |
| `minfo` | Show macOS version (sw_vers) |
| `mports` | List listening TCP ports (sudo) |
| `mip` | Show local IP (en0/en1) |
| `mipublic` | Show public IP |
| `mupdate` | Update Homebrew, npm, pip |
| `mspeedtest` | Test internet speed (networkQuality) |
| `mmemory` | Processes by memory (top) |
| `msize` | Current directory size |
| `mtree` | Subdirectories by size |
| `musers` | List system users |
| `mcleanempty` | Remove empty directories (prompt) |

## Plugin commands

* `cbash macos` / `cbash macos help`: show help.

* `cbash macos list`: list aliases.

* `cbash macos info`: macOS version (sw_vers).

* `cbash macos lock`: lock screen.

* `cbash macos speedtest`: internet speed (networkQuality).

* `cbash macos memory`: processes by memory usage.

* `cbash macos ports`: list listening TCP ports. Requires sudo.

* `cbash macos ip-local`: local IP (en0 or en1).

* `cbash macos ip-public`: public IP (ipinfo.io).

* `cbash macos users`: list system users with UIDs.

* `cbash macos size`: current directory size.

* `cbash macos tree`: subdirectories sorted by size.

* `cbash macos clean-empty`: find and remove empty directories (with confirmation).

* `cbash macos find <text> <ext>`: search text in files by extension.

* `cbash macos replace <file> <search> <replace>`: replace text in file.

* `cbash macos update`: update Homebrew, npm global, pip.

* `cbash macos ips`: show all local IP addresses (ifconfig/ip).

* `cbash macos myip`: show public IP (dnsomatic/dyndns/ipinfo fallbacks).

* `cbash macos passgen [n]`: generate random password (n words from dictionary, default 4).

`cbash misc` is an alias for `cbash macos` (misc commands merged into macos).

## Prerequisites

Most commands use built-in macOS tools. Optional:

- `brew` – for update
- `npm` – optional, updated if available
- `pip3` – optional, updated if available

## Examples

```bash
mlock              # lock screen
mip                # local IP
cbash macos update
cbash macos find TODO py
```

## Troubleshooting

**ports:** requires sudo.

**speedtest:** macOS 12 (Monterey) or later for `networkQuality`.

**update:** install Homebrew if needed: https://brew.sh
