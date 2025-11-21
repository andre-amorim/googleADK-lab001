#!/usr/bin/env bash
set -euo pipefail

BRANCH=${1:-feat/multi-system-devshells}
BASE=${2:-main}
TITLE=${3:-"feat(dev): multi-system dev shells, scripts & CI"}
BODY=${4:-"This PR adds multi-arch dev shells, a convenient `scripts/dev` wrapper that creates/activates a uv venv, zsh support in dev shells, and CI validation on Ubuntu/macOS."}

if command -v gh >/dev/null 2>&1; then
  echo "Creating PR via GitHub CLI..."
  gh pr create --base "$BASE" --head "$BRANCH" --title "$TITLE" --body "$BODY" || true
else
  echo "GitHub CLI (gh) not found. Please open PR manually at:"
  echo "https://github.com/andre-amorim/googleADK-lab001/pull/new/$BRANCH"
fi
