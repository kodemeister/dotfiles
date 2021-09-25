" Begin the plugin section.
call plug#begin(g:config_dir . '/plugged')

" List the required plugins.
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'michaeljsmith/vim-indent-object'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'thinca/vim-visualstar'

" Finish the plugin section, update runtimepath and initialize plugin system.
call plug#end()

" asyncrun.vim

" Automatically open quickfix window when starting an asynchronous job.
let g:asyncrun_open = 10

" Automatically close quickfix window if the asynchronous job has been
" successfully completed.
let g:asyncrun_exit = 'call g:CloseAsyncRunWindow()'

" Toggle quickfix window.
nnoremap <silent> <Leader>q :call asyncrun#quickfix_toggle(10)<CR>

" Run Gpush and Gfetch commands from vim-fugitive with AsyncRun.
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
command! -bang -bar -nargs=* Gpush execute 'AsyncRun<bang> -cwd=' .
    \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'AsyncRun<bang> -cwd=' .
    \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

" asynctasks.vim

" Open Vim/Neovim terminal under the current window.
let g:asynctasks_term_pos = 'bottom'

" Specify the terminal height in lines.
let g:asynctasks_term_rows = 10

" Reuse the terminal window if previous task has been already finished.
let g:asynctasks_term_reuse = 1

" Define mappings for common tasks.
nnoremap <silent> <Leader>m :AsyncTask project-build<CR>
nnoremap <silent> <Leader>r :AsyncTask project-run<CR>

" coc.nvim

" Automatically install the following extensions upon startup.
let g:coc_global_extensions = [
    \   'coc-clangd', 'coc-css', 'coc-eslint', 'coc-go', 'coc-html',
    \   'coc-json', 'coc-prettier', 'coc-pyright', 'coc-sumneko-lua',
    \   'coc-tsserver', 'coc-yaml'
    \ ]

" Remap Tab and S-Tab to gracefully work with auto-completion.
inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-N>" :
    \ g:HasSpaceBefore() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" Confirm current completion with CR.
inoremap <silent> <expr> <CR>
    \ pumvisible() ? coc#_select_confirm() :
    \ luaeval("require('nvim-autopairs').autopairs_cr()")

" Jump to previous or next diagnostic message.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Define mappings for code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <Leader>pt <Plug>(coc-type-definition)
nmap <silent> <Leader>pi <Plug>(coc-implementation)
nmap <silent> <Leader>pu <Plug>(coc-references)

" Show documentation popup about symbol under the cursor.
nnoremap <silent> K :call g:ShowHover()<CR>

" Rename symbol under the cursor.
nmap <silent> <Leader>pr <Plug>(coc-rename)

" Format the selected code.
nmap <silent> <Leader>pf <Plug>(coc-format-selected)
xmap <silent> <Leader>pf <Plug>(coc-format-selected)

" Show signature help.
nnoremap <silent> <S-Tab> :call CocAction('showSignatureHelp')<CR>

" Update signature help when jumping to placeholder.
autocmd vimrc User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Apply code action to the selected code.
nmap <silent> <Leader>pa <Plug>(coc-codeaction-selected)
xmap <silent> <Leader>pa <Plug>(coc-codeaction-selected)

" Apply code action to the entire buffer.
nmap <silent> <Leader>pA <Plug>(coc-codeaction)

" Apply auto fix to the problem on the current line.
nmap <silent> <Leader>pq <Plug>(coc-fix-current)

" Define mappings for function text objects.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Define mappings for class text objects.
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Format the entire buffer.
nnoremap <silent> <Leader>pF :call CocAction('format')<CR>

" Organize imports in the current buffer.
nnoremap <silent> <Leader>pO
    \ :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Switch between C/C++ source and header files.
nnoremap <silent> <Leader><Tab> :CocCommand clangd.switchSourceHeader<CR>

" Define mappings for CoC list commands.
nnoremap <silent> <Leader>pd :CocList diagnostics<CR>
nnoremap <silent> <Leader>pe :CocList extensions<CR>
nnoremap <silent> <Leader>pc :CocList commands<CR>
nnoremap <silent> <Leader>ps :CocList outline<CR>
nnoremap <silent> <Leader>pS :CocList -I symbols<CR>

" ctrlsf.vim

" Ignore case in search patterns.
let g:ctrlsf_case_sensitive = 'no'

" Display CtrlSF prompt and wait for search pattern.
nmap <Leader>/ <Plug>CtrlSFPrompt

" Search for currently selected text.
xmap <Leader>* <Plug>CtrlSFVwordExec

" Search for a word under the cursor.
nmap <Leader>* <Plug>CtrlSFCCwordExec

" fzf.vim

" Configure FZF window position and height.
let g:fzf_layout = {'down': '12'}

" Use ripgrep to speed up fuzzy search.
if empty($FZF_DEFAULT_COMMAND) && executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
endif

" Search in files.
nnoremap <silent> <Leader>e
    \ :call g:RunFZF('Files ' . fnameescape(getcwd()))<CR>

" Search in the currently opened buffers.
nnoremap <silent> <Leader>b :call g:RunFZF('Buffers')<CR>

" vim-airline

" Pick a good airline theme matching current Vim color scheme.
let g:airline_theme = 'tomorrow'

" Use fancy powerline symbols for better looking.
let g:airline_powerline_fonts = 1

" Don't draw separators for empty sections.
let g:airline_skip_empty_sections = 1

" Left pad numbers in the bottom right section with spaces.
let g:airline_section_z = '%3p%% %#__accent_bold#' .
    \ '%{g:airline_symbols.linenr}%3l/%3L' .
    \ '%{g:airline_symbols.maxlinenr}%#__restore__#:%3v'

" Enable/disable certain airline extensions.
let g:airline#extensions#po#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0

" vim-fugitive

" Mappings for the most common vim-fugitive commands.
nmap <silent> <Leader>gs :Git<CR>gg<C-N>
nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gc :Git commit<CR>
nnoremap <silent> <Leader>gps :Git push<CR>
nnoremap <silent> <Leader>gpl :Git pull --rebase<CR>

" vim-rooter

" Don't echo the current working directory.
let g:rooter_silent_chdir = 1

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
