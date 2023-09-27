#!/bin/bash

# Add user-wide bin directories to $PATH if they exist.
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.ghcup/bin" ]; then
  export PATH="$HOME/.ghcup/bin:$PATH"
fi
