#!/bin/zsh

# Exit if Docker is not installed.
((${+commands[docker]})) || return 1

# Generate Docker completion script if it is not provided by the system.
if ! whence -w _docker >/dev/null; then
  [[ -f ${ZDOTDIR}/functions/_docker ]] \
    || docker completion zsh >${ZDOTDIR}/functions/_docker
fi
