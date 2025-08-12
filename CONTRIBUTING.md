# Contributing to Dotfiles

Thank you for your interest in contributing to this dotfiles repository! This guide will help you understand the project structure, coding standards, and the contribution workflow.

## Table of Contents

- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Contribution Workflow](#contribution-workflow)
- [Commit Guidelines](#commit-guidelines)
- [Testing Changes](#testing-changes)

## Project Structure

The repository is organized into modular "packages" managed by GNU Stow:

```
dotfiles/
├── scripts/            # Management scripts
│   ├── install.sh      # Full installation script
│   ├── uninstall.sh    # Complete uninstall script
│   ├── update.sh       # Update from remote + local sync
│   ├── sync.sh         # Quick local sync script
│   └── aliases.sh      # Convenient shell aliases
├── README.md           # Overview documentation
├── INSTALL.md          # Installation instructions
├── CONTRIBUTING.md     # This file
├── zsh/                # Zsh package
├── nvim/               # Neovim package
├── wezterm/            # WezTerm package
├── yazi/               # Yazi package
├── tmux/               # Tmux package
└── git/                # Git package
```

Each package directory should mirror the structure in the home directory, following GNU Stow conventions.

## Coding Standards

### Shell Scripts

- Use consistent 2-space indentation
- Include a shebang line at the top of each script file (`#!/bin/bash` or `#!/bin/zsh`)
- Add comments for non-obvious functionality
- Use meaningful variable and function names
- Include error handling for critical operations
- Validate user input where appropriate
- Always quote variables that could contain spaces or special characters

Example:

```bash
#!/bin/bash

# Create backup of existing configuration
create_backup() {
  local backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
  echo "Creating backup in $backup_dir"
  
  if mkdir -p "$backup_dir"; then
    # Copy existing dotfiles
    for file in "$@"; do
      if [ -e "$HOME/$file" ]; then
        cp -R "$HOME/$file" "$backup_dir/"
      fi
    done
    return 0
  else
    echo "Error: Failed to create backup directory" >&2
    return 1
  fi
}
```

### Configuration Files

- Use consistent formatting within each config file
- Include comments to explain non-standard settings
- Group related settings together
- Avoid hardcoded paths when possible; use environment variables
- Include default values that work across different environments

## Contribution Workflow

1. **Fork** the repository on GitHub
2. **Clone** your fork to your local machine
3. **Create a branch** with a descriptive name (`git checkout -b feature/new-tmux-keybindings`)
4. **Make your changes** following the coding standards
5. **Test your changes** using the provided scripts
6. **Commit** your changes with clear messages (see [Commit Guidelines](#commit-guidelines))
7. **Push** to your fork on GitHub
8. **Submit a pull request** with a clear description of your changes

## Commit Guidelines

Write clear, concise commit messages following this format:

```
[component]: Short summary of changes (max 72 chars)

More detailed explanation of what changed and why.
Include any relevant context or links to resources.
```

Examples:
- `[tmux]: Add custom status bar with system stats`
- `[nvim]: Update plugin manager to Packer`
- `[scripts]: Fix permission issue in install.sh`

## Testing Changes

Before submitting your changes, ensure they work as expected:

1. **Test locally** by running `./scripts/sync.sh` to apply your changes
2. **Test in a clean environment** if possible (e.g., in a VM or container)
3. **Verify** that your changes don't break existing functionality
4. **Document** any new features or behavior changes

For script changes:
- Check for syntax errors: `bash -n scripts/your-script.sh`
- Run with verbose mode: `bash -x scripts/your-script.sh`

## Adding a New Package

When adding a new tool configuration:

1. Create a new directory following the Stow structure
2. Include a brief README in the package directory explaining the tool and any special setup instructions
3. Update the main installation script to include the new package
4. Update the main README.md to mention the new tool

Thank you for contributing to make these dotfiles better!
