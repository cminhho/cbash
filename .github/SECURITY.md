# Security Policy

## Scope

cbash-cli is a **local** CLI—shell scripts only, no backend. Security focus: credentials, plugin code you run, and what you source.

## Reporting a Vulnerability

Do **not** open a public issue. Contact maintainers privately with:
- Description of the vulnerability
- Steps to reproduce
- Impact (e.g. credential leak, arbitrary command execution)

We aim to respond within 48 hours.

## Security Best Practices

### Credentials
- Never commit credentials, API keys, or tokens to repo or custom plugins
- Use environment variables; prefer AWS SSO/IAM over static keys
- Do not log or echo secrets

### File permissions (AWS plugin)
If you use the AWS plugin with credential files:
```bash
chmod 600 ~/.aws/credentials
```

### Plugins
- Plugins run with your user permissions—review code before use
- Audit `custom/plugins/` for hardcoded secrets and safe commands
- Replace all placeholders in config templates; remove sample credentials

### Installation
- Prefer: clone → review (`cbash.sh`, plugins you use) → run installer
```bash
git clone https://github.com/cminhho/cbash.git ~/.cbash
cd ~/.cbash && ./tools/install.sh
```
- One-liner install runs code without prior review—use only from a trusted source

### Updates
```bash
cbash cli update
```
