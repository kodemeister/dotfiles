-- Don't highlight any files with special color.
vim.g.nvim_tree_special_files = {}

-- Initialize the plugin.
require('nvim-tree').setup({
  git = {
    -- Disable Git icons in NvimTree window.
    enable = false
  }
})

-- Quickly toggle NvimTree window.
local options = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', options)

-- Reveal currently opened file in NvimTree window.
vim.api.nvim_set_keymap('n', '=t', ':NvimTreeFindFile<CR>', options)
