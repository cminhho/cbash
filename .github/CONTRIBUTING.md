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

Test your changes before submitting:
```bash
./test/verify_commands.sh  # Run all tests (26 tests)
shellcheck plugins/*/*.plugin.sh  # Lint scripts
```

- Test on clean environment
- Test with bash and zsh
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
