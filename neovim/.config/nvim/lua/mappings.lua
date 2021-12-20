-- Configure the <Leader> key.
vim.g.mapleader = ' '

-- Quickly open configuration files.
local config_dir = vim.fn.fnameescape(vim.fn.stdpath('config'))
local options = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<Leader>ve', ':edit ' .. config_dir ..
  '/init.lua<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>vm', ':edit ' .. config_dir ..
  '/lua/mappings.lua<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>vp', ':edit ' .. config_dir ..
  '/lua/plugins.lua<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>vs', ':edit ' .. config_dir ..
  '/lua/settings.lua<CR>', options)

-- Fast saving.
vim.api.nvim_set_keymap('n', '<Leader>w', ':write<CR>', options)

-- Clear the last search highlighting.
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':nohlsearch<CR>', options)

-- Jump to the current error in quickfix or location list.
vim.api.nvim_set_keymap('n', '=q', ':cc<CR>', options)
vim.api.nvim_set_keymap('n', '=l', ':ll<CR>', options)

-- Move cursor up/down by screen lines when wrapping the text.
vim.api.nvim_set_keymap('n', 'j', [[v:count == 0 ? 'gj' : 'j']],
  {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', 'k', [[v:count == 0 ? 'gk' : 'k']],
  {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', '<Down>', [[v:count == 0 ? 'gj' : 'j']],
  {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', '<Up>', [[v:count == 0 ? 'gk' : 'k']],
  {noremap = true, expr = true})

-- Easy navigation between windows.
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W>h', options)
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W>j', options)
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W>k', options)
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W>l', options)

-- Easy navigation between terminal windows.
vim.api.nvim_set_keymap('t', '<C-H>', '<C-\\><C-N><C-W>h', options)
vim.api.nvim_set_keymap('t', '<C-J>', '<C-\\><C-N><C-W>j', options)
vim.api.nvim_set_keymap('t', '<C-K>', '<C-\\><C-N><C-W>k', options)
vim.api.nvim_set_keymap('t', '<C-L>', '<C-\\><C-N><C-W>l', options)

-- Toggle between the current and the alternate file.
vim.api.nvim_set_keymap('n', '<Tab>', '<C-^>', options)
