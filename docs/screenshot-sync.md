# Screenshot sync (Marceline → Asura)

Mutagen mirrors `~/Downloads/Screenshots` between Marceline and Asura over
Tailscale SSH so a path dropped into a Mosh/Ghostty session on the Mac exists
on Asura. Asura already maps `/Users/seven` to `/home/seven`, so a dropped
`/Users/seven/Downloads/Screenshots/...` path resolves locally.

Transport is Tailscale only. When Tailscale is down, Mutagen sits in connecting
and retries. It does not delete local files because the other side is
unreachable.

## Architecture

```text
Marceline  ~/Downloads/Screenshots
  -> mutagen daemon (LaunchAgent)
    -> ssh asura  (Tailscale)
      -> ~/.mutagen/agents/<version>/mutagen-agent
        -> Asura  ~/Downloads/Screenshots
          -> /Users/seven -> /home/seven
```

The daemon and session live on Marceline. Asura only runs the agent Mutagen
installs over SSH. Sync is bidirectional (`two-way-resolved`). Screenshot
filenames almost never collide.

macOS screenshot location is set in `scripts/config.sh`:

```sh
defaults write com.apple.screencapture location -string "${HOME}/Downloads/Screenshots"
defaults write com.apple.screencapture type -string "png"
```

## Prerequisites

- Tailscale up on both machines; `ssh asura` works without a prompt.
- `/Users/seven` → `/home/seven` on Asura.
- Mutagen CLI on Marceline (`brew install mutagen-io/mutagen/mutagen`).
- Do not install Arch's `python-mutagen`; that is an audio tag library.

## Create the session (Marceline)

```sh
brew install mutagen-io/mutagen/mutagen
mutagen daemon register
mutagen daemon start
mkdir -p ~/Downloads/Screenshots

mutagen sync create \
  --name screenshots \
  --sync-mode two-way-resolved \
  --ignore '.DS_Store' \
  ~/Downloads/Screenshots \
  asura:~/Downloads/Screenshots
```

`mutagen daemon register` installs a LaunchAgent so the daemon starts at login
and resumes the `screenshots` session. `mutagen daemon start` alone dies at
logout.

On Asura:

```sh
mkdir -p ~/Downloads/Screenshots
```

## Agent install (OpenSSH 9+ chmod bug)

Mutagen 0.18 copies the agent into `$HOME` via SFTP and does not `chmod +x` on
POSIX-to-POSIX. The leftover is `~/.mutagen-agent<uuid>` mode `644`, and zsh
reports `permission denied`.

If that happens, on Asura:

```sh
chmod +x ~/.mutagen-agent*
~/.mutagen-agent* install
rm -f ~/.mutagen-agent*
```

Then retry `mutagen sync create` on Marceline. The installed binary lives at
`~/.mutagen/agents/<version>/mutagen-agent`.

## Status

On Marceline:

```sh
mutagen sync list
mutagen sync monitor screenshots
```

A healthy session shows `Watching` on both sides while Tailscale is connected,
or `Connecting` while it waits.

SwiftBar on Marceline runs `mac/.config/swiftbar/plugins/mutagen-sync.30s.sh`.
Green is `Watching`; yellow is connecting or paused; red is a dead daemon or a
missing session. The menu can flush the session or start the daemon.

## Thumbnail drops

The floating macOS screenshot thumbnail is **not** a file in
`~/Downloads/Screenshots`. Dragging it is a file promise. macOS materializes a
path like:

```text
/var/folders/<id>/T/TemporaryItems/NSIRD_screencaptureui_<random>/Screenshot ….png
```

That directory is reaped within seconds, the drag often consumes the capture so
it never reaches the configured save folder, and `/var/folders/...` is
Marceline-specific. Mutagen cannot make that path valid on Asura.

There is no `defaults` key to relocate `NSIRD_screencaptureui`. `TMPDIR` is not
a supported way to move it; a global `TMPDIR` would also break unrelated
software.

Practical options:

- Let the thumbnail save, or drag from Finder after it has saved. Mutagen has
  the file; drop that path.
- Disable the thumbnail so captures go straight to the synced folder:
  `defaults write com.apple.screencapture show-thumbnail -bool false`.
- Clipboard capture (`Cmd+Ctrl+Shift+4`) into something that accepts image
  bytes, not a file path.

A watcher that copies `TemporaryItems` onto both machines still loses: the
terminal pastes the ephemeral `/var/folders` path, macOS deletes the source
almost immediately, and a two-way sync would delete the copy too. Fixing
thumbnail-into-Mosh would mean the **Mac terminal** reading the bytes at drop
time and rewriting the pasted path to `~/Downloads/Screenshots`. Ghostty does
not do that.

## Remove

On Marceline:

```sh
mutagen sync terminate screenshots
mutagen daemon unregister
mutagen daemon stop
```
