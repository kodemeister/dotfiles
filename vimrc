" ------------------------------------------------------------------------------
" GENERAL SETTINGS
" ------------------------------------------------------------------------------

" Disable compability with old fashioned Vi
set nocompatible

" Setup the runtime path and initialize Vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" List the required plugins
Plugin 'toiffel/base16-vim'
Plugin 'chriskempson/base16-shell'
Plugin 'bling/vim-airline'

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
	let g:base16_shell_path='~/.vim/bundle/base16-shell'
	let base16colorspace=256
	set t_Co=256
endif

" Set some eye candy color scheme
colorscheme base16-eighties

" Set font when running in GUI mode
if has('gui_running')
	set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline\ 14
	set linespace=4
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

" Set 100% sized cursor shape for Operator-pending mode,
" disable cursor blinking for all modes
if has('gui_running')
	set guicursor+=o:block-Cursor,a:blinkon0
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

" Show relative line numbers
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
" VIM-AIRLINE PLUGIN SETTINGS
" ------------------------------------------------------------------------------

" Use fancy powerline symbols for better looking
let g:airline_powerline_fonts=1

" Enable enhanced tabline
let g:airline#extensions#tabline#enabled=1

" Show only filenames (without full path) in the tabline
let g:airline#extensions#tabline#fnamemod=':t'
