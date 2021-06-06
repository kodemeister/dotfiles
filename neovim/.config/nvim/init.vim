" Setup path to the configuration directory.
let g:config_dir = stdpath('config')

" Create an empty autocommand group for configuration files.
augroup vimrc
  autocmd!
augroup end

" Load the configuration files.
runtime functions.vim
runtime settings.vim
runtime mappings.vim
if exists('g:vscode')
runtime vscode.vim
else
runtime plugins.vim
endif

" vim: fen fdm=marker fmr={{{,}}} fdc=3 et ts=2 sts=2 sw=2
