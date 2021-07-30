" General settings.

" Don't clutter the filesystem with garbage files.
set nowritebackup
set noswapfile

" Put unsaved buffers to background when loading new buffers without asking to
" save the current changes first.
set hidden

" Make all yank, delete, change and put operations work with system clipboard.
set clipboard^=unnamed,unnamedplus

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

" Look and feel.

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

" Disable signcolumn, line numbers and cursorline in the terminal.
augroup vimrc
  autocmd TermOpen *
      \ setlocal signcolumn=no nonumber norelativenumber nocursorline |
      \ startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

" Enable list mode, show whitespace characters.
set listchars=tab:»\ ,space:·,trail:·,extends:>,precedes:<
set list

" Don't show the current mode on the last line.
set noshowmode

" Editing and formatting.

" Apply the default settings on startup (but not on script reload).
if has('vim_starting')
  " Use spaces instead of tabs.
  set expandtab

  " Set width of tabs and indents to 4 spaces.
  set tabstop=4
  set shiftwidth=4

  " Disable soft wrapping of long lines.
  set nowrap
endif

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
