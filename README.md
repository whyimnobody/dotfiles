# **Machine Setup for macOS**

Set of scripts and files to setup my macOS machines as development environments.

## **Prerequisite**

- Make sure you have admin permission to execute the script to install all the
  development tools.
- Shell
- git

## Put the repo somewhere sensible

```shell
git clone https://github.com/whyimnobody/dotfiles.git ~/.dotfiles
```

## **Make sure script has execution permission**

```shell
chmod +x setup.sh config.sh
```

## **Execute script to begin setup**

```shell
./scripts/setup.sh
```

## Apps To Install

Check the script!

## Post-Install

### Update the user shell to use the Homebrew zsh

Restart terminal in its entirety (not just the session) and if
the shell isn't `zsh`, run the below.

```shell
sudo dscl . -create /Users/$USER UserShell $(which zsh)
```

**_src: [https://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/#handling-upgrades_](https://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/#handling-upgrades_)**

Don't forget to install nix, and set `trusted-users`

### Open All The Things

- Open `nvim`. This will allow it to install LSPs, formatters and anything else required
- Setup `1password` and login to:
  - Zen
  - Arc
  - Backblaze
  - Discord
  - Raycast
  - Logi Options+
  - Spotify
  - Mail accounts
  - Slacks
- Open and set open-on-login for:
  - Maccy
  - Rectangle
  - 1Password
- [Setup 1Password SSH Agent](https://developer.1password.com/docs/ssh/get-started#step-3-turn-on-the-1password-ssh-agent)

#### **Original Script Resources**

- [MAC OSX BASH PROFILE](https://natelandau.com/my-mac-osx-bash_profile/)
- [New MacBook Setup for Developers by Dan Vega](https://dev.to/therealdanvega/new-macbook-setup-for-developers-2nma)

#### Additional Resources

- `nix` [cheatsheet](https://nixcademy.com/downloads/cheatsheet.pdf)

## Stow TODOs

- [ ] Figure out encryption?
