# **Machine Setup for macOS**

Set of scripts and files to setup my macOS machines as development environments.

# **Prerequisite**

- Make sure you have admin permission to execute the script to install all the development tools.
- Shell
- git

# **Make sure script has execution permission**

```
chmod +x setup.sh
```

# **Execute script to begin setup**

```
./setup.sh
```

# Apps To Install

Check the script!

# Post-Install

#### Update the user shell to use the Homebrew zsh

```
chsh -s $(which zsh)
```

Run that and restart terminal in its entirety (not just the session) and if that fails, run the below.

```
sudo dscl . -create /Users/$USER UserShell $(which zsh)
```

**_src: https://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/#handling-upgrades_**

#### **Original Script Resources**

- [MAC OSX BASH PROFILE](https://natelandau.com/my-mac-osx-bash_profile/)
- [New MacBook Setup for Developers by Dan Vega](https://dev.to/therealdanvega/new-macbook-setup-for-developers-2nma)
