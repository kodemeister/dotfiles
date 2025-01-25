-- Automatically install lazy.nvim on the first run.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." }
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim.
require("lazy").setup({
  spec = {
    -- Load plugin specs from "lua/plugins" directory.
    { import = "plugins" }
  },
  install = {
    -- Use this color scheme when installing plugins.
    colorscheme = { "github_dark" }
  },
  checker = {
    -- Automatically check for plugin updates in the background.
    enabled = true,

    -- Disable an annoying message about available updates.
    notify = false
  }
})
