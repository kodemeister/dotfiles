local M = {}

function M.setup_settings()
  -- Don't highlight any files with special color.
  vim.g.nvim_tree_special_files = {}

  -- Initialize the plugin.
  require('nvim-tree').setup({})
end

function M.setup_mappings()
  -- Quickly toggle NvimTree window.
  vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>',
    {noremap = true, silent = true})

  -- Reveal currently opened file in NvimTree window.
  vim.api.nvim_set_keymap('n', '=t', ':NvimTreeFindFile<CR>',
    {noremap = true, silent = true})
end

return M
