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
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugins.toggleterm')
    end
  })
end)
