-- Use "map" instead of "vim.keymap.set" for clarity.
local map = vim.keymap.set

-- Fast saving.
map("n", "<Leader>w", "<Cmd>write<CR>")

-- Clear the last search highlighting.
map("n", "<Leader><Space>", "<Cmd>nohlsearch<CR>")

-- Move cursor up/down by screen lines when wrapping the text.
-- NOTE: Use recursive mappings to make "gj" and "gk" work in VSCode.
map("n", "j", [[v:count == 0 ? "gj" : "j"]], { expr = true, remap = true })
map("n", "k", [[v:count == 0 ? "gk" : "k"]], { expr = true, remap = true })
map("n", "<Down>", [[v:count == 0 ? "gj" : "j"]], { expr = true, remap = true })
map("n", "<Up>", [[v:count == 0 ? "gk" : "k"]], { expr = true, remap = true })

if vim.g.vscode then
  local vscode = require("vscode")

  -- Switch between the current and alternate files.
  map("n", "<Tab>", function()
    vscode.action("runCommands", {
      args = {
        commands = {
          "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup",
          "list.select"
        }
      }
    })
  end)

  -- Switch between C++ source and header files.
  map("n", "<Leader><Tab>", function()
    vscode.action("C_Cpp.SwitchHeaderSource")
  end)

  -- Move to the previous/next opened file.
  map("n", "[b", function()
    vscode.action("workbench.action.previousEditorInGroup")
  end)
  map("n", "]b", function()
    vscode.action("workbench.action.nextEditorInGroup")
  end)

  -- Move to the previous/next change.
  map("n", "[c", function()
    vscode.action("workbench.action.editor.previousChange")
    vscode.action("workbench.action.compareEditor.previousChange")
  end)
  map("n", "]c", function()
    vscode.action("workbench.action.editor.nextChange")
    vscode.action("workbench.action.compareEditor.nextChange")
  end)

  -- Move to the previous/next problem.
  map("n", "[d", function()
    vscode.action("editor.action.marker.prevInFiles")
  end)
  map("n", "]d", function()
    vscode.action("editor.action.marker.nextInFiles")
  end)

  -- Move to the previous/next search result.
  map("n", "[q", function()
    vscode.call("search.action.focusPreviousSearchResult")
    vscode.call("vscode-neovim.escape")
  end)
  map("n", "]q", function()
    vscode.call("search.action.focusNextSearchResult")
    vscode.call("vscode-neovim.escape")
  end)

  -- Open the Problems window.
  map("n", "<Leader>d", function()
    vscode.action("workbench.actions.view.problems")
  end)

  -- Open the Terminal window.
  map("n", "<Leader>t", function()
    vscode.action("workbench.action.terminal.toggleTerminal")
  end)

  -- Open the Explorer window.
  map("n", "<Leader>e", function()
    vscode.action("workbench.view.explorer")
  end)

  -- Open the Search window.
  map("n", "<Leader>/", function()
    vscode.action("workbench.action.findInFiles")
  end)

  -- Search for a word under the cursor in all files in the opened folder.
  map("n", "<Leader>*", function()
    vscode.action("workbench.action.findInFiles", {
      args = {
        query = vim.fn.expand("<cword>")
      }
    })
    vscode.action("workbench.action.focusActiveEditorGroup")
  end)

  -- Search for the current selection in all files in the opened folder.
  map("v", "<Leader>*", function()
    vscode.action("workbench.action.findInFiles")
    vscode.action("workbench.action.focusActiveEditorGroup")
    vscode.action("vscode-neovim.escape")
  end)

  -- Build the project.
  map("n", "<Leader>m", function()
    vscode.action("workbench.action.tasks.build")
  end)
else
  -- Easy navigation between windows.
  map("n", "<C-H>", "<C-W>h")
  map("n", "<C-J>", "<C-W>j")
  map("n", "<C-K>", "<C-W>k")
  map("n", "<C-L>", "<C-W>l")

  -- Easy navigation between terminal windows.
  map("t", "<C-H>", "<C-\\><C-N><C-W>h")
  map("t", "<C-J>", "<C-\\><C-N><C-W>j")
  map("t", "<C-K>", "<C-\\><C-N><C-W>k")
  map("t", "<C-L>", "<C-\\><C-N><C-W>l")

  -- Switch between the current and alternate files.
  map("n", "<Tab>", "<C-^>")
end
