-- Sets a global mapping for the given mode.
local function map(mode, lhs, rhs, opts)
  local default_opts = {silent = true}
  opts = vim.tbl_extend('force', default_opts, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Fast saving.
map('n', '<Leader>w', ':write<CR>')

-- Clear the last search highlighting.
map('n', '<Leader><Space>', ':nohlsearch<CR>')

-- Move cursor up/down by screen lines when wrapping the text.
map('n', 'j', [[v:count == 0 ? 'gj' : 'j']], {expr = true})
map('n', 'k', [[v:count == 0 ? 'gk' : 'k']], {expr = true})
map('n', '<Down>', [[v:count == 0 ? 'gj' : 'j']], {expr = true})
map('n', '<Up>', [[v:count == 0 ? 'gk' : 'k']], {expr = true})

-- Easy navigation between windows.
map('n', '<C-H>', '<C-W>h')
map('n', '<C-J>', '<C-W>j')
map('n', '<C-K>', '<C-W>k')
map('n', '<C-L>', '<C-W>l')

-- Easy navigation between terminal windows.
map('t', '<C-H>', '<C-\\><C-N><C-W>h')
map('t', '<C-J>', '<C-\\><C-N><C-W>j')
map('t', '<C-K>', '<C-\\><C-N><C-W>k')
map('t', '<C-L>', '<C-\\><C-N><C-W>l')

-- Toggle between the current and the alternate file.
map('n', '<Tab>', '<C-^>')
