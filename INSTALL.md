# Installation Guide

This guide provides detailed instructions for setting up these dotfiles on your system.

## Quick Setup

For a quick, automated setup:

```bash
git clone https://github.com/t-panda/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

The installation script will handle everything automatically, including:
- Installing Homebrew (if not present)
- Installing all required packages and applications
- Setting up Oh My Zsh with themes and plugins
- Creating backups of existing configurations
- Creating symlinks using GNU Stow
- Setting zsh as the default shell

## Manual Setup

If you prefer more control over the installation process, you can set up the dotfiles manually:

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

## Script Usage Guide

All management scripts are located in the `scripts/` directory:

### 🚀 Installation Script
**File**: `scripts/install.sh`  
**When to use**: Initial setup on a new machine or fresh installation

```bash
./scripts/install.sh
```

### 🔄 Update Script
**File**: `scripts/update.sh`  
**When to use**: Regular maintenance to get latest changes from remote repository

```bash
# Full update (pulls from remote + updates local symlinks)
./scripts/update.sh

# Local-only update (just refresh symlinks, no remote pull)
./scripts/update.sh --local
```

### ⚡ Quick Sync Script
**File**: `scripts/sync.sh`  
**When to use**: After making changes to any file in the dotfiles directory

```bash
./scripts/sync.sh
```

### 🗑️ Uninstall Script
**File**: `scripts/uninstall.sh`  
**When to use**: Complete removal of dotfiles setup

```bash
./scripts/uninstall.sh
```

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

## Backups and Restoration

The install script automatically creates backups in `~/.dotfiles-backup-YYYYMMDD-HHMMSS/`. 
To restore a backup:

1. Find your backup directory: `ls -la ~/ | grep dotfiles-backup`
2. Copy the files back to their original locations or use the uninstall script's restoration option

## Troubleshooting

If you encounter issues during installation:

1. Check that all prerequisites are installed: `brew list | grep -E 'stow|git|zsh|tmux|neovim|yazi|wezterm|zoxide|fzf|fnm'`
2. Ensure you have write permissions to your home directory
3. Check for error messages in the installation output
4. Try running the uninstall script and then reinstalling: `./scripts/uninstall.sh && ./scripts/install.sh`

For more help, open an issue on the GitHub repository.
