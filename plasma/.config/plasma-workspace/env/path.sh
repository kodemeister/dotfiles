#!/bin/bash

# Add user directories to $PATH if they exist.
if [[ -d "$HOME/.ghcup/bin" ]]; then
  export PATH="$HOME/.ghcup/bin:$PATH"
fi
