return {
  "projekt0n/github-nvim-theme",
  cond = not vim.g.vscode,

  -- Load this color scheme during startup before all other plugins.
  lazy = false,
  priority = 1000,

  config = function()
    -- Set the color scheme.
    vim.cmd("colorscheme github_dark")
  end
}
