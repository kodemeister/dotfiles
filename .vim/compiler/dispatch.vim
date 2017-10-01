" This compiler file is intended for use together with vim-dispatch plugin.
" Its primary purpose is to prevent vim-dispatch from opening the quickfix
" window after running the program by setting errorformat to match nothing
" in program output. To force vim-dispatch to use this compiler plugin, run
" Dispatch command as follows:
" :Dispatch -compiler=dispatch {program} [arguments]

if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'dispatch'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=make
CompilerSet errorformat=.\_^
