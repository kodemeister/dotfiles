#!/bin/zsh

# Exit if Homebrew is not installed.
(($+commands[brew])) || return 1

# Initialize the Homebrew shell environment.
eval "$(brew shellenv zsh)"

# Disable anonymous analytics.
export HOMEBREW_NO_ANALYTICS=1

# Suppress annoying hints about Homebrew environment variables.
export HOMEBREW_NO_ENV_HINTS=1
