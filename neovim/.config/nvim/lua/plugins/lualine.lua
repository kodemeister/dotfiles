return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cond = not vim.g.vscode,
  opts = {
    options = {
      -- Set lualine theme to match current Neovim color scheme.
      theme = "github_dark"
    },
    sections = {
      -- Display the number of pending plugin updates from lazy.nvim.
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates
        }
      }
    }
  }
}
