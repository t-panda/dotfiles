# 🏠 Dotfiles

> Personal development environment configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-Compatible-success.svg)](https://www.apple.com/macos/)
[![Shell: Zsh](https://img.shields.io/badge/Shell-Zsh-blue.svg)](https://zsh.sourceforge.io/)

A carefully curated collection of dotfiles for macOS development environment featuring modern terminal tools, productivity enhancements, and streamlined workflows.

## ✨ Features

- **🚀 Zero-config installation** - One command setup with automatic backups
- **🔄 Smart management scripts** - Install, update, sync, and uninstall with ease  
- **🛡️ Safe deployment** - Automatic backups before any changes
- **⚡ Modern terminal stack** - Zsh + Oh My Zsh + Powerlevel10k + productivity plugins
- **🎯 Developer-focused** - Optimized for coding with Neovim, Git, and terminal tools
- **📦 Modular design** - Each tool configured as independent Stow package

## What's Included

- **zsh**: Zsh configuration with Oh My Zsh, Powerlevel10k theme, zsh-autosuggestions, and zsh-syntax-highlighting
- **nvim**: Neovim configuration
- **wezterm**: WezTerm terminal emulator configuration
- **yazi**: Yazi file manager configuration
- **tmux**: Tmux terminal multiplexer configuration
- **git**: Git configuration with user settings, aliases, and preferences

## Quick Setup

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

## Script Usage Guide

All management scripts are located in the `scripts/` directory. Here's when and how to use each one:

### 🚀 Installation Script
**File**: `scripts/install.sh`  
**When to use**: Initial setup on a new machine or fresh installation

```bash
./scripts/install.sh
```

**What it does**:
- Installs Homebrew (if not present)
- Installs all required packages and applications
- Installs Oh My Zsh, themes, and plugins
- Creates timestamped backups of existing configurations
- Creates symlinks using GNU Stow
- Sets zsh as the default shell

### 🔄 Update Script
**File**: `scripts/update.sh`  
**When to use**: Regular maintenance to get latest changes from remote repository

```bash
# Full update (pulls from remote + updates local symlinks)
./scripts/update.sh

# Local-only update (just refresh symlinks, no remote pull)
./scripts/update.sh --local
```

**What it does**:
- **Full mode**: Updates dotfiles repo, Oh My Zsh, themes, and plugins from remote
- **Local mode**: Only refreshes symlinks (useful after editing files locally)
- Re-stows all packages to ensure symlinks are current
- Reloads tmux configuration if tmux is running

### ⚡ Quick Sync Script
**File**: `scripts/sync.sh`  
**When to use**: After making changes to any file in the dotfiles directory

```bash
./scripts/sync.sh
```

**What it does**:
- Quickly updates all symlinks without remote operations
- Perfect for immediate application of local changes
- Automatically reloads tmux configuration
- Fastest way to sync changes

### 🗑️ Uninstall Script
**File**: `scripts/uninstall.sh`  
**When to use**: Complete removal of dotfiles setup

```bash
./scripts/uninstall.sh
```

**What it does**:
- Interactive removal of all installed packages and applications
- Option to remove Oh My Zsh and plugins
- Option to restore shell back to bash
- Finds and allows restoration from automatic backups
- Removes all symlinks created by stow

### 📋 Convenient Aliases
**File**: `scripts/aliases.sh`  
**When to use**: Add these to your shell configuration for easy access

```bash
# Add to your ~/.zshrc
source ~/dotfiles/scripts/aliases.sh

# Then use these commands from anywhere:
dotsync        # Quick sync of local changes
dotupdate      # Full update from remote
dotinstall     # Run installation
dotuninstall   # Run uninstallation
```

## Common Scenarios

### Scenario 1: First-time setup
```bash
git clone <repo> ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

### Scenario 2: Daily workflow - made changes to tmux config
```bash
# Edit ~/dotfiles/tmux/.tmux.conf
dotsync  # or ./scripts/sync.sh
# Changes are immediately active
```

### Scenario 3: Weekly maintenance
```bash
dotupdate  # or ./scripts/update.sh
# Pulls latest changes and updates everything
```

### Scenario 4: Testing changes before committing
```bash
# Edit files in dotfiles directory
dotsync                    # Apply changes locally
# Test the changes
git add . && git commit    # Commit if satisfied
```

### Scenario 5: Moving to a new machine
```bash
# On new machine:
git clone <repo> ~/dotfiles
cd ~/dotfiles
./scripts/install.sh      # Full setup
```

### Scenario 6: Something went wrong, need to restore
```bash
./scripts/uninstall.sh    # Choose to restore from backup
# Select backup date to restore from
```

## Manual Setup

If you prefer to set up manually:

### Prerequisites

Install required packages:
```bash
brew install stow git zsh tmux neovim yazi wezterm zoxide fzf fnm
```

### Install Oh My Zsh and plugins

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### Deploy configurations with Stow

```bash
cd ~/dotfiles
stow zsh
stow nvim
stow wezterm
stow yazi
stow tmux
stow git
```

## Package Structure

Each configuration is organized as a separate "package" that Stow can manage:

```
dotfiles/
├── scripts/            # Management scripts
│   ├── install.sh      # Full installation script
│   ├── uninstall.sh    # Complete uninstall script
│   ├── update.sh       # Update from remote + local sync
│   ├── sync.sh         # Quick local sync script
│   └── aliases.sh      # Convenient shell aliases
├── README.md           # This file
├── zsh/                # Zsh package
│   ├── .zshrc
│   └── .p10k.zsh
├── nvim/               # Neovim package
│   └── .config/
│       └── nvim/
├── wezterm/            # WezTerm package
│   └── .config/
│       └── wezterm/
├── yazi/               # Yazi package
│   └── .config/
│       └── yazi/
├── tmux/               # Tmux package
│   └── .tmux.conf
└── git/                # Git package
    └── .gitconfig
```

## Adding New Configurations

To add a new configuration:

1. Create a new package directory: `mkdir new-package`
2. Add your config files with the correct directory structure
3. Use stow to deploy: `stow new-package`
4. Update the install script to include the new package
5. Run `dotsync` to refresh symlinks

## Updating Configurations

When you update a configuration file:

1. Edit the file in the dotfiles directory (it's symlinked)
2. Run `dotsync` to apply changes immediately
3. Test your changes
4. Commit your changes: `git add . && git commit -m "Update config"`

### Pro tip: 
Since files are symlinked, any changes you make in the dotfiles directory are immediately reflected in your system. Use `dotsync` to ensure all symlinks are properly updated, especially after adding new files.

## Restoring Backups

The install script automatically creates backups in `~/.dotfiles-backup-YYYYMMDD-HHMMSS/`. 
To restore a backup, simply copy the files back to their original locations.

## 🛠️ Tools Used

- **[GNU Stow](https://www.gnu.org/software/stow/)**: Symlink farm manager for clean dotfiles management
- **[Oh My Zsh](https://ohmyz.sh/)**: Feature-rich Zsh framework
- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)**: Fast and customizable Zsh theme
- **[Neovim](https://neovim.io/)**: Modern text editor
- **[WezTerm](https://wezfurlong.org/wezterm/)**: GPU-accelerated terminal emulator
- **[Yazi](https://yazi-rs.github.io/)**: Blazing fast terminal file manager
- **[Tmux](https://github.com/tmux/tmux)**: Terminal multiplexer
- **[zoxide](https://github.com/ajeetdsouza/zoxide)**: Smart cd command replacement
- **[fzf](https://github.com/junegunn/fzf)**: Command-line fuzzy finder
- **[fnm](https://github.com/Schniz/fnm)**: Fast Node.js version manager

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

You're free to use, modify, and distribute these dotfiles. Just give credit where it's due! 🙏

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to:
- Open an [issue](../../issues) 
- Submit a [pull request](../../pulls)
- Share your feedback

## ⭐ Support

If these dotfiles helped you set up your development environment, consider giving this repository a star! It helps others discover these configurations.

---

<p align="center">
  Made with ❤️ for the developer community
</p>
