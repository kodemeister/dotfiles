" Hybrid Dark color scheme. Based on hybrid.vim:
" https://github.com/w0ng/vim-hybrid

" Setup {{{

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'hybrid-dark'

" }}}
" Color Palette {{{

let s:background = ['#1d1f21', '234' ]
let s:foreground = ['#c5c8c6', '15'  ]

let s:black      = ['#282a2e', '0'   ]
let s:darkred    = ['#a54242', '1'   ]
let s:darkgreen  = ['#8c9440', '2'   ]
let s:orange     = ['#de935f', '3'   ]
let s:darkblue   = ['#5f819d', '4'   ]
let s:darkpurple = ['#85678f', '5'   ]
let s:darkcyan   = ['#5e8d87', '6'   ]
let s:gray       = ['#707880', '7'   ]
let s:darkgray   = ['#373b41', '8'   ]
let s:red        = ['#cc6666', '9'   ]
let s:green      = ['#b5bd68', '10'  ]
let s:yellow     = ['#f0c674', '11'  ]
let s:blue       = ['#81a2be', '12'  ]
let s:purple     = ['#b294bb', '13'  ]
let s:cyan       = ['#8abeb7', '14'  ]
let s:white      = ['#c5c8c6', '15'  ]

let s:normalbg   = ['#1d1f21', 'NONE']
let s:addbg      = ['#5f875f', '65'  ]
let s:changebg   = ['#5f5f87', '60'  ]
let s:numberfg   = ['#626262', '241' ]
let s:none       = ['NONE',    'NONE']

" }}}
" Terminal Colors {{{

if has('nvim')
  let g:terminal_color_0  = s:black[0]
  let g:terminal_color_1  = s:darkred[0]
  let g:terminal_color_2  = s:darkgreen[0]
  let g:terminal_color_3  = s:orange[0]
  let g:terminal_color_4  = s:darkblue[0]
  let g:terminal_color_5  = s:darkpurple[0]
  let g:terminal_color_6  = s:darkcyan[0]
  let g:terminal_color_7  = s:gray[0]
  let g:terminal_color_8  = s:darkgray[0]
  let g:terminal_color_9  = s:red[0]
  let g:terminal_color_10 = s:green[0]
  let g:terminal_color_11 = s:yellow[0]
  let g:terminal_color_12 = s:blue[0]
  let g:terminal_color_13 = s:purple[0]
  let g:terminal_color_14 = s:cyan[0]
  let g:terminal_color_15 = s:white[0]
else
  let g:terminal_ansi_colors = [
      \ s:black[0],
      \ s:darkred[0],
      \ s:darkgreen[0],
      \ s:orange[0],
      \ s:darkblue[0],
      \ s:darkpurple[0],
      \ s:darkcyan[0],
      \ s:gray[0],
      \ s:darkgray[0],
      \ s:red[0],
      \ s:green[0],
      \ s:yellow[0],
      \ s:blue[0],
      \ s:purple[0],
      \ s:cyan[0],
      \ s:white[0]
      \ ]
endif

" }}}
" Highlighting Function {{{

function! s:Highlight(group, fg, bg, ...)
  let l:attr = a:0 > 0 ? a:1 : 'NONE'
  let l:sp   = a:0 > 1 ? a:2 : s:none
  execute 'highlight! ' . a:group .
      \ ' guifg=' . a:fg[0] . ' ctermfg=' . a:fg[1] .
      \ ' guibg=' . a:bg[0] . ' ctermbg=' . a:bg[1] .
      \ ' gui='   . l:attr  . ' cterm='   . l:attr  .
      \ ' guisp=' . l:sp[0]
endfunction

" }}}
" General Highlighting {{{

call s:Highlight('ColorColumn',      s:none,       s:black                  )
call s:Highlight('Conceal',          s:none,       s:none                   )
call s:Highlight('Cursor',           s:background, s:foreground             )
call s:Highlight('CursorIM',         s:background, s:foreground             )
call s:Highlight('CursorColumn',     s:none,       s:black                  )
call s:Highlight('CursorLine',       s:none,       s:black                  )
call s:Highlight('Directory',        s:blue,       s:none                   )
call s:Highlight('DiffAdd',          s:background, s:addbg                  )
call s:Highlight('DiffChange',       s:foreground, s:changebg               )
call s:Highlight('DiffDelete',       s:background, s:red                    )
call s:Highlight('DiffText',         s:background, s:blue                   )
call s:Highlight('EndOfBuffer',      s:darkgray,   s:none                   )
call s:Highlight('TermCursor',       s:background, s:foreground             )
call s:Highlight('TermCursorNC',     s:background, s:foreground             )
call s:Highlight('ErrorMsg',         s:red,        s:none,       'bold'     )
call s:Highlight('VertSplit',        s:darkgray,   s:none                   )
call s:Highlight('Folded',           s:gray,       s:black                  )
call s:Highlight('FoldColumn',       s:gray,       s:black                  )
call s:Highlight('SignColumn',       s:none,       s:none                   )
call s:Highlight('IncSearch',        s:background, s:orange                 )
call s:Highlight('Substitute',       s:background, s:orange                 )
call s:Highlight('LineNr',           s:numberfg,   s:none                   )
call s:Highlight('CursorLineNr',     s:yellow,     s:none                   )
call s:Highlight('MatchParen',       s:background, s:changebg               )
call s:Highlight('ModeMsg',          s:green,      s:none                   )
call s:Highlight('MsgSeparator',     s:green,      s:none                   )
call s:Highlight('MoreMsg',          s:green,      s:none                   )
call s:Highlight('NonText',          s:darkgray,   s:none                   )
call s:Highlight('Normal',           s:foreground, s:normalbg               )
call s:Highlight('NormalNC',         s:foreground, s:normalbg               )
call s:Highlight('Pmenu',            s:foreground, s:darkgray               )
call s:Highlight('PmenuSel',         s:background, s:blue                   )
call s:Highlight('PmenuSbar',        s:none,       s:gray                   )
call s:Highlight('PmenuThumb',       s:none,       s:white                  )
call s:Highlight('Question',         s:green,      s:none                   )
call s:Highlight('QuickFixLine',     s:background, s:blue                   )
call s:Highlight('Search',           s:background, s:yellow                 )
call s:Highlight('SpecialKey',       s:darkgray,   s:none                   )
call s:Highlight('SpellBad',         s:red,        s:none,       'undercurl')
call s:Highlight('SpellCap',         s:orange,     s:none,       'undercurl')
call s:Highlight('SpellLocal',       s:blue,       s:none,       'undercurl')
call s:Highlight('SpellRare',        s:purple,     s:none,       'undercurl')
call s:Highlight('StatusLine',       s:foreground, s:darkgray               )
call s:Highlight('StatusLineNC',     s:numberfg,   s:black                  )
call s:Highlight('StatusLineTerm',   s:foreground, s:darkgray               )
call s:Highlight('StatusLineTermNC', s:numberfg,   s:black                  )
call s:Highlight('TabLine',          s:foreground, s:darkgray               )
call s:Highlight('TabLineFill',      s:foreground, s:darkgray               )
call s:Highlight('TabLineSel',       s:background, s:blue                   )
call s:Highlight('Terminal',         s:foreground, s:normalbg               )
call s:Highlight('Title',            s:orange,     s:none                   )
call s:Highlight('Visual',           s:none,       s:darkgray               )
call s:Highlight('VisualNOS',        s:none,       s:darkgray               )
call s:Highlight('WarningMsg',       s:yellow,     s:none,       'bold'     )
call s:Highlight('Whitespace',       s:darkgray,   s:none                   )
call s:Highlight('WildMenu',         s:background, s:blue                   )

" }}}
" Syntax Highlighting {{{

call s:Highlight('Comment',          s:gray,       s:none                   )
call s:Highlight('Constant',         s:purple,     s:none                   )
call s:Highlight('String',           s:green,      s:none                   )
call s:Highlight('Character',        s:green,      s:none                   )
call s:Highlight('Number',           s:purple,     s:none                   )
call s:Highlight('Boolean',          s:purple,     s:none                   )
call s:Highlight('Float',            s:purple,     s:none                   )
call s:Highlight('Identifier',       s:blue,       s:none                   )
call s:Highlight('Function',         s:blue,       s:none                   )
call s:Highlight('Statement',        s:red,        s:none                   )
call s:Highlight('Conditional',      s:red,        s:none                   )
call s:Highlight('Repeat',           s:red,        s:none                   )
call s:Highlight('Label',            s:red,        s:none                   )
call s:Highlight('Operator',         s:cyan,       s:none                   )
call s:Highlight('Keyword',          s:red,        s:none                   )
call s:Highlight('Exception',        s:red,        s:none                   )
call s:Highlight('PreProc',          s:purple,     s:none                   )
call s:Highlight('Include',          s:purple,     s:none                   )
call s:Highlight('Define',           s:purple,     s:none                   )
call s:Highlight('Macro',            s:purple,     s:none                   )
call s:Highlight('PreCondit',        s:purple,     s:none                   )
call s:Highlight('Type',             s:orange,     s:none                   )
call s:Highlight('StorageClass',     s:orange,     s:none                   )
call s:Highlight('Structure',        s:red,        s:none                   )
call s:Highlight('Typedef',          s:orange,     s:none                   )
call s:Highlight('Special',          s:cyan,       s:none                   )
call s:Highlight('SpecialChar',      s:cyan,       s:none                   )
call s:Highlight('Tag',              s:cyan,       s:none                   )
call s:Highlight('Delimiter',        s:cyan,       s:none                   )
call s:Highlight('SpecialComment',   s:cyan,       s:none                   )
call s:Highlight('Debug',            s:cyan,       s:none                   )
call s:Highlight('Underlined',       s:blue,       s:none,       'underline')
call s:Highlight('Ignore',           s:none,       s:none                   )
call s:Highlight('Error',            s:red,        s:none,       'underline')
call s:Highlight('Todo',             s:yellow,     s:none                   )

" }}}
" Quickfix {{{

call s:Highlight('qfLineNr',         s:yellow,     s:none                   )

" }}}
" Diff {{{

call s:Highlight('diffFile',         s:orange,     s:none                   )
call s:Highlight('diffRemoved',      s:red,        s:none                   )
call s:Highlight('diffAdded',        s:green,      s:none                   )
call s:Highlight('diffLine',         s:purple,     s:none                   )

" }}}
" Coc {{{

call s:Highlight('CocErrorSign',     s:red,        s:none                   )
call s:Highlight('CocWarningSign',   s:yellow,     s:none                   )
call s:Highlight('CocInfoSign',      s:blue,       s:none                   )
call s:Highlight('CocHintSign',      s:blue,       s:none                   )

" }}}
" GitGutter {{{

call s:Highlight('GitGutterAdd',     s:darkgreen,  s:none                   )
call s:Highlight('GitGutterChange',  s:yellow,     s:none                   )
call s:Highlight('GitGutterDelete',  s:red,        s:none                   )

" }}}

" vim: fen fdm=marker fmr={{{,}}} fdc=1 et ts=2 sts=2 sw=2
