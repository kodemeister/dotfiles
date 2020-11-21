" Runs the specified FZF command. If the cursor is in auxiliary window, it is
" first moved to the previous window.
function! g:RunFZF(command)
  if &buftype ==# 'quickfix' || &buftype ==# 'help' ||
      \ &buftype ==# 'terminal' || &filetype ==# 'nerdtree'
    wincmd p
  endif
  execute a:command
endfunction

" Checks if there are any whitespaces before the cursor.
function! g:HasSpaceBefore()
  let l:col = col('.') - 1
  return l:col == 0 || getline('.')[l:col - 1] =~# '\s'
endfunction

" Shows a documentation for the symbol under the cursor in CoC tooltip or in
" standard Vim help window.
function! g:ShowHover()
  if &filetype ==# 'vim' || &filetype ==# 'help'
    execute 'help ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

" Closes AsyncRun window upon successful completion.
function! g:CloseAsyncRunWindow()
  if g:asyncrun_code == 0
    cclose
  endif
endfunction

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
