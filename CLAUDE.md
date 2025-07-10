# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing shell configurations, editor settings, and development environment setup scripts. The repository uses symbolic linking to install configurations to the home directory.

## Setup and Installation

### Initial Setup
```bash
# Install dotfiles by creating symbolic links
python3 setup.py
```

The `setup.py` script creates symbolic links from `$HOME/dotfiles/` to `$HOME/.{filename}` for all files except those in the IGNORE list (README.md, setup.py).

### Nix Setup (Optional)
```bash
# Bootstrap Nix with Home Manager and flakes
./bootstrap-nix.sh
```

## Key Configuration Files

### Shell Configuration
- **zshrc**: Oh-My-Zsh configuration with gruvbox theme
  - Requires: gruvbox theme, Hack Nerd Font for optimal display
  - Uses gruvbox color scheme
- **bashrc**: Standard bash configuration with history settings
- **bash_aliases**: Custom shell aliases
- **zshrc_user**: User-specific zsh customizations

### Editor Configuration
- **nvim/init.lua**: Neovim configuration with native LSP
  - Uses lazy.nvim for plugin management
  - Configured for Python development with pyright and ruff LSP
  - Leader key: space
  - YAML files use 2-space indentation, others use 4-space
- **vimrc**: Traditional Vim configuration
- **ideavimrc**: IntelliJ IDEA Vim plugin configuration

### Git Configuration
- **gitconfig**: Global git settings
  - Editor: nvim
  - Merge tool: meld
  - Git LFS enabled
  - Custom GUI alias
- **gitignore_global**: Global gitignore patterns

### Development Environment
- **tmux.conf**: Terminal multiplexer configuration
- **inputrc**: Readline configuration
- **ipython_config.py**: IPython REPL customizations
- **pythonrc**: Python REPL startup configuration

## Architecture Notes

The repository follows a simple flat structure where each configuration file corresponds to a dotfile in the home directory. The setup script automates the symlinking process, making it easy to maintain configurations in version control while keeping them accessible to applications that expect them in standard locations.

Configuration files are organized by tool/application, with shell configurations supporting both bash and zsh environments. The Neovim configuration uses modern Lua-based setup with LSP integration for development work.