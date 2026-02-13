# proxy — Proxy settings manager

Enable or disable HTTP/HTTPS proxy for current shell, npm, and git. Source CBASH to get aliases.

## Commands

| Command | Description |
|---------|-------------|
| `cbash proxy` / `help` | Show help |
| `cbash proxy aliases` | List aliases |
| `cbash proxy enable [url]` | Enable proxy (prompts for URL if omitted). Sets env vars and npm/git config. |
| `cbash proxy disable` | Unset proxy in env, npm, and git |
| `cbash proxy show` | Show current proxy (env, npm, git) |

## Aliases

| Alias | Command |
|-------|--------|
| `proxon [url]` | proxy enable |
| `proxoff` | proxy disable |
| `proxshow` | proxy show |

## Configuration

```bash
export HTTP_PROXY_URL="http://proxy:8080"   # optional default when enabling
export NO_PROXY_LIST="127.0.0.1,localhost"  # optional no_proxy value
```

## Examples

```bash
proxon                          # prompt for URL
proxon http://proxy.company:8080
proxoff
proxshow
cbash proxy aliases
```
