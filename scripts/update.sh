#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if running local update (from dotfiles directory changes)
LOCAL_UPDATE=false
if [[ "$1" == "--local" || "$1" == "-l" ]]; then
    LOCAL_UPDATE=true
    print_status "Running local dotfiles update..."
else
    print_status "Updating dotfiles from remote..."
fi

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES_DIR"

if [ "$LOCAL_UPDATE" = false ]; then
    # Pull latest changes from remote
    print_status "Pulling latest changes from git..."
    git pull

    # Update Oh My Zsh
    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_status "Updating Oh My Zsh..."
        cd "$HOME/.oh-my-zsh"
        git pull
        cd "$DOTFILES_DIR"
    fi

    # Update Powerlevel10k
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        print_status "Updating Powerlevel10k..."
        cd "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
        git pull
        cd "$DOTFILES_DIR"
    fi

    # Update zsh plugins
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        print_status "Updating zsh-autosuggestions..."
        cd "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
        git pull
        cd "$DOTFILES_DIR"
    fi

    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        print_status "Updating zsh-syntax-highlighting..."
        cd "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
        git pull
        cd "$DOTFILES_DIR"
    fi
else
    print_status "Skipping remote updates (local mode)..."
fi

# Re-stow packages to ensure links are current
print_status "Re-stowing packages to update symlinks..."
packages=("zsh" "nvim" "wezterm" "yazi" "tmux" "git")

for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        print_status "Re-stowing $package..."
        stow -R -v "$package" 2>/dev/null || print_warning "Could not re-stow $package"
        print_success "$package symlinks updated"
    fi
done

# Reload tmux configuration if tmux is running
if command -v tmux &> /dev/null && tmux list-sessions &> /dev/null; then
    print_status "Reloading tmux configuration..."
    tmux source-file ~/.tmux.conf
    print_success "tmux configuration reloaded"
fi

print_success "Dotfiles updated successfully!"

if [ "$LOCAL_UPDATE" = false ]; then
    print_status "Restart your terminal to apply any changes"
else
    print_status "Local symlinks updated. Configuration changes should be active immediately."
fi
