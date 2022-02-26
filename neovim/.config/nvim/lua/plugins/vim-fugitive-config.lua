-- Define mappings for the most common vim-fugitive commands.
local options = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<Leader>gs', ':Git<CR>gg)', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gd', ':Gdiffsplit<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gr', ':Gread<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gw', ':Gwrite<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gc', ':Git commit<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gps', ':Git push<CR>', options)
vim.api.nvim_set_keymap('n', '<Leader>gpl', ':Git pull --ff-only<CR>', options)
