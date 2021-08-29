require('toggleterm').setup({
  -- Specify the size separately for horizontal and vertical terminals.
  size = function(term)
    if term.direction == 'horizontal' then
      return 12
    elseif term.direction == 'vertical' then
      return vim.o.columns / 2
    end
  end,

  -- Define key mapping to toggle the terminal window.
  open_mapping = [[<C-\><C-\>]],

  -- Don't make terminal windows darker than regular windows.
  shade_terminals = false,

  -- Open a new terminal in a horizontal split by default.
  direction = 'horizontal'
})

-- Disable signcolumn and cursorline in the terminal.
vim.cmd('autocmd vimrc TermOpen term://*toggleterm#* ' ..
  'setlocal signcolumn=no nocursorline')
