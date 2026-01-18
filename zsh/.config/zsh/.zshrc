# Prevent duplicate entries in the $path and $fpath arrays.
typeset -U path fpath

# Initialize the Homebrew shell environment if it is installed.
if (( $+commands[brew] )); then
  eval $(brew shellenv zsh)
fi

# Prepend user-specific directories to $path if they exist.
path=(
  ~/.local/bin(N)
  ~/bin(N)
  $path
)

# Set editor-related environment variables.
export EDITOR=micro
export VISUAL=micro
export PAGER=less
