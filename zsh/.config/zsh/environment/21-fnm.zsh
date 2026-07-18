#!/bin/zsh

# Exit if fnm is not installed.
(($+commands[fnm])) || return 1

# Initialize the fnm shell environment.
eval "$(fnm env --use-on-cd --shell zsh)"

# Remove the temporary symlink to the current Node.js version on shell exit.
# https://github.com/Schniz/fnm/issues/696
__fnm_cleanup() {
  if [[ -n $FNM_MULTISHELL_PATH && -L $FNM_MULTISHELL_PATH ]]; then
    rm -f $FNM_MULTISHELL_PATH
  fi
}

trap __fnm_cleanup EXIT
