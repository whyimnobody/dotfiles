# Caelestia known issues

This is the local record of Caelestia or QuickShell issues that affect this
configuration and need revisiting when upstream changes.

## Fullscreen exit artefact on one monitor

### Observed behaviour

After leaving fullscreen video in Zen, the Caelestia top bar can remain
visually corrupted on one monitor. Moving to another workspace causes the
bar to redraw correctly. The other monitor is unaffected.

The shell receives the fullscreen-exit event, so the issue is not currently
treated as a stuck fullscreen state. A local experiment that removed the
fullscreen transition animation did not resolve the artefact and has been
reverted.

### Workaround

Switch workspaces to force a redraw. Reloading the shell with `shell -r` is a
heavier fallback if the artefact persists.

### Upstream reference

Track the related fullscreen-exit rendering report in
[Caelestia shell issue #635](https://github.com/caelestia-dots/shell/issues/635).
Recheck this note when that issue, or the relevant QuickShell rendering
behaviour, changes upstream.
