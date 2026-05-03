#!/bin/zsh

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

# Prevent duplicate entries in the $path and $fpath arrays.
typeset -U path fpath

# Initialize the Homebrew shell environment if it is installed.
if (($+commands[brew])); then
  eval $(brew shellenv zsh)
fi

# Prepend user-specific directories to $path if they exist.
path=(
  ~/.local/bin(N)
  ~/bin(N)
  ${path}
)

# Load custom functions from files in .zfunctions.
fpath=(${ZDOTDIR}/.zfunctions ${fpath})
autoload -Uz ${ZDOTDIR}/.zfunctions/*(.:t)

# Set editor-related environment variables.
export EDITOR=micro
export VISUAL=micro
export PAGER=less

# ------------------------------------------------------------------------------
# General
# ------------------------------------------------------------------------------

# Disable annoying beeps.
unsetopt BEEP

# Enable case-insensitive globbing.
unsetopt CASE_GLOB

# Enter just a directory name to automatically change into it.
setopt AUTO_CD

# Prompt to correct misspelled commands and their arguments.
setopt CORRECT_ALL

# Remove the delay after pressing the Esc key.
KEYTIMEOUT=1

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------

# Save the command history to the specified file.
HISTFILE=${ZDOTDIR}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Remove older duplicate commands from the history.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Remove extra spaces from entered commands.
setopt HIST_REDUCE_BLANKS

# Append commands to the history file immediately after they are entered.
setopt INC_APPEND_HISTORY

# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------

# Initialize the completion system.
autoload -Uz compinit && compinit
zmodload zsh/complist

# Enable case-insensitive prefix completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Use arrow keys to select and highlight completions.
zstyle ':completion:*' menu select

# Cancel the completion menu with the Esc key.
bindkey -M menuselect '\e' send-break

# ------------------------------------------------------------------------------
# Keybindings
# ------------------------------------------------------------------------------

# Use Home/End to move the cursor to the start/end of the line.
bind-keys beginning-of-line ${terminfo[khome]} '^[[H' '^[OH'
bind-keys end-of-line ${terminfo[kend]} '^[[F' '^[OF'

# Use Option+Left/Right or Ctrl+Left/Right to move the cursor by words.
bind-keys backward-word ${terminfo[kLFT3]} '^[[1;3D'
bind-keys backward-word ${terminfo[kLFT5]} '^[[1;5D'
bind-keys forward-word ${terminfo[kRIT3]} '^[[1;3C'
bind-keys forward-word ${terminfo[kRIT5]} '^[[1;5C'

# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------

# Install the Antidote plugin manager on the first run.
if [[ ! -d ${ZDOTDIR}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR}/.antidote
fi

# Load all plugins listed in .zsh_plugins.txt.
source ${ZDOTDIR}/.antidote/antidote.zsh
antidote load

# ------------------------------------------------------------------------------
# Additional Settings
# ------------------------------------------------------------------------------

# Apply additional customizations from files in .zshrc.d.
for rc_file in ${ZDOTDIR}/.zshrc.d/*.zsh; do
  source ${rc_file}
done
unset rc_file
