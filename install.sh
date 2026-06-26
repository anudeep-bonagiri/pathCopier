#!/bin/bash
#
# install.sh - install the "Copy Relative Path" Finder Quick Action.
#
# Copies the Quick Action into ~/Library/Services and refreshes the macOS
# Services registry so it appears in Finder's right-click menu immediately.
#
# Usage:
#   ./install.sh
#
# Or straight from GitHub (no clone needed):
#   curl -fsSL https://raw.githubusercontent.com/USER/copy-relative-path/main/install.sh | bash

set -euo pipefail

WORKFLOW="Copy Relative Path.workflow"
SERVICES_DIR="$HOME/Library/Services"
DEST="$SERVICES_DIR/$WORKFLOW"

# Resolve the directory this script lives in.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/$WORKFLOW"

# If run via `curl | bash`, the bundle is not local - fetch the repo tarball.
if [ ! -d "$SRC" ]; then
  echo "Quick Action not found locally; downloading from GitHub..."
  TMP="$(mktemp -d)"
  REPO_TARBALL="https://github.com/USER/copy-relative-path/archive/refs/heads/main.tar.gz"
  curl -fsSL "$REPO_TARBALL" | tar -xz -C "$TMP"
  SRC="$(find "$TMP" -type d -name "$WORKFLOW" | head -1)"
  if [ -z "$SRC" ]; then
    echo "Error: could not locate the Quick Action in the download." >&2
    exit 1
  fi
fi

mkdir -p "$SERVICES_DIR"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

# Refresh the Services menu so it shows up without a logout.
/System/Library/CoreServices/pbs -flush 2>/dev/null || true

echo "Installed: $DEST"
echo
echo "Right-click any file or folder in Finder, then:"
echo "  Quick Actions  ->  Copy Relative Path"
echo
echo "Tip: assign a keyboard shortcut in"
echo "  System Settings -> Keyboard -> Keyboard Shortcuts -> Services."
