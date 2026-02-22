# Contributing to cbash-cli

Thank you for your interest in contributing!

## Quick Start

1. Fork the repository
2. Clone your fork: `git clone https://github.com/cminhho/cbash.git ~/.cbash`
3. Create a branch: `git checkout -b feature-name`
4. Make your changes
5. Test your changes
6. Submit a pull request

## Code Style

- Run `shellcheck` on all bash scripts
- Follow existing code patterns
- Use meaningful function and variable names
- Add comments for complex logic
- Quote variables: `"$variable"`
- Handle errors properly

### Plugin Structure

Plugins are convention-based: one directory per plugin.

```
plugins/<name>/
├── <name>.plugin.sh   # Commands and router (required)
├── <name>.aliases.sh  # Shell aliases (optional, sourced into shell)
└── README.md          # Documentation (optional)
```

**Key points:**
- Entry point: `<name>.plugin.sh` with `_main()` function
- No need to source `lib/common.sh` - cbash.sh handles it
- Aliases go in separate `.aliases.sh` file
- Use `templates/plugin.template.sh` as starting point

## Testing

Run the same checks as CI locally before pushing:

```bash
./tools/check.sh
```

This runs: **shellcheck** (plugins, lib, tools), **verify_commands** (test suite), and **actionlint** (workflow files). Install once:

- **shellcheck** (required for lint): `brew install shellcheck` (macOS) or `apt install shellcheck` (Linux)
- **actionlint** (optional, for workflow lint): `brew install actionlint` (macOS)

Or run individual steps:

```bash
./test/verify_commands.sh              # Run all tests
shellcheck plugins/*/*.plugin.sh lib/*.sh tools/*.sh   # Lint scripts
actionlint -config-file .github/actionlint.yaml        # Lint workflows (if installed)
```

- Test on clean environment
- Test with bash and zsh
- Verify no hardcoded credentials

## Pull Requests

- Use clear commit messages
- Keep PRs focused on one feature/fix
- Update documentation if needed
- Respond to review feedback

## Versioning and releases

- **Single source of truth:** `VERSION` in the repo root (one line, e.g. `1.0.0`). The CLI reads it at startup; no version strings in code.
- **SemVer:** MAJOR.MINOR.PATCH. Bump MAJOR for breaking changes, MINOR for new features, PATCH for fixes.
- **Release:** Update `VERSION`, commit, then tag: `git tag v1.0.0` and `git push origin v1.0.0`. Homebrew/install scripts can use the tag.
- **Version commands:** `cbash -v`, `cbash --version`, and `cbash cli version` (latter appends git describe when run from a repo).

## Reporting Issues

Open an issue with:
- Clear description
- Steps to reproduce
- Environment info (OS, shell, cbash version)
- Error messages

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Provide constructive feedback
- Accept responsibility for mistakes

## License

Contributions will be licensed under the MIT License.

---

Thank you for contributing! 🎉
