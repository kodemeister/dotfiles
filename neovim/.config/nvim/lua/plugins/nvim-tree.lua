-- Don't highlight any files with special color.
vim.g.nvim_tree_special_files = {}

-- Move cursor up and down as usual, don't jump to the beginning of file name.
vim.g.nvim_tree_hijack_cursor = false

-- Quickly toggle NvimTree window.
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>',
  {noremap = true, silent = true})

-- Reveal currently opened file in NvimTree window.
vim.api.nvim_set_keymap('n', '=t', ':NvimTreeFindFile<CR>',
  {noremap = true, silent = true})
