#!/bin/bash

# Quick sync script for local dotfiles changes
# This script can be run from anywhere and will update symlinks immediately

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[SYNC]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SYNC]${NC} $1"
}

# Find the dotfiles directory (assuming this script is in dotfiles/scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

print_status "Syncing dotfiles from $DOTFILES_DIR..."

# Run the update script in local mode
"$SCRIPT_DIR/update.sh" --local

print_success "Dotfiles synced! All changes are now active."
