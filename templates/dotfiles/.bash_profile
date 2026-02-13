# Bash Profile - Development Environment
# ============================================================================

# Workspace
export WORKSPACE_ROOT="$HOME/workspace"

# CBASH CLI
export CBASH_DIR="$HOME/.cbash"
[ -f "$CBASH_DIR/cbash.sh" ] && source "$CBASH_DIR/cbash.sh"

# Python
alias python="python3"
alias pip="pip3"

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 17 2>/dev/null || echo "")
[ -n "$JAVA_HOME" ] && export PATH="$JAVA_HOME/bin:$PATH"

jv() {
    local version="$1"
    export JAVA_HOME=$(/usr/libexec/java_home -v "$version" 2>/dev/null)
    [ -n "$JAVA_HOME" ] && export PATH="$JAVA_HOME/bin:$PATH" && java -version
}

# Maven
export MAVEN_HOME="/usr/local/opt/maven"
[ -d "$MAVEN_HOME" ] && export PATH="$MAVEN_HOME/bin:$PATH"

# Node.js (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)" || true

# PATH
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

# Load secrets
[ -f "$HOME/.env.keys" ] && source "$HOME/.env.keys"

# Workspace Navigator
cdw() {
    case "$1" in
        repos) cd "$WORKSPACE_ROOT/repos" ;;
        tmp)   cd "$WORKSPACE_ROOT/tmp" ;;
        docs)  cd "$WORKSPACE_ROOT/documents" ;;
        *)     cd "$WORKSPACE_ROOT" ;;
    esac
}
