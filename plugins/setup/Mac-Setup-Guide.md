# Mac Setup Guide

New Mac setup workflow - follow steps in order.

---

## 1. System Preferences

```
System Preferences > Mouse         → Tracking speed: Fast
System Preferences > Trackpad      → Uncheck "Natural" scroll
System Preferences > Dock          → Size: Small, Magnification: On
System Preferences > General       → Appearance: Auto (light/dark)
```

---

## 2. Homebrew

```bash
# Install Xcode CLI tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to PATH (Apple Silicon)
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup cask
brew tap homebrew/cask
brew tap buo/cask-upgrade
brew doctor
```

---

## 3. CBASH CLI

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/cminhho/cbash/master/tools/install.sh)"
source ~/.zshrc
```

---

## 4. Development Tools

```bash
# Install all dev tools
cbash setup brew all

# Or install by group:
cbash setup brew dev    # Shell, Git, Node, Python, Java, DB
cbash setup brew cloud  # AWS, Terraform, Docker
cbash setup brew ide    # VS Code, IntelliJ, Postman
cbash setup brew apps   # Chrome, Slack, Teams, Zoom, Notion
```

---

## 5. Workspace

```bash
cbash setup workspace
```

Creates:
```
~/workspace/
├── projects/
├── tools/
├── docs/
├── scripts/
└── sandbox/
```

---

## 6. Git Config

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# Paste to GitHub > Settings > SSH Keys
```

---

## 7. Dotfiles

```bash
cbash setup dotfiles
```

---

## 8. Verify

```bash
cbash setup check
```

---

# Manual Reference

## Development Setup (Manual)

```bash
brew install tree
brew install zsh
brew install zsh-completions
brew install devtoys
brew install wget
brew install git
brew install curl
brew install openssl

# DevOps
brew install bash-completion
brew install awscli

# Frontend Dev Tools
brew install nvm
brew install pnpm
nvm install stable

# Python Backend Dev Tools
brew install python
pip install --user pipenv
pip install --upgrade setuptools
pip install --upgrade pip
brew install pyenv
brew install --cask pycharm-ce

# Java Backend Dev Tools
brew install --cask intellij-idea-ce
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask postman
brew install --cask mockoon
brew install --cask dbeaver-community
brew install --cask notion
brew install --cask zoom
brew install --cask slack
brew install --cask intellij-idea-ce
brew install --cask nosql-workbench
brew install --cask --appdir="/Applications" slack
brew install --cask --appdir="/Applications" zoom
brew install --cask --appdir="/Applications" microsoft-teams

# Microsoft Outlook
brew install mas
mas install 985367838
```

## Chrome Extensions

- [Bitwarden](https://chrome.google.com/webstore/detail/bitwarden)
- [Notion Web Clipper](https://chrome.google.com/webstore/detail/notion-web-clipper)
