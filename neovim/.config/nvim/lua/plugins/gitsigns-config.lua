require('gitsigns').setup({
  -- Use better signs instead of default vertical bars.
  signs = {
    add = {text = '+'},
    change = {text = '~'}
  },

  -- Setup buffer mappings.
  on_attach = function(buffer)
    local function map(mode, lhs, rhs, opts)
      local default_opts = {noremap = true, silent = true}
      opts = vim.tbl_extend('force', default_opts, opts or {})
      vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
    end

    map('n', ']c', [[&diff ? ']c' : ':Gitsigns next_hunk<CR>']], {expr = true})
    map('n', '[c', [[&diff ? '[c' : ':Gitsigns prev_hunk<CR>']], {expr = true})

    map('n', '<Leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<Leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<Leader>hu', ':Gitsigns undo_stage_hunk<CR>')
    map('n', '<Leader>hp', ':Gitsigns preview_hunk<CR>')
  end
})
