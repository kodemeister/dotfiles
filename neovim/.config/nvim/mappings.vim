" Configure the <Leader> key.
let g:mapleader = "\<Space>"

" Quickly open configuration files.
let g:vimrc_path = fnameescape($MYVIMRC)
let g:functions_path = fnameescape(g:config_dir . '/functions.vim')
let g:mappings_path = fnameescape(g:config_dir . '/mappings.vim')
let g:plugins_path = fnameescape(g:config_dir . '/plugins.vim')
let g:settings_path = fnameescape(g:config_dir . '/settings.vim')
nnoremap <silent> <expr> <Leader>ve ':edit ' . g:vimrc_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vf ':edit ' . g:functions_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vm ':edit ' . g:mappings_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vp ':edit ' . g:plugins_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vs ':edit ' . g:settings_path . "\<CR>"

" Reload the primary configuration file.
nnoremap <silent> <expr> <Leader>vr ':source ' . g:vimrc_path . "\<CR>"

" Fast saving.
nnoremap <silent> <Leader>w :write<CR>

" Clear the last search highlighting.
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

" Jump to the current error in quickfix or location list.
nnoremap <silent> =q :cc<CR>
nnoremap <silent> =l :ll<CR>

" Move cursor up/down by screen lines when wrapping the text.
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <Down> v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <Up> v:count == 0 ? 'gk' : 'k'

" Easy navigation between windows.
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Easy navigation between terminal windows.
tnoremap <C-H> <C-\><C-N><C-W>h
tnoremap <C-J> <C-\><C-N><C-W>j
tnoremap <C-K> <C-\><C-N><C-W>k
tnoremap <C-L> <C-\><C-N><C-W>l

" Open a new terminal in a horizontal or vertical split.
nnoremap <silent> <Leader>tsp :belowright split \| terminal<CR>
nnoremap <silent> <Leader>tvs :belowright vsplit \| terminal<CR>

" Toggle between the current and the alternate file.
nnoremap <Tab> <C-^>

" Make Y yank from the current cursor position to the end of line in order to
" be consistent with C and D.
nnoremap Y y$

" Define a set of mappings to work with black hole register.
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c
nnoremap <Leader>C "_C
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>D "_D
nnoremap <Leader>s "_s
vnoremap <Leader>s "_s
nnoremap <Leader>S "_S
nnoremap <Leader>x "_x
vnoremap <Leader>x "_x
nnoremap <Leader>X "_X

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
