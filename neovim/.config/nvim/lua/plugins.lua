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
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.nvim-autopairs')
    end
  })

  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-tree')
    end
  })

  use({
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    keys = '<C-\\><C-\\>',
    config = function()
      require('plugins.toggleterm')
    end
  })
end)
