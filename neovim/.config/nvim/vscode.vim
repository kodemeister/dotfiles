" Begin the plugin section.
call plug#begin(g:config_dir . '/plugged')

" List the required plugins.
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-repeat'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'thinca/vim-visualstar'

" Finish the plugin section, update runtimepath and initialize plugin system.
call plug#end()

" Overwrite mappings for quick opening configuration files.
let g:vimrc_path = fnameescape($MYVIMRC)
let g:functions_path = fnameescape(g:config_dir . '/functions.vim')
let g:mappings_path = fnameescape(g:config_dir . '/mappings.vim')
let g:plugins_path = fnameescape(g:config_dir . '/plugins.vim')
let g:settings_path = fnameescape(g:config_dir . '/settings.vim')
let g:vscode_path = fnameescape(g:config_dir . '/vscode.vim')
nnoremap <silent> <expr> <Leader>ve ':Edit ' . g:vimrc_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vf ':Edit ' . g:functions_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vm ':Edit ' . g:mappings_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vp ':Edit ' . g:plugins_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vs ':Edit ' . g:settings_path . "\<CR>"
nnoremap <silent> <expr> <Leader>vc ':Edit ' . g:vscode_path . "\<CR>"

" Overwrite mapping for fast saving.
nnoremap <silent> <Leader>w :Write<CR>

" Comment/uncomment selected code.
xmap gc <Plug>VSCodeCommentary
nmap gc <Plug>VSCodeCommentary
omap gc <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine
