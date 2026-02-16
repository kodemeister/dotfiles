# Show Git stash status in the prompt.
zstyle ':prompt:pure:git:stash' show yes

# Adjust prompt colors to work well on both dark and light backgrounds.
zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:git:dirty' color magenta

# Hack to suppress the initial empty line shown by Pure at the start of a
# terminal session or after clearing the screen.
# https://github.com/sindresorhus/pure/issues/509

__pure_first_prompt=1

print() {
  if [[ ${funcstack[-1]} == "prompt_pure_precmd" && $# -eq 0 ]]; then
    if [[ ${__pure_first_prompt} -eq 1 ]]; then
      __pure_first_prompt=0
    else
      builtin print "$@"
    fi
  else
    builtin print "$@"
  fi
}

clear() {
  __pure_first_prompt=1
  command clear
}
