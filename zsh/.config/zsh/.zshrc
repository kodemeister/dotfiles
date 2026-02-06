# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

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
  ${path}
)

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
# Plugins
# ------------------------------------------------------------------------------

# Install the Antidote plugin manager on the first run.
if [[ ! -d ${ZDOTDIR}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR}/.antidote
fi

# Use nice human-readable names for plugin directories.
zstyle ':antidote:bundle' use-friendly-names yes

# Load zstyle settings for plugins.
source ${ZDOTDIR}/.zstyles

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
