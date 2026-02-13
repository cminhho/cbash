# gen — Structure and doc generator

Scaffold project layouts, feature folders, workspaces, and troubleshooting dirs; or generate docs from templates (ADR, CAB, meeting, design, etc.) into a dated path. One plugin for structure and doc generation.

Source CBASH to get aliases. Use `cbash gen` for commands.

## Commands

| Command | Description |
|---------|-------------|
| `cbash gen` / `help` | Show help |
| `cbash gen aliases` | List aliases |
| `cbash gen trouble [name]` | Create troubleshooting dir in cwd (default name: date). README + troubleshooting.log |
| `cbash gen feat [name]` | Create feature dir: docs, src, tests + README |
| `cbash gen workspace [name]` | Create `~/workspace/<name>` (projects, docs, tools, scripts) |
| `cbash gen project [name]` | Create project dir: src, tests, docs, scripts + README |
| `cbash gen doc [type] [name]` | Generate doc from template → `$WORKSPACE_TROUBLESHOOT/<year>/<date>/<name>/`. Prompts for type/name if omitted. |

## Aliases

| Alias | Command |
|-------|--------|
| `gtrouble` | gen trouble |
| `gfeat` | gen feat |
| `gws` | gen workspace |
| `gproject` | gen project |
| `gdoc` | gen doc (gdoc [type] [name]) |

## Doc types (gen doc / gdoc)

`troubleshooting`, `cab`, `note`, `adr`, `meeting`, `design`, `cab-review`, `code-review`. Set `WORKSPACE_TROUBLESHOOT` for output base. Templates in `$CBASH_DIR/plugins/gen/templates/`.

## Output structures

**trouble** (default name: `yyyy-mm-dd`):
```
<name>/
├── README.md           # Issue, Investigation, Root Cause, Resolution, Prevention
└── troubleshooting.log
```

**feat**:
```
<name>/
├── docs/
├── src/
├── tests/
└── README.md           # Overview, Requirements, Implementation
```

**workspace** (under `~/workspace/<name>`):
```
projects/
docs/
tools/
scripts/
```

**project**:
```
<name>/
├── src/
├── tests/
├── docs/
├── scripts/
└── README.md           # Getting Started, Development, Testing
```

## Configuration

```bash
export WORKSPACE_TROUBLESHOOT="/path/to/docs"   # required for gen doc / gdoc
```

## Examples

```bash
gtrouble                    # creates ./yyyy-mm-dd
gfeat auth-service
gws myworkspace
gproject api-gateway
gdoc design my-feature
gdoc adr mysql-to-postgres
cbash gen doc               # interactive: select type, enter name
cbash gen aliases
```
