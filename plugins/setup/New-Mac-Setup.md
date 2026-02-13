# New Mac Setup

Step-by-step setup for a new MacBook. Follow in order.

**Prerequisite for Step 5:** Homebrew must be installed (see [Manual — Homebrew](#manual--homebrew) at the bottom).

---

## Step 1 — System preferences (optional)

Open **System Preferences** (or **System Settings**). Set:

- **Mouse** → Tracking speed: Fast  
- **Trackpad** → Uncheck "Natural" scroll  
- **Dock** → Size: Small, Magnification: On  
- **General** → Appearance: Auto (light/dark)

---

## Step 2 — Xcode Command Line Tools

Open **Terminal**. Run:

```bash
xcode-select --install
```

Click **Install** in the dialog and wait.

---

## Step 3 — CBASH CLI

Open **Terminal**. Run:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
source ~/.zshrc
```

Confirm: run `cbash` and you should see help.

---

## Step 4 — Workspace

Open **Terminal**. Create workspace (e.g. `~/workspace` or `~/dev`):

```bash
cbash gen workspace workspace
# or: cbash gen workspace dev
```

Structure created:

```
~/workspace/
├── README.md   .gitignore
├── repos/      (company, personal, open-source, labs)
├── documents/  (company, personal, learning, career)
├── artifacts/  (maven, docker, node, venv, iso-vms)
├── archive/    (e.g. 2025)
├── tmp/
└── downloads/
```

---

## Step 5 — Development tools

Open **Terminal**. Run (uses `cbash setup brew` — requires Homebrew, see Manual below):

```bash
cbash setup brew all
```

If you use Node: `nvm install stable`

---

## Step 6 — Git configuration

Open **Terminal**.

Name and email:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

SSH key:

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

Add key: **GitHub** → **Settings** → **SSH and GPG keys** → **New SSH key** → paste and save.

---

## Step 7 — Verify

Open **Terminal**. Run:

```bash
cbash setup check
```

Confirm Git, Node/Python/Docker (if used), and Git name/email.

---

# Manual — Homebrew

Do this after Step 2 (Xcode CLI). You need Homebrew before Step 5 (Development tools).

Open **Terminal**. Run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

On Apple Silicon, then run:

```bash
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew tap homebrew/cask
brew tap buo/cask-upgrade
brew doctor
```
