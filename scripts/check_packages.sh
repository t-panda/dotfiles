#!/bin/bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

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

check_packages() {
    local formula_list=("$@")
    local missing_packages=()
    local installed_packages=()
    local outdated_packages=()
    
    print_status "Checking Homebrew packages..."
    
    # Get list of installed packages once to avoid repeated calls
    local installed=$(brew list --formula)
    local outdated=$(brew outdated --formula)
    
    for formula in "${formula_list[@]}"; do
        if echo "$installed" | grep -q "^$formula\$"; then
            if echo "$outdated" | grep -q "^$formula\$"; then
                outdated_packages+=("$formula")
            else
                installed_packages+=("$formula")
            fi
        else
            missing_packages+=("$formula")
        fi
    done
    
    echo
    print_status "Package Status Summary:"
    echo "-----------------------------"
    echo -e "${GREEN}Installed${NC} (${#installed_packages[@]}): ${installed_packages[*]}"
    echo
    echo -e "${YELLOW}Outdated${NC} (${#outdated_packages[@]}): ${outdated_packages[*]}"
    echo
    echo -e "${RED}Missing${NC} (${#missing_packages[@]}): ${missing_packages[*]}"
    echo "-----------------------------"
    
    if [ ${#missing_packages[@]} -gt 0 ]; then
        print_warning "Run 'brew install ${missing_packages[*]}' to install missing packages"
    fi
    
    if [ ${#outdated_packages[@]} -gt 0 ]; then
        print_warning "Run 'brew upgrade ${outdated_packages[*]}' to upgrade outdated packages"
    fi
}

check_casks() {
    local cask_list=("$@")
    local missing_casks=()
    local installed_casks=()
    local outdated_casks=()
    
    print_status "Checking Homebrew casks..."
    
    # Get list of installed casks once to avoid repeated calls
    local installed=$(brew list --cask)
    local outdated=$(brew outdated --cask)
    
    for cask in "${cask_list[@]}"; do
        if echo "$installed" | grep -q "^$cask\$"; then
            if echo "$outdated" | grep -q "^$cask\$"; then
                outdated_casks+=("$cask")
            else
                installed_casks+=("$cask")
            fi
        else
            missing_casks+=("$cask")
        fi
    done
    
    echo
    print_status "Cask Status Summary:"
    echo "-----------------------------"
    echo -e "${GREEN}Installed${NC} (${#installed_casks[@]}): ${installed_casks[*]}"
    echo
    echo -e "${YELLOW}Outdated${NC} (${#outdated_casks[@]}): ${outdated_casks[*]}"
    echo
    echo -e "${RED}Missing${NC} (${#missing_casks[@]}): ${missing_casks[*]}"
    echo "-----------------------------"
    
    if [ ${#missing_casks[@]} -gt 0 ]; then
        print_warning "Run 'brew install --cask ${missing_casks[*]}' to install missing casks"
    fi
    
    if [ ${#outdated_casks[@]} -gt 0 ]; then
        print_warning "Run 'brew upgrade --cask ${outdated_casks[*]}' to upgrade outdated casks"
    fi
}

# Define lists of formulas and casks to check
formulas=(
    # Explicitly requested packages (output of brew list --installed-on-request)
    colima docker docker-compose fd ffmpeg fnm fzf
    git gnupg imagemagick jq ncdu neovim poppler
    resvg ripgrep sevenzip stow tmux tree-sitter
    yazi zoxide zsh
)

casks=(
    font-jetbrains-mono-nerd-font
    font-symbols-only-nerd-font
    visual-studio-code
    google-chrome
    stats
    wezterm
    spotify
    1password
    zen
)

check_packages "${formulas[@]}"
echo
check_casks "${casks[@]}"

echo
print_success "Package check completed!"

# Make the script executable
chmod +x "$0"
