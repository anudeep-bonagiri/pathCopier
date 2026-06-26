#!/bin/bash
#
# copy-relative-path.sh
#
# Copies the git-root-relative path of each file/folder argument to the
# clipboard, one per line. When an item is not inside a git repository it
# falls back to a ~-relative path, and finally to the absolute path.
#
# This same script is embedded inside the "Copy Relative Path" Finder Quick
# Action. It also works standalone from the terminal:
#
#     ./copy-relative-path.sh path/to/file ...
#
# Finder passes the selected items as arguments ("$@").

set -u

out=""
for f in "$@"; do
  # Resolve the git top-level for the file's directory, if any.
  dir=$(dirname "$f")
  root=$(cd "$dir" 2>/dev/null; git rev-parse --show-toplevel 2>/dev/null)

  if [ -n "$root" ] && [ "$f" != "$root" ]; then
    rel=${f#"$root"/}
  else
    case "$f" in
      "$HOME"/*) rel="~${f#"$HOME"}" ;;
      "$HOME")   rel="~" ;;
      *)         rel=$f ;;
    esac
  fi

  if [ -z "$out" ]; then
    out=$rel
  else
    out=$out$'\n'$rel
  fi
done

printf %s "$out" | pbcopy

# Lightweight confirmation so the user knows the copy happened.
n=$#
osascript -e "display notification \"Copied $n path(s) to clipboard\" with title \"Copy Relative Path\"" 2>/dev/null

# Also echo to stdout for terminal / debugging use.
printf '%s\n' "$out"
