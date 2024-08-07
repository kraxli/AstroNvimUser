local prefix = "<Leader>r"
local trim_spaces = true
return {
  "akinsho/toggleterm.nvim",
  -- dependencies = {
  --   "AstroNvim/astrocore",
  --   ---@param opts AstroCoreOpts
  --   opts = {
  --     size = 80,
  --     mappings = {
  --       n = {
  --         [prefix] = { desc = " REPL" },
  --         [prefix .. "s"] = {'<cmd> lua require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.api.nvim_buf_get_number(0) })<CR>', noremap=false, desc="Send line to repl"},
  --         -- [prefix .. "l"] = {prefix .. "s"},
  --         [prefix .. "l"] = {'<cmd> lua require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.api.nvim_buf_get_number(0) })<CR>', noremap=false, desc="Send line to repl"},
  --       },
  --       v = {
  --         [prefix] = { desc = " REPL" },
  --         -- [prefix .. "s"] = {
  --         --   -- "<cmd>lua require 'utils'.send_visual_lines_to_ipython_v2()<CR> | <cmd>lua require('toggleterm').exec('%autoindent', 1)<cr>",
  --         --   "<cmd>lua require 'utils'.send_visual_lines_to_ipython_v2()<CR>",
  --         --   noremap = false,
  --         --   desc = "Send visual line to repl",
  --         -- },
  --         [prefix .. "s"] = {'<cmd> lua require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.api.nvim_buf_get_number(0) })<CR>', noremap=false, desc="Send selection to repl"},
  --         -- [prefix .. "l"] = {prefix .. "s"},
  --         [prefix .. "l"] = {'<cmd> lua require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.api.nvim_buf_get_number(0) })<CR>', noremap=false, desc="Send selected lines to repl"},
  --       },
  --     },
  --   },
  --   -- opts = function(_, opts)
  --   --   opts.size = 80
  --   --   -- opts.mappings.n["q"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminl" }
  --   --   -- opts.mappings.n["<c-q>"] = { "<Cmd>close!<CR>", desc = "Toggle terminl" }
  --   -- end,
  -- },
}
