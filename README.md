# Machine setup

This repository contains the shared shell/editor configuration plus platform
specific setup for macOS and Arch Linux.

## Bootstrap

```sh
git clone https://github.com/whyimnobody/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

On macOS:

```sh
./scripts/mac.sh
```

On Arch (run from a graphical session when the desktop packages are wanted):

```sh
./scripts/arch.sh
```

The Arch script installs the packages, stows `nice`, enables Syncthing, and
installs the Caddy and SDDM configuration. Re-running it is intended to be
safe; it only installs missing packages and replaces managed configuration
when the source differs. `scripts/caddy.sh` merges the repo Caddyfile with
any `# >>> devports` blocks produced by `caddy-add-site`, so local `*.test`
sites are not wiped.

## Arch desktop notes

- Syncthing: `systemctl --user status syncthing.service`; web UI at
  `https://syncthing.localhost` on Asura and `http://syncthing.asura` on the
  tailnet (same Caddy + Serve :80 path as `*.test`). That needs Tailscale
  split-DNS for the `asura` zone → Asura (`100.80.206.60`), next to the
  existing `test` split. Do not put `*.asura` on LAN Blocky: it dies off-home.
- Tailscale: `systemctl status tailscaled.service`; authenticate with
  `sudo tailscale up`.
- Mailpit is a user service: `systemctl --user enable --now mailpit.service`;
  its UI is `http://127.0.0.1:8025` on Asura and `http://email.test` on the
  tailnet (Caddy on port 80, same pattern as the other `*.test` sites).
- JupyterLab is a user service bound to `127.0.0.1:8888` and served as
  `http://jupyter.test`. Write a 1Password token to
  `~/.local/state/jupyter/token` **before** starting it. See the
  [JupyterLab runbook](docs/jupyter-lab.md).
- ClamAV and MinIO are an on-demand Docker Compose stack. Run
  `dev-services up`, `dev-services status`, or `dev-services down`; see
  `~/.config/dev-services/README.md` for individual-service commands and
  endpoints. The first use creates private MinIO credentials locally.
- Satty screenshots use Meta+Shift+S for a selected region, Meta+Shift+C to
  copy a region, Meta+Shift+F for the focused output, and Meta+Shift+W for the
  active window. `grim` captures pixels, `slurp` selects regions, `satty`
  annotates, and `wl-clipboard` handles clipboard copies. Annotated captures
  are saved to `~/Downloads/Screenshots`; copy-only captures are not saved.
  Caelestia's built-in fullscreen capture initially uses
  `~/.cache/caelestia/screenshots` and can save to `~/Downloads/Screenshots`.
  Caelestia's Swappy calls are routed through the local Satty shim, so both
  screenshot paths use Satty for annotation.
- Caelestia is built from the downstream checkout at
  `~/repos/personal/shell`, while `caelestia-cli` and `quickshell-git` provide
  the launcher and runtime. It starts from
  `nice/.config/hypr/config/startup.lua` and owns the bar, launcher,
  notifications, clipboard UI, wallpaper, and idle policy. The shell settings
  are versioned in `nice/.config/caelestia/shell.json`. Use the checkout's
  `justfile` for the user-local workflow:
  `just --justfile ~/repos/personal/shell/justfile install` builds and installs
  it without `sudo`, while
  `just --justfile ~/repos/personal/shell/justfile update` fetches upstream,
  rebases the current downstream branch, validates, and reinstalls. Do not run
  `caelestia install`, which installs the larger Caelestia desktop dots.
  Caelestia reads wallpapers from the `wallpapers` submodule at
  `~/.dotfiles/wallpapers`.
- Known Caelestia rendering issues and local workarounds are tracked in the
  [Caelestia known-issues note](docs/caelestia-known-issues.md).
- Caelestia's primary shortcuts are Meta+Space for the launcher, Meta+N for
  the sidebar, Meta+Shift+N for clearing notifications, and Meta+V for the
  clipboard. Meta+Shift+V still toggles the active window's floating state.
- Waybar, Eww, SwayNC, Vicinae, Clipse, Hyprpaper, Hyprlock, and Hypridle are
  no longer installed or started. Their old configuration files remain in the
  repository as rollback references while the Caelestia migration settles.
- Kanshi manages the configured DP-1/DP-2 layout and can be extended with
  laptop or dock profiles in `nice/.config/kanshi/config`.
- SDDM's system snippets are sourced from `nice/.config/sddm` and installed by
  `scripts/nice.sh`.
- liquidctl is installed by the Arch setup, and `kraken-lcd.service` reapplies
  the 180° LCD orientation at boot. The service deliberately does not choose
  an image or GIF yet.
- Corsair Dominator DRAM RGB is SMBus-only. OpenRGB is the driver; liquidctl
  keeps the Kraken and Aura headers. Plumbing (package, `i2c` group,
  `i2c-dev`, `openrgb-dram.service`) is in the Arch/nice setup. Create
  `~/.config/OpenRGB/profiles/dram.json` after the first GUI run — see the
  [OpenRGB DRAM runbook](docs/openrgb-dram.md).

### Idle lock

Caelestia QuickShell owns idle handling through
`nice/.config/caelestia/shell.json`. `hypridle.conf`, `hyprlock.conf`, and
`hyprpaper.conf` are retained as rollback references but are no longer
started.

Policy (no suspend — SSH, Mosh, Mutagen, and the 1Password bridge must keep
running while the machine is locked):

- 15 minutes: Caelestia lockscreen
- 30 minutes: monitors off (`dpms off`), restored with `dpms on`
- never: `systemctl suspend`

## macOS post-install

If the shell is not zsh, select the Homebrew shell with:

```sh
sudo dscl . -create /Users/$USER UserShell $(which zsh)
```

Open Neovim once to install its plugins and configure 1Password, browsers,
backup/sync tools, and the other applications listed in `scripts/mac.sh`.

The macOS setup also installs the on-demand 1Password SSH agent bridge and its
SwiftBar monitor. After restowing `local-bin` and `zsh` on Asura, use
`mosh1p asura` to start the supervised bridge and enter Mosh. See the
[1Password SSH agent bridge runbook](docs/1password-ssh-bridge.md) for setup,
status commands, Tailscale behaviour, and rollback.

## Screenshot sync (Marceline ↔ Asura)

Mutagen mirrors `~/Downloads/Screenshots` over Tailscale SSH so a Finder drop
into a Mosh/Ghostty window pastes a path that exists on Asura. Asura's
`/Users/seven` → `/home/seven` symlink is what makes the Mac path resolve.
The daemon runs on Marceline (`mutagen daemon register` starts it at login);
when Tailscale is down it waits and retries.

Create the session once on Marceline:

```sh
mutagen sync create \
  --name screenshots \
  --sync-mode two-way-resolved \
  --ignore '.DS_Store' \
  ~/Downloads/Screenshots \
  asura:~/Downloads/Screenshots
```

macOS already saves screenshots to that folder via `scripts/config.sh`. Drag
from Finder or after the thumbnail has saved. The floating thumbnail itself
is a short-lived `/var/folders/.../TemporaryItems/NSIRD_screencaptureui_*`
path and will not survive on Asura.

See the [screenshot sync runbook](docs/screenshot-sync.md) for the LaunchAgent,
the Mutagen 0.18 agent `chmod` workaround, status commands, the SwiftBar
monitor, and thumbnail limitations.

## Review after an Arch upgrade

Review `.pacnew` files before removing them. Keep the working local settings
for locale, mkinitcpio, pacman, and mirrors, and merge useful upstream changes
manually; do not overwrite the active files blindly. The current machine's
`.pacnew` review is recorded in the setup notes/commit message.

## Next steps

- [ ] Follow the [in-place root encryption runbook](docs/in-place-root-encryption.md).
- [ ] Define backup tooling for the Btrfs root and user data (for example,
      snapper + snap-pac for snapshots and restic/Borg for off-machine copies).
- [ ] Choose and configure a firewall frontend. `firewalld` plus
      `firewall-config` is the recommended desktop-friendly option; `ufw` is a
      simpler CLI alternative.
- [ ] Sort out GPG on system
- [ ] Figure out a Maccy-like experience on Linux
- [ ] Sort out Bluetooth devices (keyboard and mouse)
- [ ] Create `~/.config/OpenRGB/profiles/dram.json` and confirm OpenRGB sees the
      Dominator DIMMs. Follow the [OpenRGB DRAM runbook](docs/openrgb-dram.md).
      Disable Aura and Kraken in OpenRGB so liquidctl keeps them.
- [ ] Put a 1Password token in `~/.local/state/jupyter/token`, then start
      JupyterLab (`docs/jupyter-lab.md`). Also `caddy-add-site jupyter 8888`
      or re-run `scripts/caddy.sh` so `http://jupyter.test` is live.
- [x] Install Caelestia shell and move bar, launcher, notifications, clipboard,
      wallpaper, and idle handling into QuickShell.
