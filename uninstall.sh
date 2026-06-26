#!/bin/bash
#
# uninstall.sh - remove the "Copy Relative Path" Finder Quick Action.

set -euo pipefail

DEST="$HOME/Library/Services/Copy Relative Path.workflow"

if [ -d "$DEST" ]; then
  rm -rf "$DEST"
  /System/Library/CoreServices/pbs -flush 2>/dev/null || true
  echo "Removed: $DEST"
else
  echo "Not installed (nothing to remove)."
fi
