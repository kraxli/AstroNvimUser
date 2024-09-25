if vim.g.vscode then
  print "init_vscode.lua loaded"
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- remap leader key
  keymap("n", "<Space>", "", opts)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "


  -- better indent handling
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- move text up and down
  keymap("v", "J", ":m .+1<CR>==", opts)
  keymap("v", "K", ":m .-2<CR>==", opts)
  keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

  -- paste preserves primal yanked piece
  keymap("v", "p", '"_dP', opts)

  -- removes highlighting after escaping vim search
  keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

  -- vim.notify = vscode.notify

  -- local enabled = {}
  -- local list = {}
  -- vim.tbl_map(function(plugin) enabled[plugin] = true end, list)

  -- basic actions
  keymap("i", "jj", function() require("vscode-neovim").action "vscode-neovim.escape" end, opts) -- not working user <c-c>
  keymap("i", "kk", function() require("vscode-neovim").action "vscode-neovim.escape" end, opts) -- working

  keymap("n", "<Leader>q", function() require("vscode-neovim").action "workbench.action.closeWindow" end, opts)
  keymap("n", "<Leader>w", function() require("vscode-neovim").action "workbench.action.files.save" end, opts)
  keymap("n", "<Leader>n", function() require("vscode-neovim").action "welcome.showNewFileEntries" end, opts)

  -- yank / copy and paste to system clipboard
  keymap({ "n", "v" }, "<leader>y", '"+y', opts)
  keymap({ "n", "v" }, "<leader>p", '"+p', opts)
  keymap({ "v", "x" }, "y", '"+y', opts)
  keymap({ "n", "v" }, "p", '"+p', opts)

  -- splits navigation
  keymap("n", "|", function() require("vscode-neovim").action "workbench.action.splitEditor" end, opts)
  keymap("n", "\\", function() require("vscode-neovim").action "workbench.action.splitEditorDown" end, opts)
  keymap("n", "<C-H>", function() require("vscode-neovim").action "workbench.action.navigateLeft" end, opts)
  keymap("n", "<C-J>", function() require("vscode-neovim").action "workbench.action.navigateDown" end, opts)
  keymap("n", "<C-K>", function() require("vscode-neovim").action "workbench.action.navigateUp" end, opts)
  keymap("n", "<C-L>", function() require("vscode-neovim").action "workbench.action.navigateRight" end, opts)

  -- terminal
  keymap("n", "<F7>", function() require("vscode-neovim").action "workbench.action.terminal.toggleTerminal" end, opts)

  -- buffer manacement
  keymap("n", "L", "<Cmd>Tabnext<CR>", opts)
  keymap("n", "H", "<Cmd>Tabprevious<CR>", opts)
  keymap("n", "<Leader>c", "<Cmd>Tabclose<CR>", opts)
  keymap("n", "<Leader>C", "<Cmd>Tabclose!<CR>", opts)
  keymap("n", "<Leader>bp", "<Cmd>Tablast<CR>", opts)

  -- file explorer
  -- keymap( "n", "<Leader>e", function() require("vscode-neovim").action "workbench.files.action.focusFilesExplorer" end, opts)
  keymap( "n", "<Leader>e", function() require("vscode-neovim").action "workbench.action.toggleSidebarVisibility" end, opts)

  keymap( "n", "<Leader>o", function() require("vscode-neovim").action "workbench.files.action.focusFilesExplorer" end, opts)

  -- indentation
  keymap("v", "<Tab>", function() require("vscode-neovim").action "editor.action.indentLines" end, opts)
  keymap("v", "<S-Tab>", function() require("vscode-neovim").action "editor.action.outdentLines" end, opts)

  -- diagnostics
  keymap("n", "]d", function() require("vscode-neovim").action "editor.action.marker.nextInFiles" end, opts)
  keymap("n", "[d", function() require("vscode-neovim").action "editor.action.marker.prevInFiles" end, opts)

  -- pickers (emulate telescope mappings)
  -- keymap("n", "<Leader>fc", function() require("vscode-neovim").action("workbench.action.findInFiles", { args = { query = vim.fn.expand "<cword>" } }) end, opts)
  keymap("n", "<Leader>fC", function() require("vscode-neovim").action "workbench.action.showCommands" end, opts)
  keymap("n", "<Leader>ff", function() require("vscode-neovim").action "workbench.action.quickOpen" end, opts)
  keymap("n", "<Leader>fn", function() require("vscode-neovim").action "notifications.showList" end, opts)
  keymap("n", "<Leader>fo", function() require("vscode-neovim").action "workbench.action.openRecent" end, opts)
  keymap("n", "<Leader>ft", function() require("vscode-neovim").action "workbench.action.selectTheme" end, opts)
  keymap("n", "<Leader>fw", function() require("vscode-neovim").action "workbench.action.findInFiles" end, opts)

  -- git client
  keymap("n", "<Leader>gg", function() require("vscode-neovim").action "workbench.view.scm" end, opts)

  -- LSP Mappings
  keymap("n", "K", function() require("vscode-neovim").action "editor.action.showHover" end, opts)
  keymap("n", "gI", function() require("vscode-neovim").action "editor.action.goToImplementation" end, opts)
  keymap("n", "gd", function() require("vscode-neovim").action "editor.action.revealDefinition" end, opts)
  keymap("n", "gD", function() require("vscode-neovim").action "editor.action.revealDeclaration" end, opts)
  keymap("n", "gr", function() require("vscode-neovim").action "editor.action.goToReferences" end, opts)
  keymap("n", "gy", function() require("vscode-neovim").action "editor.action.goToTypeDefinition" end, opts)
  keymap("n", "<Leader>la", function() require("vscode-neovim").action "editor.action.quickFix" end, opts)
  keymap("n", "<Leader>lG", function() require("vscode-neovim").action "workbench.action.showAllSymbols" end, opts)
  keymap("n", "<Leader>lR", function() require("vscode-neovim").action "editor.action.goToReferences" end, opts)
  keymap("n", "<Leader>lr", function() require("vscode-neovim").action "editor.action.rename" end, opts)
  keymap("n", "<Leader>ls", function() require("vscode-neovim").action "workbench.action.gotoSymbol" end, opts)
  keymap("n", "<Leader>lf", function() require("vscode-neovim").action "editor.action.formatDocument" end, opts)
end
