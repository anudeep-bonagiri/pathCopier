# Copy Relative Path

Right-click a file on your Mac and copy its **short path** instead of the long one.

macOS can already copy the full path (right-click, hold the Option key):

```
/Users/you/projects/my-app/src/components/Button.tsx
```

This tool copies the short, useful part:

```
src/components/Button.tsx
```

That is the path you actually want to paste into code, notes, or a chat.

---

## Install (about 30 seconds)

1. [**Click here to download**](../../releases/latest), then open the downloaded `.zip` to unzip it.
2. Double-click the file named **Copy Relative Path.workflow**.
3. A box pops up. Click **Install**.

Done. There is nothing else to set up.

**If macOS shows a warning** that says the file is from an unidentified developer:
right-click the **Copy Relative Path.workflow** file, choose **Open**, then click **Open** again.
You only do this once. (It happens because the tool is free and not paid-signed by Apple.)

---

## How to use it

1. Right-click any file or folder in Finder.
2. Go to **Services** near the bottom of the menu.
3. Click **Copy Relative Path**.

A small notification confirms it copied. Now paste anywhere with Command + V.

Select several files first and it copies all their paths, one per line.

> **Want it faster?** You can give it a keyboard shortcut:
> System Settings > Keyboard > Keyboard Shortcuts > Services > find "Copy Relative Path".

---

## What exactly does it copy?

It picks the most useful short path automatically:

- Inside a code project (a git folder): the path from the project's top folder, like `src/app/main.py`.
- Anywhere else in your home folder: a path starting with `~`, like `~/Documents/notes.md`.
- Anywhere else: the full path.

---

## Remove it

Run this in Terminal:

```bash
./uninstall.sh
```

Or just delete this file:

```
~/Library/Services/Copy Relative Path.workflow
```

---

## For developers

Install from the terminal:

```bash
git clone https://github.com/anudeep-bonagiri/pathCopier.git
cd pathCopier && ./install.sh
```

Use the same logic as a standalone script:

```bash
./copy-relative-path.sh path/to/file.txt     # one file
./copy-relative-path.sh src/*.ts             # many files, one path per line
```

**How it works:** it is a macOS Automator Service (the `.workflow` folder) that runs a
small bash script on the selected files and copies the result with `pbcopy`. No
background app, no internet, no extra installs. The whole script is about 30 lines:
[`copy-relative-path.sh`](copy-relative-path.sh).

**Why "Services" and not "Quick Actions"?** On current macOS the Quick Actions submenu
only shows Apple-signed app extensions, so user-installed actions like this one appear
under Services instead. Same result, one menu over. A signed version that shows up under
Quick Actions is planned.

---

## License

[MIT](LICENSE). Free to use, change, and share.
