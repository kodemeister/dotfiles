-- Don't clutter the filesystem with garbage files.
vim.o.writebackup = false
vim.o.swapfile = false

-- Put unsaved buffers to background when loading new buffers without asking to
-- save the current changes first.
vim.o.hidden = true

-- Make all yank, delete, change and put operations work with system clipboard.
vim.opt.clipboard = {'unnamedplus'}

-- Enable 24-bit colors in the terminal.
vim.o.termguicolors = true

-- Don't redraw the display while executing macros.
vim.o.lazyredraw = true

-- Ignore case in search patterns.
vim.o.ignorecase = true

-- Enable live substitution.
vim.o.inccommand = 'nosplit'

-- Keep the given number of lines above and below the cursor while scrolling.
vim.o.scrolloff = 5

-- Keep the given number of columns to the left and to the right of the cursor
-- while scrolling.
vim.o.sidescrolloff = 10

-- Show the completion popup menu even if there is only one match.
-- Don't automatically select any matches from the menu.
vim.opt.completeopt = {'menuone', 'noselect'}

-- Suppress the annoying completion messages like 'match 1 of 2'.
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Limit the number of items in the completion popup menu.
vim.o.pumheight = 10

-- Reduce the timeout used for the CursorHold autocommand event.
vim.o.updatetime = 250

-- Set some eye candy color scheme.
vim.cmd('colorscheme hybrid-dark')

-- Configure the cursor shape.
vim.opt.guicursor = {
  'n-v-c-sm-o:block',
  'i-ci-ve:ver25',
  'r-cr:hor20',
  'a:blinkon0'
}

-- Always show the signcolumn.
vim.o.signcolumn = 'yes'

-- Show absolute number for the current line and relative numbers for all other
-- lines.
vim.o.number = true
vim.o.relativenumber = true

-- Highlight the line containing the cursor.
vim.o.cursorline = true

-- Enable list mode, show whitespace characters.
vim.o.list = true
vim.opt.listchars = {tab = '» ', space = '·', extends = '>', precedes = '<'}

-- Don't show the current mode on the last line.
vim.o.showmode = false

-- Use spaces instead of tabs.
vim.o.expandtab = true

-- Set width of tabs and indents to 4 spaces.
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Disable soft wrapping of long lines.
vim.o.wrap = false
