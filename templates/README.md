# templates

Template files copied to the global data dir (`$CBASH_DATA_DIR`, default `~/.cbash`) when you run `tools/install.sh`. Layout here mirrors the destination: e.g. `dev/development.yml` → `~/.cbash/dev/development.yml`.

- **Add a template:** put the file under `templates/<plugin>/` (or any path). Install will copy it on next run (no overwrite).
- **Plugin usage:** plugins prefer 1) env/config path, 2) file in `$CBASH_DATA_DIR`, 3) repo fallback `$CBASH_DIR/templates/...`.
