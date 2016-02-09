" ------------------------------------------------------------------------------
" GENERAL SETTINGS
" ------------------------------------------------------------------------------

" Disable compability with old fashioned Vi
set nocompatible

" Setup the runtime path and initialize Vundle
filetype off
let s:config_dir = expand(has('win32') ? '$USERPROFILE/vimfiles' : '~/.vim')
let s:cache_dir = s:config_dir . '/.cache'
let &runtimepath .= ',' . s:config_dir . '/bundle/Vundle.vim'
call vundle#begin(s:config_dir . '/bundle')

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" List the required plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'kana/vim-altr'
Plugin 'mileszs/ack.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdtree'
Plugin 'toiffel/base16-shell'
Plugin 'toiffel/base16-vim'

" Finish with plugin stuff
call vundle#end()

" Enable automatic detection of file type, allow loading plugins and
" indent files for specific file types
filetype on
filetype plugin on
filetype indent on

" Set the default character encoding
set encoding=utf-8

" Set the number of commands to be remembered in history
set history=100

" Automatically read files that has been changed outside of Vim
set autoread

" Don't clutter the filesystem with garbage files
set nobackup
set nowritebackup
set noswapfile
set noundofile

" Put unsaved buffers to background when loading new buffers
" without asking to save the current changes first
set hidden

" ------------------------------------------------------------------------------
" UI SETTINGS
" ------------------------------------------------------------------------------

" Enable syntax highlighting
syntax enable

" Use dark variation of color scheme
set background=dark

" Modify 256 colorspace to make base16 color schemes look fine in terminal
if !has('gui_running')
	let g:base16_shell_path = s:config_dir . '/bundle/base16-shell'
	let base16colorspace = 256
	set t_Co=256
endif

" Set some eye candy color scheme
colorscheme base16-ocean

" Set font when running in GUI mode
if has('gui_running')
	if has('gui_gtk2')
		set guifont=Droid\ Sans\ Mono\ Slashed\ 14
		set linespace=4
	elseif has('gui_macvim')
		set guifont=Menlo\ Regular:h18
	elseif has('gui_win32')
		set guifont=Consolas:h14:cANSI
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
if has('gui_running')
	set guicursor+=o:block-Cursor,a:blinkon0
elseif &term =~ 'xterm\|rxvt'
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[4 q"
	let &t_EI = "\<Esc>[2 q"
endif

" Turn off annoying beeps/flashes on errors
set noerrorbells
set novisualbell
set t_vb=

" Don't redraw the display while executing macros
set lazyredraw

" Disable soft wrapping of long lines
set nowrap

" Disable hard wrapping of long lines
set textwidth=0

" Show absolute number for the current line and relative numbers for other lines
set number
set relativenumber

" Highlight the line containing the cursor
set cursorline

" Keep the given number of lines above and below the cursor while scrolling
set scrolloff=5

" Enable list mode, show whitespace characters
set listchars=tab:»\ ,space:·,trail:·,extends:>,precedes:<
set list

" Enable the enhanced command-line completion
set wildmenu

" Always show the status line, even if there is only one window opened
set laststatus=2

" Show the current mode on the last line
set showmode

" Show the current command in the bottom right corner
set showcmd

" Show the cursor position in the bottom right corner
set ruler

" ------------------------------------------------------------------------------
" EDIT SETTINGS
" ------------------------------------------------------------------------------

" Set width of tabs and indents to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Always use tabs instead of spaces
set noexpandtab

" Enable automatic indenting of new lines
set autoindent

" Enable automatic indenting for C-like programs
set cindent

" Allow backspacing over autoindent, line break and the start of insert
set backspace=indent,eol,start

" Keep the cursor column while jumping or switching between buffers
set nostartofline

" ------------------------------------------------------------------------------
" SEARCH SETTINGS
" ------------------------------------------------------------------------------

" Highlight all matches of the search pattern
set hlsearch

" Jump to matches while typing a search command
set incsearch

" Ignore case in search patterns
set ignorecase

" When searching, wrap around the beginning or the end of the file
set wrapscan

" Don't jump to matching brackets while typing
set noshowmatch

" ------------------------------------------------------------------------------
" KEY MAPPINGS
" ------------------------------------------------------------------------------

" Reduce timeout for keyboard codes like <Esc> to minimal value
" This eliminates annoying delays while exiting Insert/Visual modes in terminal
set ttimeoutlen=0

" Configure the <Leader> key
let mapleader = ','

" Press <Leader> twice for backward searches
nnoremap <Leader><Leader> ,

" Fast saving
nmap <silent> <Leader>w :w<CR>

" Save all modified files and build the project
nmap <silent> <Leader>m :wall <Bar> make!<CR>

" Clear the last search highlighting
nmap <silent> <Leader><Space> :nohlsearch<CR>

" Easy navigation between windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Make Y yank from the current cursor position to the end of line,
" to be consistent with C and D
nnoremap Y y$

" Enable 'very magic' mode for all searches to be consistent with Ack
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" ------------------------------------------------------------------------------
" VIM-AIRLINE PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Enable enhanced tabline
let g:airline#extensions#tabline#enabled = 1

" Show only filenames (without full path) in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'

" Define 'straight' tabs in the statusline and tabline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" ------------------------------------------------------------------------------
" CTRLP.VIM PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Set the directory to store cache files
let g:ctrlp_cache_dir = s:cache_dir . '/ctrlp'

" Don't jump to buffer if it's already opened in a window somewhere
" This is useful when opening the same buffer in different windows
let g:ctrlp_switch_buffer = 0

" Do not limit the maximum number of files to scan
let g:ctrlp_max_files = 0

" Use ag to speed up file indexing
if executable('ag')
	let g:ctrlp_user_command = 'ag -l -g "" --nocolor %s'
endif

" Use Python-based matcher to speed up matching
if has('python') || has('python3')
	let g:ctrlp_match_func = {'match' : 'pymatcher#PyMatch'}
endif

" Search in the currently opened buffers
nmap <silent> <Leader>b :CtrlPBuffer<CR>

" ------------------------------------------------------------------------------
" VIM-ALTR PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Define additional vim-altr rules
call altr#define('%/src/%.c', '%/src/%.cpp', '%/src/%.cc', '%/src/%.m',
	\'%/src/%.mm', '%/include/%.h', '%/include/%.hpp')

" Switch between associated files, e.g. C++ header and implementation
nmap <Leader>a <Plug>(altr-forward)

" ------------------------------------------------------------------------------
" ACK.VIM PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Specify the default arguments given to ack
let g:ack_default_options = ' -i -s -H --nocolor --nogroup --column'

" Highlight all matches of the search pattern
let g:ackhighlight = 1

" Use ag to speed up file searching
if executable('ag')
	let g:ackprg = 'ag -i --vimgrep'
endif

" Display ack prompt and place the cursor into the quotes
nmap <Leader>/ :Ack!<Space>""<Left>

" Search for word under the cursor
nmap <Leader>* :Ack!<CR>

" ------------------------------------------------------------------------------
" VIM-BUFKILL PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Disable predefined bufkill mappings
let g:BufKillCreateMappings = 0

" Delete a buffer without closing the window it was displayed in
nmap <silent> <Leader>q :BD<CR>

" ------------------------------------------------------------------------------
" NERD TREE PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Open NERD tree on startup, move cursor back to the main window
autocmd VimEnter * NERDTree | setlocal nolist | wincmd p

" Don't show unneeded 'Press ? for help' label
let NERDTreeMinimalUI = 1

" Sort directories first, then files
let NERDTreeSortOrder = ['\/$', '*']

" Enable case-sensitive sorting
let NERDTreeCaseSensitiveSort = 1

" Display hidden files by default
let NERDTreeShowHidden = 1

" Always show all files, don't ignore anything
let NERDTreeIgnore = []
