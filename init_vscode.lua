--
-- Resources:
--    https://github.com/cschierig/vscode-nvim-setup
--    https://medium.com/@nikmas_dev/vscode-neovim-setup-keyboard-centric-powerful-reliable-clean-and-aesthetic-development-582d34297985

if vim.g.vscode then

  local vscode = require "vscode"
  local cursor = require("vscode.cursor")

  vim.notify = vscode.notify

  -- Make sure to setup `mapleader` and `maplocalleader` before
  -- loading lazy.nvim so that mappings are correct.
  -- This is also a good place to setup other settings (vim.opt)
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","

  -------------------------------------------------------
  -- Lazy.nvim setup
  -------------------------------------------------------

  -- Bootstrap lazy.nvim
  local lazyroot = os.getenv("XDG_CONFIG_HOME") .. "Code/User/nvim" .. "/lazy/"
  local lazypath = lazyroot .. "lazy.nvim"
  -- local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  -- Setup lazy.nvim
  require("lazy").setup {
    root = lazyroot,
    spec = {
      {
        "vscode-neovim/vscode-multi-cursor.nvim",
        enabled = false,
        event = "VeryLazy",
        cond = not not vim.g.vscode,
        opts = {},
      },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins:
    -- install = { colorscheme = { "habamax" } },

    -- automatically check for plugin updates
    checker = { enabled = true },
  }

  -------------------------------------------------------
  -- Key mappings:
  --
  -- Notes:
  --    * other key mappings are set in ~/.config/Code/User/keybindings.json
  -------------------------------------------------------

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

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

  -- local enabled = {}
  -- local list = {}
  -- vim.tbl_map(function(plugin) enabled[plugin] = true end, list)

  -- basic actions
  keymap("n", "<Leader>q", function() require("vscode-neovim").action "workbench.action.closeWindow" end, opts)
  keymap("n", "<Leader>w", function() require("vscode-neovim").action "workbench.action.files.save" end, opts)
  keymap("n", "<Leader>n", function() require("vscode-neovim").action "welcome.showNewFileEntries" end, opts)
  keymap("n", "q", function() require("vscode-neovim").action "workbench.action.closeFile" end, opts)

  -- comments
  keymap({ "n", "v", "x" }, "gc", function() require("vscode-neovim").action "editor.action.commentLine" end, opts)
  keymap("n", "gcc", function() require("vscode-neovim").action "editor.action.commentLine" end, opts)

  -- multi-cursor
  -- keymap({"n", "v", "x"} , "<C-V>", "<C-v>", opts)
  -- keymap({"n", "v", "x"} , "<c-V>", function() require("vscode-neovim").vscode.cursor.send(true, true) end, opts)

  -- yank / copy and paste to system clipboard
  keymap({ "n", "v" }, "<leader>y", '"+y', opts)
  keymap({ "n", "v" }, "<leader>p", '"+p', opts)
  keymap({ "v", "x" }, "y", '"+y', opts)
  keymap({ "v", "x" }, "<c-c>", '"+y', opts)
  keymap({ "n", "v" }, "p", '"+p', opts)
  keymap({ "n", "v" }, "P", '"+P', opts)
  keymap("n", "yy", '"+yy', opts)
  keymap("n" , "<c-v>", '"+p', opts)
  keymap("n", "dd", '"+dd', opts)
  -- keymap({ "v", "x" }, "d", '"+x', opts)
  keymap("n", "D", '"+D', opts)

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
  keymap(
    "n",
    "<Leader>e",
    function() require("vscode-neovim").action "workbench.action.toggleSidebarVisibility" end,
    opts
  )
  keymap(
    "n",
    "<Leader>o",
    function() require("vscode-neovim").action "workbench.files.action.focusFilesExplorer" end,
    opts
  )

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

  -- vscode-multi-cursor (https://github.com/vscode-neovim/vscode-multi-cursor.nvim)
  -- local cursors = require "vscode-multi-cursor"
  -- keymap({ 'n', 'x' }, 'mc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
  -- keymap({ 'n', 'x' }, '<c-V>', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
  -- keymap({ 'n' }, 'mcc', cursors.cancel, { desc = 'Cancel/Clear all cursors' })
  -- keymap({ 'n' }, '<ESC>', cursors.cancel, { desc = 'Cancel/Clear all cursors' })

end
