" A dummy compiler plugin that clears makeprg and sets errorformat to ignore
" everything in the compiler output.

if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'none'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=
CompilerSet errorformat=.\_^
