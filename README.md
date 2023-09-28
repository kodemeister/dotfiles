# Dotfiles

This is a collection of my personal configuration files and scripts for Linux, mostly focused on Visual Studio Code with Vim extension, Neovim and fish.

## Installation

Clone this repository to any directory under `$HOME`, e.g. `~/.dotfiles`:

```sh
git clone https://github.com/kodemeister/dotfiles.git ~/.dotfiles
```

Then change the current directory to `~/.dotfiles` and use GNU Stow to install configuration files for desired applications, e.g. Visual Studio Code:

```sh
cd ~/.dotfiles
stow vscode
```

This command will create a symbolic link `~/.config/Code` pointing to `~/.dotfiles/vscode/.config/Code`.
