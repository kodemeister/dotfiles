-- Configure the <Leader> key.
vim.g.mapleader = " "

-- Don't clutter the filesystem with garbage files.
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Make all yank, delete, change and put operations work with system clipboard.
vim.opt.clipboard = { "unnamedplus" }

-- Enable 24-bit colors in the terminal.
vim.opt.termguicolors = true

-- Don't redraw the display while executing macros.
vim.opt.lazyredraw = true

-- Ignore case in search patterns.
vim.opt.ignorecase = true

-- Keep the given number of lines above and below the cursor while scrolling.
vim.opt.scrolloff = 5

-- Keep the given number of columns to the left and to the right of the cursor
-- while scrolling.
vim.opt.sidescrolloff = 10

-- Show the completion popup menu even if there is only one match.
-- Don't automatically select any matches from the menu.
vim.opt.completeopt = { "menuone", "noselect" }

-- Suppress the annoying completion messages like "match 1 of 2".
vim.opt.shortmess:append("c")

-- Limit the number of items in the completion popup menu.
vim.opt.pumheight = 10

-- Reduce the timeout used for the CursorHold autocommand event.
vim.opt.updatetime = 250

-- Configure the cursor shape.
vim.opt.guicursor = {
  "n-v-c-sm-o:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "a:blinkon0"
}

-- Always show the signcolumn.
vim.opt.signcolumn = "yes"

-- Show absolute number for the current line and relative numbers for all other
-- lines.
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the line containing the cursor.
vim.opt.cursorline = true

-- Don't show the current mode on the last line.
vim.opt.showmode = false

-- Use spaces instead of tabs.
vim.opt.expandtab = true

-- Set width of tabs and indents to 4 spaces.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Disable soft wrapping of long lines.
vim.opt.wrap = false
