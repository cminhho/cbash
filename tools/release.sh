#!/usr/bin/env bash
# Tag and push a release. Triggers .github/workflows/release.yml (GitHub Release + tarball).
# Usage:
#   ./tools/release.sh           # use version from VERSION, tag & push
#   ./tools/release.sh 1.2.0     # set VERSION to 1.2.0, commit, tag & push
# If master is protected: bump VERSION in a PR and merge, then run ./tools/release.sh (no arg).
# Options:
#   --dry-run   print commands only, do not commit/tag/push
#   --no-push   create tag locally but do not push
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
VERSION_FILE="$REPO_ROOT/VERSION"

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
RST='\033[0m'
err()  { printf "${RED}Error: %s${RST}\n" "$*" >&2; exit 1; }
ok()   { printf "${GREEN}%s${RST}\n" "$*"; }
warn() { printf "${YELLOW}%s${RST}\n" "$*"; }

DRY_RUN=
NO_PUSH=
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --no-push) NO_PUSH=1 ;;
    -*) err "Unknown option: $arg" ;;
  esac
done

# Version from first non-option argument or from VERSION file
VERSION_ARG=
for arg in "$@"; do
  case "$arg" in
    --dry-run|--no-push) ;;
    *) VERSION_ARG="$arg"; break ;;
  esac
done

cd "$REPO_ROOT" || exit 1

if [ -n "$VERSION_ARG" ]; then
  VERSION="$VERSION_ARG"
  # Semantic version-ish: digits.digits.digits
  if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    err "Version must be semver (e.g. 1.2.0), got: $VERSION"
  fi
  CURRENT="$(cat "$VERSION_FILE" 2>/dev/null || true)"
  if [ "$CURRENT" != "$VERSION" ]; then
    warn "Updating VERSION: $CURRENT -> $VERSION"
    if [ -z "$DRY_RUN" ]; then
      printf '%s\n' "$VERSION" > "$VERSION_FILE"
      git add "$VERSION_FILE"
      git commit -m "chore: bump VERSION to $VERSION"
    else
      echo "[dry-run] would write $VERSION to VERSION and commit"
    fi
  fi
else
  [ -f "$VERSION_FILE" ] || err "VERSION file not found and no version given. Usage: $0 [version]"
  VERSION="$(cat "$VERSION_FILE" | tr -d '[:space:]')"
  [ -n "$VERSION" ] || err "VERSION file is empty"
fi

TAG="v${VERSION}"
if git rev-parse "$TAG" &>/dev/null; then
  err "Tag $TAG already exists. Delete with: git tag -d $TAG (and on remote: git push origin :refs/tags/$TAG)"
fi

if [ -z "$DRY_RUN" ]; then
  # Uncommitted changes after possible VERSION commit
  if ! git diff --quiet HEAD; then
    err "Working tree has uncommitted changes. Commit or stash first."
  fi
fi

ok "Release $TAG (from VERSION: $VERSION)"
if [ -n "$DRY_RUN" ]; then
  echo "  git tag $TAG"
  [ -z "$NO_PUSH" ] && echo "  git push origin HEAD && git push origin $TAG"
  exit 0
fi

git tag "$TAG"
ok "Tag $TAG created."

if [ -z "$NO_PUSH" ]; then
  if ! git push origin HEAD 2>/dev/null; then
    warn "Branch push skipped (e.g. protected branch). Pushing tag only."
  fi
  git push origin "$TAG"
  ok "Pushed $TAG. GitHub Actions will create the release."
else
  warn "Not pushing (--no-push). Run: git push origin HEAD && git push origin $TAG"
fi
