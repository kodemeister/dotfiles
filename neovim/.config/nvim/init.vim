" Setup path to the configuration directory.
let g:config_dir = stdpath('config')

" Configure the <Leader> key.
let g:mapleader = "\<Space>"

" Create an empty autocommand group for configuration files.
augroup vimrc
  autocmd!
augroup end

" Enable live substitution.
set inccommand=nosplit

" Disable signcolumn, line numbers and cursorline in the terminal.
augroup vimrc
  autocmd TermOpen *
      \ setlocal signcolumn=no nonumber norelativenumber nocursorline |
      \ startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

" Easy navigation between terminal windows.
tnoremap <C-H> <C-\><C-N><C-W>h
tnoremap <C-J> <C-\><C-N><C-W>j
tnoremap <C-K> <C-\><C-N><C-W>k
tnoremap <C-L> <C-\><C-N><C-W>l

" Open a new terminal in a horizontal or vertical split.
nnoremap <silent> <Leader>tsp :belowright split \| terminal<CR>
nnoremap <silent> <Leader>tvs :belowright vsplit \| terminal<CR>

" Load the configuration files.
runtime functions.vim
runtime settings.vim
runtime mappings.vim
runtime plugins.vim

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
