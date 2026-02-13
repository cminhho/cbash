# boilr

This plugin provides template generators for documentation and project scaffolding to maintain consistency across projects.

To use it, the plugin is automatically loaded by CBASH. No additional configuration required.

## Plugin commands

* `cbash boilr doc [type] [name]`: generates documentation from templates. The `[type]` can be one of:
  `troubleshooting`, `cab`, `note`, `adr`, `meeting`, `design`, `cab-review`, or `code-review`. If not provided,
  an interactive menu will prompt for selection. Documents are generated in
  `$WORKSPACE_TROUBLESHOOT/<year>/<date>/<name>/`.

## Prerequisites

No external dependencies required for documentation generation.

## Configuration

Set the workspace troubleshooting directory (optional):

```bash
export WORKSPACE_TROUBLESHOOT="/path/to/docs"
```

Default behavior uses the environment variable if set.

## Document Templates

### Troubleshooting (troubleshooting)
Documents technical issues and resolutions. Includes issue details, investigation steps, root cause
analysis, resolution, and preventive measures.

### Change Advisory Board (cab)
Change management documentation with planned changes, impact analysis, risk assessment, rollout/rollback
plans, and approval tracking.

### General Note (note)
Flexible note-taking template for quick documentation, knowledge sharing, and process documentation.

### Architecture Decision Record (adr)
Documents architectural decisions with context, proposed changes, consequences, alternatives, and
implementation details.

### Meeting Notes (meeting)
Captures technical meetings with metadata, attendees, agenda, discussion points, decisions, and
action items.

### Technical Design (design)
Comprehensive system/feature design with requirements, architecture, components, implementation plan,
security, testing, deployment, and risk assessment.

### CAB Review (cab-review)
Review documentation for Change Advisory Board submissions.

### Code Review (code-review)
Structured code review documentation template.

## Examples

Generate troubleshooting document:

```bash
cbash boilr doc troubleshooting auth-service-latency-spike
```

Generate ADR with interactive selection:

```bash
cbash boilr doc
# Select document type:
# 1) Troubleshooting (troubleshooting)
# 2) Change Advisory Board (cab)
# ...
# Selection (1-8): 4
# Document name: mysql-to-postgres-migration
```

Generate design document:

```bash
cbash boilr doc design user-analytics-system
```

## Output Structure

Documentation files are organized by date:

```
$WORKSPACE_TROUBLESHOOT/
├── 2024/
│   ├── 2024-02-12/
│   │   ├── auth-issue/
│   │   │   └── trouble.md
│   │   └── db-migration/
│   │       └── adr.md
│   └── 2024-02-13/
│       └── feature-design/
│           └── design.md
```

## Troubleshooting

**Template not found:**
- Verify template files exist in `$CBASH_DIR/plugins/boilr/templates/`
- Check template naming: `<type>.md`

**Directory creation failed:**
- Check `$WORKSPACE_TROUBLESHOOT` is set and writable
- Verify permissions on target directory

