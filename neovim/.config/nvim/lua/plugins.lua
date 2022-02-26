-- Automatically install packer.nvim on the first run.
local data_dir = vim.fn.stdpath('data')
local packer_dir = data_dir .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_dir)) ~= 0 then
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', packer_url, packer_dir})
  vim.cmd('packadd packer.nvim')
end

-- Declare the required plugins.
require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('plugins.Comment-config')
    end
  })

  use({
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.gitsigns-config')
    end
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.nvim-autopairs-config')
    end
  })

  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-tree-config')
    end
  })

  use({
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugins.toggleterm-config')
    end
  })

  use({
    'tpope/vim-fugitive',
    config = function()
      require('plugins.vim-fugitive-config')
    end
  })

  use('michaeljsmith/vim-indent-object')

  use({
    'inkarkat/vim-ReplaceWithRegister',
    requires = 'tpope/vim-repeat'
  })

  use({
    'tpope/vim-surround',
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
end)
