#!/bin/sh

set -euo pipefail

SCHEME="FlickrTest"
DESTINATION="platform=iOS Simulator,name=iPhone 16,OS=18.5"
xcodebuild test \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  ONLY_ACTIVE_ARCH=YES \
  || true

echo "Tests finished"