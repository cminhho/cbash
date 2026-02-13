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

Plugins are convention-based: one directory per plugin, one entry script per plugin. No `commands/` subfolder.

```
plugins/your-plugin/
├── README.md
└── your-plugin.plugin.sh
```

- Entry point: `plugins/<name>/<name>.plugin.sh` (required). It receives subcommand as first arg and rest as `"$@"`.
- Optional: extra scripts or assets in the same directory (e.g. `plugins/aliases/*.sh`, `plugins/dev/development.yml`).
- Custom plugins: same layout under `custom/plugins/<name>/`.

## Testing

Test your changes before submitting:
- Test on clean environment
- Test with bash and zsh
- Run `shellcheck` on modified scripts
- Verify no hardcoded credentials

## Pull Requests

- Use clear commit messages
- Keep PRs focused on one feature/fix
- Update documentation if needed
- Respond to review feedback

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
