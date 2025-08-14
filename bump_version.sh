#!/bin/sh

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 major|minor|patch"
  exit 1
fi

TYPE=$1
VERSION_FILE="VERSION"

if [ ! -f "$VERSION_FILE" ]; then
  echo "0.1.0" > "$VERSION_FILE"
fi

OLD=$(cat "$VERSION_FILE")
IFS='.' read -r MAJ MIN PATCH <<< "$OLD"

case $TYPE in
  major)
    MAJ=$((MAJ + 1))
    MIN=0
    PATCH=0
    ;;
  minor)
    MIN=$((MIN + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    echo "Unknown version level: $TYPE"
    exit 1
    ;;
esac

NEW="$MAJ.$MIN.$PATCH"
echo "$NEW" > "$VERSION_FILE"
git add "$VERSION_FILE"
git commit -m "Bump version to $NEW" || true
git tag -a "v$NEW" -m "Release v$NEW"
echo "Version bumped: $OLD -> $NEW"
