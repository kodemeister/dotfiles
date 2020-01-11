" Variables {{{1

" Setup directory paths.
let s:config_dir = expand(has('win32') ?
    \ '$LOCALAPPDATA/nvim' :
    \ '~/.config/nvim')
let s:plugins_dir = s:config_dir . '/plugged'

" Functions {{{1

function! s:RunFZF(command) " {{{2
  if &buftype ==# 'quickfix' || &buftype ==# 'help' ||
      \ &buftype ==# 'terminal' || &filetype ==# 'nerdtree'
    wincmd p
  endif
  execute a:command
endfunction

function! s:HasSpaceBefore() " {{{2
  let l:col = col('.') - 1
  return l:col == 0 || getline('.')[l:col - 1] =~# '\s'
endfunction

" }}}2

" Plugins {{{1

" Begin the plugin section.
call plug#begin(s:plugins_dir)

" List the required plugins.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Valloric/ListToggle'
Plug 'scrooloose/nerdtree'
Plug 'tmsvg/pear-tree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'michaeljsmith/vim-indent-object'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'thinca/vim-visualstar'

" Finish the plugin section, update runtimepath and initialize plugin system.
call plug#end()

" General settings {{{1

" Don't clutter the filesystem with garbage files.
set nowritebackup
set noswapfile

" Put unsaved buffers to background when loading new buffers without asking to
" save the current changes first.
set hidden

" Make all yank, delete, change and put operations work with system clipboard.
set clipboard+=unnamedplus

" Enable 24-bit colors in the terminal.
set termguicolors

" Reduce timeout for keyboard codes like <Esc> to minimal value. This
" eliminates annoying delays while exiting Insert/Visual modes in terminal.
set ttimeoutlen=0

" Don't redraw the display while executing macros.
set lazyredraw

" Ignore case in search patterns.
set ignorecase

" Enable live substitution.
set inccommand=nosplit

" Keep the given number of lines above and below the cursor while scrolling.
set scrolloff=5

" Keep the given number of columns to the left and to the right of the cursor
" while scrolling.
set sidescrolloff=10

" Keep the cursor column while jumping or switching between buffers.
set nostartofline

" Don't show extra information about the currently selected completion.
set completeopt-=preview

" Suppress the annoying completion messages like 'match 1 of 2'.
set shortmess+=c

" Limit the number of items in completion popup menu.
set pumheight=10

" Reduce the timeout used for the CursorHold autocommand event. This option
" is used by coc.nvim and vim-gitgutter plugins.
set updatetime=250

" Define an autocommand group for this script.
augroup vimrc
  autocmd!
  autocmd FileType cpp setlocal commentstring=//\ %s
augroup end

" Look and feel {{{1

" Set some eye candy color scheme.
colorscheme hybrid-dark

" Configure the cursor shape.
set guicursor=n-v-c-sm-o:block,i-ci-ve:ver25,r-cr:hor20,a:blinkon0

" Always show the signcolumn.
set signcolumn=yes

" Show absolute number for the current line and relative numbers for all other
" lines.
set number
set relativenumber

" Disable signcolumn, line numbers and cursorline in the terminal.
augroup vimrc
  autocmd TermOpen *
      \ setlocal signcolumn=no nonumber norelativenumber nocursorline |
      \ startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

" Highlight the line containing the cursor.
if !&diff
  set cursorline
endif

" Disable highlighting of current line in quickfix and diff windows.
augroup vimrc
  autocmd FileType qf setlocal nocursorline
  autocmd OptionSet diff let &l:cursorline = !v:option_new
  autocmd BufEnter *
      \ if !&diff && &buftype !=# 'quickfix' && &buftype !=# 'terminal' |
      \   let &l:cursorline = 1 |
      \ endif
augroup end

" Enable list mode, show whitespace characters.
set listchars=tab:»\ ,space:·,trail:·,extends:>,precedes:<
set list

" Don't show the current mode on the last line.
set noshowmode

" Editing and formatting {{{1

" Apply the default settings on startup (but not on script reload).
if has('vim_starting')
  " Use spaces instead of tabs.
  set expandtab

  " Set width of tabs and indents to 4 spaces.
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4

  " Disable soft wrapping of long lines.
  set nowrap
endif

" Filetype-specific settings.
augroup vimrc
  autocmd FileType go setlocal noexpandtab
  autocmd FileType json,sh,vim,xml,zsh
      \ setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType markdown,text setlocal wrap
augroup end

" Key mappings {{{1

" Configure the <Leader> key.
let g:mapleader = "\<Space>"

" Edit/reload the configuration file.
nnoremap <silent> <expr> <Leader>ve
    \ ':edit ' . fnameescape(resolve($MYVIMRC)) . "\<CR>"
nnoremap <silent> <expr> <Leader>vr
    \ ':source ' . fnameescape(resolve($MYVIMRC)) . "\<CR>"

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
tnoremap <C-H> <C-\><C-N><C-W>h
tnoremap <C-J> <C-\><C-N><C-W>j
tnoremap <C-K> <C-\><C-N><C-W>k
tnoremap <C-L> <C-\><C-N><C-W>l

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

" Open a new terminal in a horizontal or vertical split.
nnoremap <silent> <Leader>tsp :belowright split \| terminal<CR>
nnoremap <silent> <Leader>tvs :belowright vsplit \| terminal<CR>

" Plugin settings {{{1

" coc.nvim {{{2

" Remap Tab and S-Tab to gracefully work with auto-completion.
inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-N>" :
    \ <SID>HasSpaceBefore() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" Confirm current completion with CR.
imap <silent> <expr> <CR>
    \ pumvisible() ? "\<C-Y>" : "\<C-G>u\<Plug>(PearTreeExpand)"

" Update signature help when jumping to placeholder.
autocmd vimrc User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Jump to previous or next diagnostic message.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Define mappings for function text objects.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Define mappings for the most common Coc functions.
nmap <silent> <Leader>] <Plug>(coc-definition)
nmap <silent> <Leader>pt <Plug>(coc-type-definition)
nmap <silent> <Leader>pi <Plug>(coc-implementation)
nmap <silent> <Leader>pu <Plug>(coc-references)
nmap <silent> <Leader>pr <Plug>(coc-rename)
nmap <silent> <Leader>pf <Plug>(coc-format-selected)
vmap <silent> <Leader>pf <Plug>(coc-format-selected)

" Define mappings for the most common Coc commands.
nnoremap <silent> <Leader>K :call CocAction('doHover')<CR>
nnoremap <silent> <Leader>pF :call CocAction('format')<CR>
nnoremap <silent> <Leader>po
    \ :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Define mappings for the most common Coc list commands.
nnoremap <silent> <Leader>pd :CocList diagnostics<CR>
nnoremap <silent> <Leader>pe :CocList extensions<CR>
nnoremap <silent> <Leader>pc :CocList commands<CR>
nnoremap <silent> <Leader>ps :CocList outline<CR>
nnoremap <silent> <Leader>pS :CocList -I symbols<CR>

" ctrlsf.vim {{{2

" Ignore case in search patterns.
let g:ctrlsf_case_sensitive = 'no'

" Perform searches from the project root directory.
let g:ctrlsf_default_root = 'project'

" Define custom project root markers.
let g:ctrlsf_extra_root_markers = ['.projections.json']

" Display CtrlSF prompt and wait for search pattern.
nmap <Leader>/ <Plug>CtrlSFPrompt

" Search for currently selected text.
xmap <Leader>* <Plug>CtrlSFVwordExec

" Search for a word under the cursor.
nmap <Leader>* <Plug>CtrlSFCCwordExec

" fzf.vim {{{2

" Configure FZF window position and height.
let g:fzf_layout = {'down': '12'}

" Use ripgrep to speed up fuzzy search.
if empty($FZF_DEFAULT_COMMAND) && executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
endif

" Search in files.
nnoremap <silent> <Leader>e
    \ :call <SID>RunFZF('Files ' . fnameescape(projectionist#path()))<CR>

" Search in the currently opened buffers.
nnoremap <silent> <Leader>b :call <SID>RunFZF('Buffers')<CR>

" nerdtree {{{2

" Always show all files, don't ignore anything.
let g:NERDTreeIgnore = []

" Set the path to bookmarks file.
let g:NERDTreeBookmarksFile = s:config_dir . '/.NERDTreeBookmarks'

" Display hidden files by default.
let g:NERDTreeShowHidden = 1

" Sort directories first, then files.
let g:NERDTreeSortOrder = ['\/$', '*']

" Don't show annoying 'Press ? for help' banner.
let g:NERDTreeMinimalUI = 1

" Disable cascade displaying/opening of directories that have only one child.
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeCascadeOpenSingleChildDir = 0

" Quickly toggle NERDTree window.
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>

" Reveal the current file in NERDTree window.
nnoremap <silent> =n :NERDTreeFind<CR>

" pear-tree {{{2

" Disable repeating of brace expansion via dot command. Enabling this option
" will erase closing braces after pressing CR.
let g:pear_tree_repeatable_expand = 0

" Try to maintain pair balance instead of always inserting opening and closing
" characters in pairs.
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Insert a space after the opening character and before the closing one.
imap <Space> <Plug>(PearTreeSpace)

" vim-airline {{{2

" Pick a good airline theme matching current Vim color scheme.
let g:airline_theme = 'tomorrow'

" Use fancy powerline symbols for better looking.
let g:airline_powerline_fonts = 1

" Don't draw separators for empty sections.
let g:airline_skip_empty_sections = 1

" Enable/disable certain airline extensions.
let g:airline#extensions#po#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0

" vim-dispatch {{{2

" Force Qt applications to always log to stderr. This is required since Qt
" suppresses debug output when stderr is not attached to a TTY.
let $QT_ASSUME_STDERR_HAS_CONSOLE = 1

" Force Python stdin, stdout and stderr to be unbuffered to see the realtime
" output in quickfix window.
let $PYTHONUNBUFFERED = 1

" Save all modified files and build the project.
nnoremap <silent> <Leader>m :wall <Bar> Make<CR>

" Run the program specified in b:dispatch. The option -compiler=none is needed
" to force vim-dispatch to automatically close the quickfix window after
" running the program.
nnoremap <silent> <Leader>r :Dispatch -compiler=none<CR>

" vim-easy-align {{{2

" Define additional alignment rules.
let g:easy_align_delimiters = {
    \   ':': {'pattern': '::\|:', 'left_margin': 0, 'stick_to_left': 1},
    \   '>': {'pattern': '->\|=>\|>'}
    \ }

" Start interactive EasyAlign in visual mode.
xmap <Leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object.
nmap <Leader>a <Plug>(EasyAlign)

" vim-fugitive {{{2

" Mappings for the most common vim-fugitive commands.
nmap <silent> <Leader>gs :Gstatus<CR>gg<C-N>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gps :Gpush<CR>
nnoremap <silent> <Leader>gpl :Gpull --rebase<CR>

" vim-projectionist {{{2

" Switch between alternate files, e.g. C++ source and header.
nnoremap <silent> <Leader><Tab> :A<CR>

" }}}2

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
