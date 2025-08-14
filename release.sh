#!/bin/sh

set -euo pipefail

NEW_VERSION=$(cat VERSION)
TAG="v$NEW_VERSION"

git push origin --tags

if command -v gh >/dev/null 2>&1; then
  gh release create "$TAG" -t "$TAG" -n "Release $TAG"
  echo "GitHub release created: $TAG"
else
  echo "gh CLI not installed: tag pushed only."
fi
