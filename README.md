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

## Quick Start

For quick setup instructions, see [INSTALL.md](INSTALL.md).

```bash
git clone https://github.com/t-panda/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

## Managing Your Dotfiles

For detailed installation instructions and script usage, see [INSTALL.md](INSTALL.md).

### Management Scripts Overview

All management scripts are located in the `scripts/` directory:

- **🚀 `install.sh`**: Full installation setup
- **🔄 `update.sh`**: Update from remote and refresh symlinks
- **⚡ `sync.sh`**: Quick refresh of local symlinks
- **🗑️ `uninstall.sh`**: Complete removal and restoration
- **📋 `aliases.sh`**: Convenient command shortcuts

## Common Usage Scenarios

| Scenario | Command | Description |
|----------|---------|-------------|
| **Daily workflow** | `dotsync` | After changing any config file |
| **Weekly maintenance** | `dotupdate` | Pull latest changes and update |
| **Testing changes** | `dotsync` then test | Apply changes and test before committing |
| **New machine setup** | `./scripts/install.sh` | Complete environment setup |
| **Fix broken setup** | `./scripts/uninstall.sh` | Restore from backups |

For detailed steps for each scenario, see [INSTALL.md](INSTALL.md).

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

Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting changes.

## ⭐ Support

If these dotfiles helped you set up your development environment, consider giving this repository a star! It helps others discover these configurations.

---

<p align="center">
  Made with ❤️ for the developer community
</p>
