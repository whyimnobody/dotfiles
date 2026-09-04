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
when the source differs.

## Arch desktop notes

- Syncthing: `systemctl --user status syncthing.service`; web UI at
  `https://sync.localhost` when Caddy and the local hosts entry are configured,
  or `http://127.0.0.1:8384` directly.
- Tailscale: `systemctl status tailscaled.service`; authenticate with
  `sudo tailscale up`.
- Mailpit is a user service: `systemctl --user enable --now mailpit.service`;
  its UI is available at `http://127.0.0.1:8025`.
- ClamAV and MinIO are an on-demand Docker Compose stack. Run
  `dev-services up`, `dev-services status`, or `dev-services down`; see
  `~/.config/dev-services/README.md` for individual-service commands and
  endpoints. The first use creates private MinIO credentials locally.
- Satty screenshots use Meta+Shift+S for a selected region, Meta+Shift+C to
  copy a region, Meta+Shift+F for the focused output, and Meta+Shift+W for the
  active window. The screenshot script focuses the output where the capture
  was made before opening Satty.
- Clipse listens in the background and opens with Meta+V; Meta+Shift+V toggles
  the active window's floating state.
- Kanshi manages the configured DP-1/DP-2 layout and can be extended with
  laptop or dock profiles in `nice/.config/kanshi/config`.
- Eww and wlogout live in `nice/.config`; SDDM's system snippets are sourced
  from `nice/.config/sddm` and installed by `scripts/nice.sh`.
- liquidctl is installed by the Arch setup, and `kraken-lcd.service` reapplies
  the 180° LCD orientation at boot. The service deliberately does not choose
  an image or GIF yet.

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
- [ ] Revisit idle locking/power management; `hypridle` is intentionally not
      enabled because it previously crashed the session.
