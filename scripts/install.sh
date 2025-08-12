#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS"
    exit 1
fi

print_status "Starting dotfiles setup..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    print_success "Homebrew is already installed"
fi

# Install required packages
print_status "Installing required packages..."
brew update

# Core packages
brew install stow git zsh tmux neovim yazi wezterm zoxide fzf fnm

# Additional development tools
brew install tree-sitter ripgrep fd

# Media and graphics libraries
brew install ffmpeg imagemagick

# System utilities
brew install gnupg

# Install casks
print_status "Installing applications..."
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-symbols-only-nerd-font
brew install --cask visual-studio-code
brew install --cask google-chrome
brew install --cask stats
brew install --cask zen

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_success "Oh My Zsh is already installed"
fi

# Install Powerlevel10k theme
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    print_status "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
else
    print_success "Powerlevel10k is already installed"
fi

# Install zsh-autosuggestions plugin
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    print_status "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    print_success "zsh-autosuggestions is already installed"
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    print_status "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    print_success "zsh-syntax-highlighting is already installed"
fi

# Backup existing configurations
print_status "Backing up existing configurations..."
BACKUP_DIR="$HOME/.backup/dotfiles-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# List of files to backup
backup_files=(".zshrc" ".p10k.zsh" ".tmux.conf" ".gitconfig")
backup_dirs=(".config/nvim" ".config/wezterm" ".config/yazi")

for file in "${backup_files[@]}"; do
    if [ -f "$HOME/$file" ]; then
        print_status "Backing up $file..."
        cp "$HOME/$file" "$BACKUP_DIR/"
    fi
done

for dir in "${backup_dirs[@]}"; do
    if [ -d "$HOME/$dir" ]; then
        print_status "Backing up $dir..."
        mkdir -p "$BACKUP_DIR/$(dirname $dir)"
        cp -r "$HOME/$dir" "$BACKUP_DIR/$dir"
    fi
done

print_success "Configurations backed up to $BACKUP_DIR"

# Remove existing files/directories that will be managed by stow
print_status "Removing existing configurations..."
for file in "${backup_files[@]}"; do
    if [ -f "$HOME/$file" ] || [ -L "$HOME/$file" ]; then
        rm "$HOME/$file"
    fi
done

for dir in "${backup_dirs[@]}"; do
    if [ -d "$HOME/$dir" ] || [ -L "$HOME/$dir" ]; then
        rm -rf "$HOME/$dir"
    fi
done

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use stow to create symlinks
print_status "Creating symlinks with stow..."
cd "$DOTFILES_DIR"

# Stow each package
packages=("zsh" "nvim" "wezterm" "yazi" "tmux" "git")

for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        print_status "Stowing $package..."
        stow -v "$package"
        print_success "$package configuration linked"
    else
        print_warning "$package directory not found, skipping..."
    fi
done

# Set zsh as default shell if it isn't already
if [ "$SHELL" != "$(which zsh)" ]; then
    print_status "Setting zsh as default shell..."
    chsh -s $(which zsh)
    print_success "Default shell changed to zsh"
else
    print_success "zsh is already the default shell"
fi

print_success "Dotfiles setup completed!"
print_status "Please restart your terminal or run 'source ~/.zshrc' to load the new configuration"
print_status "You may need to run 'p10k configure' to set up Powerlevel10k theme"
