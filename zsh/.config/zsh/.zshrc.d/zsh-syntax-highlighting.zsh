#!/bin/zsh

# Enable highlighting for user-defined regular expressions and brackets.
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(regexp brackets)

# Customize the default syntax highlighting styles.
set-array-item ZSH_HIGHLIGHT_STYLES commandseparator 'fg=magenta'
set-array-item ZSH_HIGHLIGHT_STYLES path 'fg=blue,underline'
set-array-item ZSH_HIGHLIGHT_STYLES single-hyphen-option 'fg=cyan'
set-array-item ZSH_HIGHLIGHT_STYLES double-hyphen-option 'fg=cyan'
set-array-item ZSH_HIGHLIGHT_STYLES redirection 'fg=magenta'
set-array-item ZSH_HIGHLIGHT_STYLES numeric-fd 'fg=magenta'

# Highlight unquoted parameter expansions (e.g. $PATH, ${HOME}).
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/509
ZSH_HIGHLIGHT_REGEXP+=('\$([[:alnum:]_-]+|\{[^}]+\})' 'fg=cyan')
