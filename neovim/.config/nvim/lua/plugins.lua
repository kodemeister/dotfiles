-- Automatically install packer.nvim on the first run.
local data_dir = vim.fn.stdpath('data')
local packer_dir = data_dir .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = vim.fn.empty(vim.fn.glob(packer_dir)) ~= 0
if packer_bootstrap then
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, packer_dir})
  vim.o.runtimepath = data_dir .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Declare the required plugins.
require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use({
    'echasnovski/mini.nvim',
    config = function()
      require('mini.comment').setup({})
      require('mini.pairs').setup({})
      require('mini.statusline').setup({})
      require('mini.surround').setup({
        mappings = {
          add = 'ys',
          delete = 'ds',
          find = '',
          find_left = '',
          highlight = '',
          replace = 'cs',
          update_n_lines = ''
        }
      })
    end
  })

  use({
    'inkarkat/vim-ReplaceWithRegister',
    requires = 'tpope/vim-repeat'
  })

  use({
    'kana/vim-textobj-entire',
    requires = 'kana/vim-textobj-user',
    after = 'vim-textobj-user'
  })

  use({
    'tpope/vim-unimpaired',
    requires = 'tpope/vim-repeat'
  })

  use('nelstrom/vim-visual-star-search')

  use('Mofiqul/vscode.nvim')

  if packer_bootstrap then
    require('packer').sync()
  end
end)
