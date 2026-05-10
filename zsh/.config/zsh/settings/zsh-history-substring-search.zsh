#!/bin/zsh

# Use Up/Down to search command history.
bind-keys history-substring-search-up $terminfo[kcuu1] '^[[A' '^[OA'
bind-keys history-substring-search-down $terminfo[kcud1] '^[[B' '^[OB'

# Tweak search highlight colors for better readability.
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold,standout'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold,standout'
