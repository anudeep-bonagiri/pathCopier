# Copy Relative Path

A tiny, free Finder add-on for macOS. Right-click any file or folder and copy its
**relative path** to the clipboard, ready to paste into code, a README, or a terminal.

macOS already ships with *Copy as Pathname* (right-click and hold Option), but it
only gives you the full absolute path:

```
/Users/you/projects/my-app/src/components/Button.tsx
```

This gives you the path you actually want to paste:

```
src/components/Button.tsx
```

## What "relative" means here

1. If the item is inside a **git repository**, the path is relative to the repo root.
2. If it is not in a git repo but is under your home folder, you get a `~`-relative path
   (`~/Documents/notes.md`).
3. Otherwise it falls back to the absolute path.

Select multiple items and it copies one path per line.

## Install

### Option A: double-click (no terminal)

1. [Download the latest release](../../releases) and unzip it.
2. Double-click **`Copy Relative Path.workflow`**.
3. macOS asks to install it. Click **Install**.

That's it. Right-click a file in Finder and look under **Services → Copy Relative Path**.

> If macOS says it's from an unidentified developer, right-click the `.workflow`
> and choose **Open**, then confirm. It only needs this once.

> **Why "Services" and not "Quick Actions"?** On current macOS the right-click
> *Quick Actions* submenu is reserved for signed app extensions; user-installed
> Automator actions like this one live under the *Services* submenu instead. Same
> result, one submenu over. (A signed version that lands in Quick Actions is on the
> roadmap.)

### Option B: terminal (one line)

```bash
git clone https://github.com/anudeep-bonagiri/pathCopier.git
cd pathCopier && ./install.sh
```

## Use it

Right-click any file or folder in Finder:

```
Services  ->  Copy Relative Path
```

A notification confirms the copy. Paste anywhere.

**Optional keyboard shortcut:** System Settings → Keyboard → Keyboard Shortcuts →
Services → find *Copy Relative Path* and assign a key (e.g. ⌃⌥⌘C).

## Use it from the terminal too

The same logic is a standalone script:

```bash
./copy-relative-path.sh path/to/file.txt           # copies repo-relative path
./copy-relative-path.sh src/*.ts                    # multiple files, one per line
```

## Uninstall

```bash
./uninstall.sh
```

…or delete `~/Library/Services/Copy Relative Path.workflow`.

## How it works

It's a macOS Automator **Service** (the `.workflow` bundle) that runs a small bash
script on the selected items and pipes the result to `pbcopy`. No background process,
no network access, no dependencies beyond what macOS already has. Read the whole thing
in [`copy-relative-path.sh`](copy-relative-path.sh). It's about 30 lines.

## License

[MIT](LICENSE). Free to use, modify, and share.
