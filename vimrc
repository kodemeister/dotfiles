" Variables {{{1

" Disable compability with old fashioned Vi
set nocompatible

" Setup directory paths
if has('nvim')
  let s:config_dir = expand(has('win32') ? '$LOCALAPPDATA/nvim' : '~/.config/nvim')
else
  let s:config_dir = expand(has('win32') ? '$USERPROFILE/vimfiles' : '~/.vim')
endif
let s:cache_dir = s:config_dir . '/.cache'

" Setup global variables
let s:use_fzf = executable('fzf') && !has('gui_running')

" Functions {{{1

function! s:GetVisualSelection() " {{{2
  let old_reg = getreg('"')
  let old_reg_type = getregtype('"')
  normal! gv""y
  let selection = getreg('"')
  call setreg('"', old_reg, old_reg_type)
  return selection
endfunction

function! s:SearchVisualSelection(command) " {{{2
  let selection = s:GetVisualSelection()
  let @/ = '\V' . substitute(escape(selection, a:command . '\'), '\n', '\\n', 'g')
  call feedkeys(a:command . @/ . "\<CR>", 'n')
endfunction

function! s:SearchVisualSelectionInFiles() " {{{2
  let selection = s:GetVisualSelection()

  if selection =~ '\n'
    echohl ErrorMsg | echomsg 'Multiline search is not supported' | echohl None
    return
  endif

  let pattern = shellescape(selection)
  call ack#Ack('grep!', '-Q ' . pattern)

  let @/ = '\V' . escape(selection, '\')
  call histadd('/', @/)
  call feedkeys(":let &hlsearch=1 \| echo\<CR>", 'n')
endfunction

function! s:SearchCurrentWordInFiles() " {{{2
  let word = expand('<cword>')

  if empty(word)
    echohl ErrorMsg | echomsg 'No string under cursor' | echohl None
    return
  endif

  let pattern = shellescape(word)
  call ack#Ack('grep!', '-Q -w ' . pattern)

  let @/ = '\V\<' . escape(word, '\') . '\>'
  call histadd('/', @/)
  call feedkeys(":let &hlsearch=1 \| echo\<CR>", 'n')
endfunction

" }}}2

" General settings {{{1

" Set the default character encoding
if !has('nvim')
  set encoding=utf-8
endif

" Don't clutter the filesystem with garbage files
set nobackup
set nowritebackup
set noswapfile
set noundofile

" Put unsaved buffers to background when loading new buffers
" without asking to save the current changes first
set hidden

" Filetype-specific settings
augroup vimrc
  autocmd!
  autocmd FileType text setlocal wrap
augroup end

" UI settings {{{1

" Use dark variation of color scheme
set background=dark

" Use colors from custom terminal theme
if !has('gui_running')
  let g:hybrid_custom_term_colors = 1
endif

" Set some eye candy color scheme
colorscheme hybrid

" Set font when running in GUI mode
if has('gui_running')
  if has('gui_gtk')
    set guifont=Fira\ Mono\ 14,Monospace\ 14
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
elseif has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
else
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

" Don't show the current mode on the last line
set noshowmode

" Show the current command in the bottom right corner
set showcmd

" Edit settings {{{1

" Set width of tabs and indents to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Always use tabs instead of spaces
set noexpandtab

" Disable mouse support
set mouse=

" Allow backspacing over autoindent, line break and the start of insert
" Required to avoid an error message from delimitMate upon startup
set backspace=indent,eol,start

" Keep the cursor column while jumping or switching between buffers
set nostartofline

" Search settings {{{1

" Highlight all matches of the search pattern
set hlsearch

" Ignore case in search patterns
set ignorecase

" When searching, wrap around the beginning or the end of the file
set wrapscan

" Don't jump to matching brackets while typing
set noshowmatch

" Key mappings {{{1

" Configure the <Leader> key
let mapleader = "\<Space>"

" Edit/reload Vim configuration file
nnoremap <silent> <Leader>ve :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>vr :source $MYVIMRC<CR>

" Fast saving
nnoremap <silent> <Leader>w :write<CR>

" Save all modified files and build the project
nnoremap <silent> <Leader>m :wall <Bar> Make<CR>

" Clear the last search highlighting
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

" Move cursor up/down by screen lines when wrapping the text
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" Easy navigation between windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Make Y yank from the current cursor position to the end of line,
" to be consistent with C and D
nnoremap Y y$

" Replace built-in * and # behavior in Visual mode
xnoremap <silent> * :<C-u>call <SID>SearchVisualSelection('/')<CR>
xnoremap <silent> # :<C-u>call <SID>SearchVisualSelection('?')<CR>

" Plugin settings {{{1

" ack.vim {{{2

" Specify the default arguments given to ack
let g:ack_default_options = ' -i -s -H --nocolor --nogroup --column'

" Highlight all matches of the search pattern
let g:ackhighlight = 1

" Use ag to speed up file searching
if executable('ag')
  let g:ackprg = 'ag -i --vimgrep'
endif

" Display ack prompt and place the cursor into the quotes
nnoremap <Leader>/ :Ack! ''<Left>
nnoremap <Leader>? :Ack! ''<Left>

" Search for currently selected text
xnoremap <silent> <Leader>* :<C-u>call <SID>SearchVisualSelectionInFiles()<CR>
xnoremap <silent> <Leader># :<C-u>call <SID>SearchVisualSelectionInFiles()<CR>

" Search for word under the cursor
nnoremap <silent> <Leader>* :call <SID>SearchCurrentWordInFiles()<CR>
nnoremap <silent> <Leader># :call <SID>SearchCurrentWordInFiles()<CR>

" ctrlp.vim {{{2

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

if !s:use_fzf
  " Search in the currently opened buffers
  nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
else
  " Disable default CtrlP mapping
  let g:ctrlp_map = ''
endif

" delimitMate {{{2

" Insert an indent when pressing <CR> inside empty pair of matching characters
let delimitMate_expand_cr = 1

" fzf.vim {{{2

" Configure FZF window position and height
let g:fzf_layout = {'down': '12'}

" Use ag to speed up file indexing
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -l -g "" --nocolor'
endif

if s:use_fzf
  " Search in files
  nnoremap <silent> <expr> <C-p> ':FZF ' . fnameescape(projectroot#guess()) . '<CR>'

  " Search in the currently opened buffers
  nnoremap <silent> <Leader>b :Buffers<CR>
endif

" netrw {{{2

" Hide annoying banner at the top of the window
let g:netrw_banner = 0

" Don't clutter the buffer list with old directory listings
let g:netrw_fastbrowse = 0

" <C-^> switches to the last edited file instead of directory listing
let g:netrw_altfile = 1

" Show the directory listing in the current window
nnoremap <silent> - :Explore<CR>

" Refresh file list with R since <C-L> is used for navigation between windows
autocmd vimrc FileType netrw nmap <buffer> r <Plug>NetrwRefresh

" vim-airline {{{2

" Pick a good airline theme matching current Vim color scheme
let g:airline_theme = 'hybrid'

" Enable enhanced tabline
let g:airline#extensions#tabline#enabled = 1

" Show only filenames (without full path) in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'

" Define 'straight' tabs in the statusline and tabline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" vim-altr {{{2

" Switch between associated files, e.g. C++ header and implementation
nmap <Leader>a <Plug>(altr-forward)

" vim-bufkill {{{2

" Disable predefined bufkill mappings
let g:BufKillCreateMappings = 0

" Delete a buffer without closing the window it was displayed in
nnoremap <silent> <Leader>x :BW<CR>
nnoremap <silent> <Leader>X :BW!<CR>

" vim-localvimrc {{{2

" Don't load local vimrc files in a sandbox
let g:localvimrc_sandbox = 0

" Don't ask before sourcing local vimrc files
let g:localvimrc_ask = 0

" }}}2

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
