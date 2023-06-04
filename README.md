# **Machine Setup for macOS**

Set of scripts and files to setup my macOS machines as development environments.

# **Prerequisite**

- Make sure you have admin permission to execute the script to install all the development tools.
- Shell
- git

# Put the repo somewhere sensible

```shell
git clone https://github.com/whyimnobody/dotfiles.git ~/.config/dotfiles
```

# **Make sure script has execution permission**

```shell
chmod +x setup.sh config.sh
```

# **Execute script to begin setup**

```shell
./setup.sh
```

# Apps To Install

Check the script!

# Post-Install

### Update the user shell to use the Homebrew zsh

```shell
chsh -s $(which zsh)
```

Run that and restart terminal in its entirety (not just the session) and if that fails, run the below.

```shell
sudo dscl . -create /Users/$USER UserShell $(which zsh)
```

**_src: https://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/#handling-upgrades_**

### Open All The Things

- Open `nvim`. This will allow it to install LSPs, formatters and anything else required
- Setup `1password` and login to:
  - Firefox
  - Backblaze
  - Notion
  - HTTPie
  - Insomnia
  - Raycast
  - Logi Options+
  - Spotify
  - Discord
  - Mail accounts
  - Slacks
- Open and set open-on-login for:
  - Maccy
  - Rectangle
  - iTerm
  - 1Password

#### **Original Script Resources**

- [MAC OSX BASH PROFILE](https://natelandau.com/my-mac-osx-bash_profile/)
- [New MacBook Setup for Developers by Dan Vega](https://dev.to/therealdanvega/new-macbook-setup-for-developers-2nma)
