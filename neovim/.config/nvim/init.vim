" Variables {{{1

" Setup directory paths
if has('nvim')
  let s:config_dir = expand(has('win32') ? '$LOCALAPPDATA/nvim' : '~/.config/nvim')
else
  let s:config_dir = expand(has('win32') ? '$USERPROFILE/vimfiles' : '~/.vim')
endif
let s:plugins_dir = s:config_dir . '/plugged'

" Functions {{{1

function! s:RunFZF(command) " {{{2
  if &buftype ==# 'quickfix' || &buftype ==# 'help'
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

" Begin the plugin section
call plug#begin(s:plugins_dir)

" List the required plugins
Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovimhaskell/haskell-vim', {'for': ['haskell']}
Plug 'vim-python/python-syntax', {'for': ['python']}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kana/vim-altr'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kodemeister/vim-hybrid'
Plug 'embear/vim-localvimrc'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-unimpaired'
Plug 'thinca/vim-visualstar'

" Finish the plugin section, update runtimepath and initialize plugin system
call plug#end()

" General settings {{{1

" Set the default character encoding
if !has('nvim')
  set encoding=utf-8
endif

" Set the character encoding used in the script
scriptencoding utf-8

" Don't clutter the filesystem with garbage files
set nobackup
set nowritebackup
set noswapfile
set noundofile

" Put unsaved buffers to background when loading new buffers
" without asking to save the current changes first
set hidden

" Disable mouse support
set mouse=

" Make all yank, delete, change and put operations work with system clipboard
set clipboard^=unnamedplus

" Enable 24-bit colors in the terminal
set termguicolors

" Define 24-bit TrueColor RGB escape sequences
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Define escape sequences to change the cursor shape
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Reduce timeout for keyboard codes like <Esc> to minimal value
" This eliminates annoying delays while exiting Insert/Visual modes in terminal
set ttimeoutlen=0

" Turn off annoying beeps/flashes on errors
set noerrorbells
set novisualbell
set t_vb=

" Don't redraw the display while executing macros
set lazyredraw

" Highlight all matches of the search pattern
set hlsearch

" Ignore case in search patterns
set ignorecase

" When searching, wrap around the beginning or the end of the file
set wrapscan

" Keep the given number of lines above and below the cursor while scrolling
set scrolloff=5

" Keep the cursor column while jumping or switching between buffers
set nostartofline

" Don't jump to matching brackets while typing
set noshowmatch

" Don't show extra information about the currently selected completion
set completeopt-=preview

" Suppress the annoying completion messages like 'match 1 of 2'
set shortmess+=c

" Limit the number of items in completion popup menu
set pumheight=10

" Reduce the timeout used for the CursorHold autocommand event
" This is used by vim-gitgutter plugin to update signs in the gutter
set updatetime=250

" Define an autocommand group for this vimrc
augroup vimrc
  autocmd!
  autocmd FileType cpp setlocal commentstring=//\ %s
augroup end

" Look and feel {{{1

" Use dark variation of color scheme
set background=dark

" Set some eye candy color scheme
colorscheme hybrid

" Set font when running in GUI mode
if has('gui_running')
  if has('gui_gtk')
    set guifont=Literation\ Mono\ Nerd\ Font\ 14,Monospace\ 14
  elseif has('gui_macvim')
    set guifont=Menlo\ Regular:h18
  elseif has('gui_win32')
    set guifont=Powerline\ Consolas:h14:cANSI,Consolas:h14:cANSI
  endif
endif

" Remove menu bar, toolbar and scrollbars
if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=b
endif

" Configure the cursor shape
if has('gui_running') || has('nvim')
  set guicursor=
  set guicursor+=n-v-c:block-Cursor/lCursor
  set guicursor+=i-ci:ver25-Cursor/lCursor
  set guicursor+=r-cr:hor20-Cursor/lCursor
  set guicursor+=ve-o-sm:block-Cursor
  set guicursor+=a:blinkon0
endif

" Show absolute number for the current line and relative numbers for other lines
set number
set relativenumber

" Highlight the line containing the cursor
set cursorline

" Disable highlighting of current line in quickfix and vimdiff windows
augroup vimrc
  autocmd FileType qf setlocal nocursorline
  autocmd OptionSet diff let &l:cursorline = !v:option_new
  autocmd BufEnter * if !&diff && &buftype !=# 'quickfix' | let &l:cursorline = 1 | endif
augroup end

" Enable list mode, show whitespace characters
set listchars=tab:»\ ,space:·,trail:·,extends:>,precedes:<
set list

" Don't show the current mode on the last line
set noshowmode

" Show the current command in the bottom right corner
set showcmd

" Editing and formatting {{{1

" Apply the default settings on startup (but not on vimrc reload)
if has('vim_starting')
  " Use spaces instead of tabs
  set expandtab

  " Set width of tabs and indents to 4 spaces
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4

  " Disable soft wrapping of long lines
  set nowrap

  " Disable hard wrapping of long lines
  set textwidth=0
endif

" Filetype-specific settings
augroup vimrc
  autocmd FileType text,markdown setlocal wrap
  autocmd FileType vim,sh,xml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup end

" Key mappings {{{1

" Configure the <Leader> key
let g:mapleader = "\<Space>"

" Edit/reload Vim configuration file
nnoremap <silent> <expr> <Leader>ve ':edit ' . fnameescape(resolve($MYVIMRC)) . "\<CR>"
nnoremap <silent> <expr> <Leader>vr ':source ' . fnameescape(resolve($MYVIMRC)) . "\<CR>"

" Fast saving
nnoremap <silent> <Leader>w :write<CR>

" Clear the last search highlighting
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

" Jump to the current error in quickfix or location list
nnoremap <silent> =q :cc<CR>
nnoremap <silent> =l :ll<CR>

" Move cursor up/down by screen lines when wrapping the text
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> <Down> v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <Up> v:count == 0 ? 'gk' : 'k'

" Easy navigation between windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Toggle between the current and the alternate file
nnoremap <Tab> <C-^>

" Make Y yank from the current cursor position to the end of line,
" to be consistent with C and D
nnoremap Y y$

" Define a set of mappings to work with black hole register
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

" Plugin settings {{{1

" ale {{{2

" Define a set of linters to be run when checking particular filetypes.
let g:ale_linters = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'haskell': ['hie'],
    \ 'objc': ['clangd'],
    \ 'objcpp': ['clangd'],
    \ 'python': ['pyls'],
    \ 'sh': ['shell'],
    \ 'vim': ['vint']
    \ }

" Don't lint vim-fugitive buffers.
let g:ale_pattern_options = {
    \ '^fugitive://': {'ale_enabled': 0}
    \ }

" Always show the sign column.
let g:ale_sign_column_always = 1

" Define symbols displayed in the Vim gutter.
let g:ale_sign_error = '✖'
let g:ale_sign_info = 'ℹ'
let g:ale_sign_warning = '⚠'

" Mappings for the most common ALE commands.
nnoremap <silent> <Leader>] :ALEGoToDefinition<CR>
nnoremap <silent> <Leader>K :ALEHover<CR>
nnoremap <silent> <Leader>pu :ALEFindReferences<CR>

" asyncrun.vim {{{2

" Automatically open quickfix window when starting an asynchronous job.
let g:asyncrun_open = 10

" Close quickfix window if the asynchronous job has been successfully
" completed.
let g:asyncrun_exit = '
    \ if g:asyncrun_code == 0 |
    \   call asyncrun#quickfix_toggle(10, 0) |
    \ endif
    \ '

" Force Qt applications to always log to stderr. This is required since Qt
" suppresses debug output when stderr is not attached to a TTY.
let $QT_LOGGING_TO_CONSOLE = 1

" Force Python stdin, stdout and stderr to be unbuffered to see the realtime
" output in quickfix window.
let $PYTHONUNBUFFERED = 1

" Save all modified files and build the project.
nnoremap <silent> <Leader>m :AsyncRun -program=make -save=2<CR>

" Toggle quickfix window.
nnoremap <silent> <Leader>q :call asyncrun#quickfix_toggle(10)<CR>

" ctrlsf.vim {{{2

" Ignore case in search patterns.
let g:ctrlsf_case_sensitive = 'no'

" Display CtrlSF prompt and wait for search pattern.
nmap <Leader>/ <Plug>CtrlSFPrompt

" Search for currently selected text.
xmap <Leader>* <Plug>CtrlSFVwordExec

" Search for a word under the cursor.
nmap <Leader>* <Plug>CtrlSFCCwordExec

" delimitMate {{{2

" Insert an indent when pressing <CR> inside empty pair of matching characters
let g:delimitMate_expand_cr = 1

" fzf.vim {{{2

" Configure FZF window position and height
let g:fzf_layout = {'down': '12'}

" Use rg to speed up file indexing
if executable('rg') && empty($FZF_DEFAULT_COMMAND)
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git/*"'
endif

" Search in files
nnoremap <silent> <Leader>f :call <SID>RunFZF('Files ' . fnameescape(getcwd()))<CR>

" Search in the currently opened buffers
nnoremap <silent> <Leader>b :call <SID>RunFZF('Buffers')<CR>

" netrw {{{2

" Hide annoying banner at the top of the window
let g:netrw_banner = 0

" Sort directories first, then files
let g:netrw_sort_sequence = '[\/]$,*'

" Show the directory listing in the current window
nnoremap <silent> - :Explore<CR>

" Refresh file list with R since <C-L> is used for navigation between windows
autocmd vimrc FileType netrw nmap <buffer> r <Plug>NetrwRefresh

" python-syntax {{{2

let g:python_highlight_all = 1

" vim-airline {{{2

" Pick a good airline theme matching current Vim color scheme
let g:airline_theme = 'tomorrow'

" Use fancy powerline symbols for better looking
let g:airline_powerline_fonts = 1

" Don't draw separators for empty sections
let g:airline_skip_empty_sections = 1

" Enable/disable certain airline extensions
let g:airline#extensions#po#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0

" vim-altr {{{2

" Switch between associated files, e.g. C++ header and implementation
nmap <Leader><Tab> <Plug>(altr-forward)

" Define additional vim-altr rules
call altr#define('%/src/%.c', '%/src/%.cpp', '%/src/%.cc',
  \ '%/src/%.m', '%/src/%.mm', '%/include/%.h', '%/include/%.hpp')
call altr#define('%/Sources/%.c', '%/Sources/%.cpp', '%/Sources/%.cc',
  \ '%/Sources/%.m', '%/Sources/%.mm', '%/Include/%.h', '%/Include/%.hpp')

" vim-easy-align {{{2

" Define additional alignment rules.
let g:easy_align_delimiters = {
    \ ':': {'pattern': '::\|:', 'left_margin': 0, 'stick_to_left': 1},
    \ '>': {'pattern': '->\|=>\|>'}
    \ }

" Start interactive EasyAlign in visual mode.
xmap <Leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object.
nmap <Leader>a <Plug>(EasyAlign)

" vim-fugitive {{{2

" Mappings for the most common vim-fugitive commands
nmap <silent> <Leader>gs :Gstatus<CR>gg<C-n>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gps :Gpush<CR>
nnoremap <silent> <Leader>gpl :Gpull --rebase<CR>

" vim-localvimrc {{{2

" Don't load local vimrc files in a sandbox
let g:localvimrc_sandbox = 0

" Don't ask before sourcing local vimrc files
let g:localvimrc_ask = 0

" vim-rooter {{{2

" Don't echo the current working directory
let g:rooter_silent_chdir = 1

" }}}2

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
