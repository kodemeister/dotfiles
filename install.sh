#!/bin/bash

# This script downloads any additional stuff (Prezto, Vim plugins, tmux plugins)
# and creates symlinks to all configuration files to user's home directory.
#
# Usage: ./install.sh
#
# Make sure to backup your existing configuration before running this script.
# It will warn you about any existing dotfiles but won't overwrite them.
# In this case backup the conflicting files and re-run the script.

# Paths to dotfiles repository and user's home directory.
# Dotfiles repository must be cloned somewhere inside the home directory.
declare -r DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -r HOME_DIR="$HOME"

# List of symlinks to be created in the form: ["symlink name"]="symlink target".
declare -rA SYMLINKS=(
  [".config/cmus"]=".config/cmus"
  [".config/fontconfig"]=".config/fontconfig"
  [".config/kitty"]=".config/kitty"
  [".config/mpv"]=".config/mpv"
  [".config/nvim"]=".vim"
  [".config/zathura"]=".config/zathura"
  [".config/compton.conf"]=".config/compton.conf"
  [".local/share/fonts"]=".local/share/fonts"
  [".tmux"]=".tmux"
  [".vim"]=".vim"
  [".zprezto"]=".zprezto"
  [".Xmodmap"]=".Xmodmap"
  [".inputrc"]=".inputrc"
  [".tmux.conf"]=".tmux.conf"
  [".vimrc"]=".vim/vimrc"
  [".zlogin"]=".zprezto/runcoms/zlogin"
  [".zlogout"]=".zprezto/runcoms/zlogout"
  [".zpreztorc"]=".zprezto/runcoms/zpreztorc"
  [".zprofile"]=".zprezto/runcoms/zprofile"
  [".zshenv"]=".zprezto/runcoms/zshenv"
  [".zshrc"]=".zprezto/runcoms/zshrc"
)

# Clone or update Git repository.
# $1 - URL of Git repository.
# $2 - path to directory to clone into.
clone_repo()
{
  if [[ -d "$2" ]] && cd "$2" && git status; then
    git pull
    git submodule update --init --recursive
  else
    rm -rf "$2"
    mkdir -p "$(dirname "$2")"
    git clone --depth 1 --recursive "$1" "$2"
  fi
}

# Create a relative symlink to the specified file.
# $1 - path to symlink target file.
# $2 - path to symlink to be created.
make_symlink()
{
  local relative_path="$(python -c "import os.path; print(os.path.relpath('$1', '${2%/*}'))")"
  if [[ ! -e "$2" ]]; then
    mkdir -p "$(dirname "$2")"
    ln -s "$relative_path" "$2"
  elif [[ ! -L "$2" || "$(readlink "$2")" != "$relative_path" ]]; then
    echo "$(tput setaf 11)Warning:$(tput sgr 0) $2 already exists, skipping"
  fi
}

main()
{
  # Download vim-plug plugin manager.
  curl -fLo "$DOTFILES_DIR/.vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  # Install Vim plugins.
  IFS=$'\n'
  local vim_plugins="$(sed -n "s/^Plug '\([^']\+\)'.*$/\1/p" "$DOTFILES_DIR/.vim/vimrc")"
  for plugin in $vim_plugins; do
    clone_repo "https://github.com/$plugin.git" "$DOTFILES_DIR/.vim/plugged/${plugin##*/}"
  done

  # Install tmux plugins.
  local tmux_plugins="$(sed -n "s/^set -g @plugin '\([^']\+\)'.*$/\1/p" "$DOTFILES_DIR/.tmux.conf")"
  for plugin in $tmux_plugins; do
    clone_repo "https://github.com/$plugin.git" "$DOTFILES_DIR/.tmux/plugins/${plugin##*/}"
  done

  # Clone Prezto repository.
  clone_repo "https://github.com/kodemeister/prezto.git" "$DOTFILES_DIR/.zprezto"

  # Create symlinks from the home directory to files under the dotfiles directory.
  for key in "${!SYMLINKS[@]}"; do
    make_symlink "$DOTFILES_DIR/${SYMLINKS[$key]}" "$HOME_DIR/$key"
  done

  # Generate Vim help tags.
  vim "+helptags ALL" "+qall"
}

main "$@"
