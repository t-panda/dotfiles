#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_status "Starting dotfiles uninstall..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_status "Removing symlinks with stow..."
cd "$DOTFILES_DIR"

packages=("zsh" "nvim" "wezterm" "yazi" "tmux" "git")

for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        print_status "Unstowing $package..."
        stow -D -v "$package" 2>/dev/null || print_warning "Could not unstow $package (might not be stowed)"
    fi
done

read -p "Do you want to uninstall Homebrew packages and applications? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Uninstalling Homebrew packages..."
    
    print_status "Removing applications..."
    brew uninstall --cask zen 2>/dev/null || print_warning "zen not found"
    brew uninstall --cask 1password 2>/dev/null || print_warning "1password not found"
    brew uninstall --cask spotify 2>/dev/null || print_warning "spotify not found"
    brew uninstall --cask wezterm 2>/dev/null || print_warning "wezterm not found"
    brew uninstall --cask stats 2>/dev/null || print_warning "stats not found"
    brew uninstall --cask google-chrome 2>/dev/null || print_warning "google-chrome not found"
    brew uninstall --cask visual-studio-code 2>/dev/null || print_warning "visual-studio-code not found"
    brew uninstall --cask font-symbols-only-nerd-font 2>/dev/null || print_warning "font-symbols-only-nerd-font not found"
    brew uninstall --cask font-jetbrains-mono-nerd-font 2>/dev/null || print_warning "font-jetbrains-mono-nerd-font not found"
    
    print_status "Removing explicitly requested packages..."
    # Container tools
    brew uninstall colima docker docker-compose 2>/dev/null || print_warning "container tools not found"
    
    # Development and utility tools
    brew uninstall git gnupg jq ncdu 2>/dev/null || print_warning "utility tools not found"
    brew uninstall sevenzip poppler resvg 2>/dev/null || print_warning "utility tools not found"
    
    # Media tools
    brew uninstall ffmpeg imagemagick 2>/dev/null || print_warning "media tools not found"
    
    # Search and navigation tools
    brew uninstall fd ripgrep tree-sitter 2>/dev/null || print_warning "search tools not found"
    brew uninstall fnm fzf zoxide 2>/dev/null || print_warning "navigation tools not found"
    
    # Terminal tools
    brew uninstall yazi neovim tmux 2>/dev/null || print_warning "terminal tools not found"
    brew uninstall zsh stow 2>/dev/null || print_warning "core tools not found"
    
    print_success "Homebrew packages uninstalled"
fi

read -p "Do you want to remove Oh My Zsh and plugins? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Removing Oh My Zsh..."
    if [ -d "$HOME/.oh-my-zsh" ]; then
        rm -rf "$HOME/.oh-my-zsh"
        print_success "Oh My Zsh removed"
    else
        print_warning "Oh My Zsh not found"
    fi
fi

read -p "Do you want to change your shell back to bash? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Changing shell back to bash..."
    chsh -s /bin/bash
    print_success "Default shell changed to bash"
fi

print_status "Looking for configuration backups..."
BACKUP_DIRS=($(find "$HOME/.backup" -maxdepth 1 -name "dotfiles-*" -type d 2>/dev/null | sort -r))

if [ ${#BACKUP_DIRS[@]} -gt 0 ]; then
    echo "Found backup directories:"
    for i in "${!BACKUP_DIRS[@]}"; do
        echo "  $((i+1)). $(basename "${BACKUP_DIRS[$i]}")"
    done
    
    read -p "Do you want to restore from a backup? Enter number (or press Enter to skip): " -r
    if [[ $REPLY =~ ^[0-9]+$ ]] && [ "$REPLY" -ge 1 ] && [ "$REPLY" -le "${#BACKUP_DIRS[@]}" ]; then
        SELECTED_BACKUP="${BACKUP_DIRS[$((REPLY-1))]}"
        print_status "Restoring from $SELECTED_BACKUP..."
        
        backup_files=(".zshrc" ".p10k.zsh" ".tmux.conf" ".gitconfig")
        for file in "${backup_files[@]}"; do
            if [ -f "$SELECTED_BACKUP/$file" ]; then
                print_status "Restoring $file..."
                cp "$SELECTED_BACKUP/$file" "$HOME/"
            fi
        done
        
        backup_dirs=(".config/nvim" ".config/wezterm" ".config/yazi")
        for dir in "${backup_dirs[@]}"; do
            if [ -d "$SELECTED_BACKUP/$dir" ]; then
                print_status "Restoring $dir..."
                mkdir -p "$HOME/$(dirname "$dir")"
                cp -r "$SELECTED_BACKUP/$dir" "$HOME/$dir"
            fi
        done
        
        print_success "Backup restored from $SELECTED_BACKUP"
    fi
else
    print_warning "No backup directories found"
fi

print_status "Dotfiles have been unlinked"
print_warning "Your configurations are still available in the dotfiles directory"
print_success "Uninstall completed!"
print_status "Please restart your terminal to apply shell changes"
