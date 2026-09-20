# 1Password SSH agent bridge

This bridge makes the Mac's 1Password SSH agent available to long-lived Mosh
and tmux sessions on Asura. It uses a supervised, ordinary SSH connection for
agent forwarding; Mosh remains the interactive transport.

## Architecture

```text
Mac 1Password agent
  -> launchd
    -> autossh
      -> OpenSSH agent forwarding over Tailscale
        -> ~/.local/bin/1p-bridge-remote on Asura
          -> ~/.ssh/agent.sock
```

Shells and SSH clients use `~/.ssh/agent.sock`. On Asura, the remote helper
atomically points that path at the forwarded socket. When the bridge exits, it
restores the path to Asura's local `~/.1password/agent.sock`. Cleanup checks
that it still owns the symlink, so an older connection cannot overwrite a newer
one.

The bridge is on demand. Its generated plist lives in
`~/Library/Application Support/1p-bridge`, not `~/Library/LaunchAgents`, so it
does not start merely because the Mac logged in. Once started, launchd keeps it
alive until `1p-bridge stop` is run or the user session ends.

## Prerequisites

On the Mac:

- Enable **Settings > Developer > Use the SSH agent** in 1Password.
- Install and authenticate Tailscale.
- Confirm that `ssh asura` reaches Asura. If the remote username differs from
  the Mac username, set `User` for the `asura` host alias in `~/.ssh/config`.
- Install `autossh`, `jq`, `mosh`, and SwiftBar. `scripts/mac.sh` installs them.

On Asura:

- Enable the 1Password SSH agent if the machine should retain a local fallback.
- Install and authenticate Tailscale SSH.
- Ensure `~/.local/bin/1p-bridge-remote` is available by restowing `local-bin`.

## Install after pulling the dotfiles

On Asura:

```sh
cd ~/.dotfiles
stow --restow --target="$HOME" local-bin zsh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
test -e ~/.ssh/agent.sock || test -L ~/.ssh/agent.sock || \
  ln -s ~/.1password/agent.sock ~/.ssh/agent.sock
```

If `~/.ssh/config` sets `IdentityAgent`, point it at the stable path:

```sshconfig
Host *
    IdentityAgent ~/.ssh/agent.sock
```

Without an explicit `IdentityAgent`, OpenSSH uses the `SSH_AUTH_SOCK` exported
by the shared zsh configuration.

On the Mac, either run the complete setup:

```sh
cd ~/.dotfiles
./scripts/mac.sh
```

or apply only this feature:

```sh
brew install autossh jq mosh
brew install --cask swiftbar
cd ~/.dotfiles
stow --restow --target="$HOME" local-bin zsh mac
mkdir -p ~/.1password ~/.ssh
ln -sfn \
  "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" \
  ~/.1password/agent.sock
test -e ~/.ssh/agent.sock || test -L ~/.ssh/agent.sock || \
  ln -s ~/.1password/agent.sock ~/.ssh/agent.sock
1p-bridge install asura
```

The install command renders the host-specific launchd plist but does not load
it.

## Use

Start the bridge and enter Mosh:

```sh
mosh1p asura
```

When the bridge is not connected, `mosh1p` first opens a short interactive SSH
session. This allows any Tailscale SSH check-mode authorization to happen in
the visible terminal. It then starts the supervised bridge and waits for its
OpenSSH control socket before launching Mosh.

Direct controls are also available:

```sh
1p-bridge start asura
1p-bridge status asura
1p-bridge check asura
1p-bridge restart asura
1p-bridge stop asura
1p-bridge logs asura
```

`start` is idempotent. `stop` unloads the job, so launchd does not immediately
restart it. `uninstall` stops the bridge and removes its generated plist.

## SwiftBar monitoring

`1password-bridge.15s.sh` shows the bridge state:

- green: SSH transport connected;
- yellow: launchd is running and autossh is reconnecting;
- gray: stopped, or waiting for Tailscale;
- red: the local 1Password agent is unavailable or status failed.

The 15-second refresh checks only local Tailscale, launchd, socket, and OpenSSH
control state. Use **Probe remote agent…** for the deeper `ssh-add -l` check.
The menu also exposes Start, Reconnect, Stop, and logs.

`mutagen-sync.30s.sh` is a separate plugin for the screenshot Mutagen session.
It does not share state with this bridge.

The separate `brew-services.30d.sh` plugin refreshes when opened. It uses
Homebrew's JSON output for user services and checks launchd separately for the
root-owned Caddy service. Root service actions open a terminal so macOS can ask
for an administrator password; no passwordless sudo rule is required.

## States and recovery

`1p-bridge status asura` reports:

- `connected`: launchd and the OpenSSH master connection are healthy;
- `retrying`: the service is loaded but autossh has not connected;
- `waiting`: Tailscale is disconnected or needs login;
- `stopped`: the launchd job is not loaded;
- `error`: the Mac's local 1Password socket is unavailable.

If the state remains `retrying`:

```sh
ssh asura true
1p-bridge restart asura
1p-bridge logs asura
```

The first command surfaces Tailscale SSH authorization interactively. If the
remote probe fails but transport is connected, verify on Asura:

```sh
readlink ~/.ssh/agent.sock
SSH_AUTH_SOCK=~/.ssh/agent.sock ssh-add -l
```

## Security and rollback

While connected, processes running as the Asura user can request signatures
from the Mac's 1Password agent. Private keys remain in 1Password, but the
signing channel is available until the bridge is stopped. Stop it when that is
not desired:

```sh
1p-bridge stop asura
```

To remove the Mac service definition:

```sh
1p-bridge uninstall asura
```

On Asura, restore the local agent explicitly if needed:

```sh
ln -sfn ~/.1password/agent.sock ~/.ssh/agent.sock
```
