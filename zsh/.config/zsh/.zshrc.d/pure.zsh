# Hack to suppress the initial empty line shown by Pure at the start of a
# terminal session or after clearing the screen.
# https://github.com/sindresorhus/pure/issues/509#issuecomment-3677391393

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
