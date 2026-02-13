# {{WORKSPACE_NAME}}

Developer workspace. Organize by ownership to avoid license and Git account confusion.

## repos/ (Developer heart)

| Folder | Purpose |
|--------|---------|
| `company/` | Current employer projects (optionally subdivide by client-a, client-b) |
| `personal/` | Personal projects, own startup |
| `open-source/` | Forks from community repos for contributing |
| `labs/` | Learning code, tutorials, trying new frameworks |

## documents/ (Knowledge & admin)

| Folder | Purpose |
|--------|---------|
| `company/` | Contracts, payroll, insurance, internal processes |
| `personal/` | Personal ID, finance, health docs |
| `learning/` | E-books, cheat-sheets, certificates |
| `career/` | CV versions, portfolio, interview prep |

## artifacts/ (Storage — keep disk clean)

Point tools here instead of default system/home paths.

| Folder | Purpose |
|--------|---------|
| `maven/` | `.m2/repository` — avoid re-downloading Java deps |
| `docker/` | Container volumes, DB data |
| `node/` | npm cache or shared node_modules |
| `venv/` | Python virtual environments |
| `iso-vms/` | OS install images, VM disks (VMware/VirtualBox) |

## archive/ (Project archive)

When a project ends, zip it and move here. One folder per year: `2024/`, `2025/`, …

## tmp/ & downloads/

| Folder | Purpose |
|--------|---------|
| `tmp/` | Quick export files (.json, .sql) for inspection |
| `downloads/` | Browser downloads |

---

Add to `.gitignore`: `artifacts/`, `downloads/`, `tmp/` (and `repos/`, `documents/` if private).
