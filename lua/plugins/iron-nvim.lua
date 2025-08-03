local prefix = "<Leader>r"
local is_mswindows = vim.fn.has('win64') == 1 and true or false

-- https://www.playfulpython.com/configuring-neovim-as-a-python-ide/
-- https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks#using-toggleterm-with-powershell

-- python command
local py_command = { "ipython", "--pylab=qt5", "--no-autoindent" }
-- if is_mswindows == 1 then
--   table.insert(py_command, "--simple-prompt")
--   py_command = {"python"}  -- use python 3.13
-- end


-- get variable under cursor: local variableUnderCursor = vim.fn.expand("<cword>")
-- get visual selection: https://github.com/Willem-J-an/visidata.nvim/blob/master/lua/visidata.lua
-- lua require('iron').core.send(python, 'import pyarrow; df_x.to_parquet("df_x.parquet")'); vim.cmd([[TermExec cmd='vd df_x.parquet' direction=float]])

local function get_visual_selection()
	local _, line_start, col_start = unpack(vim.fn.getpos("v"))
	local _, line_end, col_end = unpack(vim.fn.getpos("."))
	local selection = vim.api.nvim_buf_get_text(0, line_start - 1, col_start - 1, line_end - 1, col_end, {})
	return selection
end

function visidata_py(direction)
  local mode = vim.fn.mode()
  local var_name
  if mode == 'n' or mode == 'i' then
    var_name = vim.fn.expand("<cword>")
  elseif mode == 'v' or mode == 'x' then
    var_name = get_visual_selection()[1]
    var_name = var_name:gsub("%s+", "")
  end

  -- create directory
  -- the directory variable is defined in: ~/.config/nvim/lua/global_vars.lua
  os.execute("mkdir " .. dir_vd_temp)  -- require("lfs").mkdir(dir_vd_temp)
  local var_file_path = dir_vd_temp .. var_name .. '.parquet'  -- os.date('%Y%m%d%H%M%S')
  require('iron').core.send('python', 'import pyarrow; ' .. var_name .. '.to_parquet("' .. var_file_path .. '")\n')

  local vd_cmd = 'TermExec cmd="vd ' .. var_file_path .. '"   direction=' .. direction .. ' name=visidataTerm'
  vim.cmd(vd_cmd)

end

return {
  "Vigemus/iron.nvim",
  ft = { "python" },
  cmd = { "IronRepl" },
  config = function()
    local iron = require "iron.core"
    iron.setup {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = function()
              if vim.fn.has "win64" then
                return { "powershell" }
              else
                return { "zsh" }
              end
            end,
          },
          python = {
            command = py_command,
            -- command = function()
            --   if vim.fn.has('win64') == 1 then
            --     return { "ipython", "--pylab=qt5" }
            --   else
            --     return { "ipython", "--pylab=qt5", "--no-autoindent" }
            --   end
            -- end, -- or { "ipython", "--no-autoindent" } --matplotlib=qt5

            format = require("iron.fts.common").bracketed_paste_python,
          },
          r = {
            command = {"radian"},
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        -- repl_open_cmd = require("iron.view").right(60),
        repl_open_cmd = require("iron.view").split.vertical("40%", {
          winfixwidth = false,
          winfixheight = false,
          -- any window-local configuration can be used here
          number = true,
          filetype = "ironrepl",
        }),
      },
      keymaps = {
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        -- see:https://github.com/Vigemus/iron.nvim/blob/master/doc/iron.txt
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }
  end,
  dependencies = {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = {
      autocmds = {
        auto_iron = {
          {
            event = { "FileType", },
            -- "BufWinEnter", "BufRead", "BufNewFile", "BufNew", "BufAdd", "BufEnter", "TabNewEntered", "TabEnter",
            pattern = { "python", "*.py", "*.python", "*.ipython", "*.ipy" },
            desc = "Iron repl support",
            callback = function()
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "r", "<cmd>IronRepl<CR><ESC>", { expr = false, noremap = true, desc = " Start REPL" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "R", "<cmd>IronRestart<CR><ESC>", { expr = false, noremap = true, desc = " Restart REPL" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "i", "<cmd>IronFocus<CR>", { expr = false, noremap = true, desc = " Jump (in)to REPL" }) -- i
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "h", "<cmd>IronHide<CR>", { expr = false, noremap = true, desc = "Hide REPL" }) -- i
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "f", "<cmd> lua require 'iron.core'.send_file()<CR><ESC>", { expr = false, noremap = true, desc = "Send file" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "l", "<cmd> lua require 'iron.core'.send_line()<CR><ESC>", { expr = false, noremap = true, desc = "Send line" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "s", "<cmd> lua require 'iron.core'.send_line()<CR><ESC>", { expr = false, noremap = true, desc = "Send line" })
              vim.api.nvim_buf_set_keymap( 0, "v", prefix .. "l", "<cmd> lua require 'iron.core'.visual_send()<CR><ESC>", { expr = false, noremap = true, desc = "Send selection" })
              vim.api.nvim_buf_set_keymap( 0, "v", prefix .. "s", "<cmd> lua require 'iron.core'.visual_send()<CR><ESC>", { expr = false, noremap = true, desc = "Send selection" })
              -- send file: aa

              -- send variable / word under cursor:
              vim.api.nvim_buf_set_keymap(0, "n", prefix .. "w", "viW<cmd> lua require 'iron.core'.visual_send()<CR><ESC>", { desc = "Send word / variable" })

              -- core plugin mappints
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "<cr>", "<cmd> lua require('iron').core.send(nil, string.char(13))<CR><ESC>", { expr = false, noremap = true, desc = "Send return to repl" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "m", "<cmd> lua require('iron.core').run_motion('send_motion')<CR><ESC>", { expr = false, noremap = true, desc = "Send motion" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "p", "<cmd> lua require('iron').core.send_paragraph<CR><ESC>", { expr = false, noremap = true, desc = "Send paragrph" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "b", "<cmd> lua require('iron').core.send_code_block(false)<CR><ESC>", { expr = false, noremap = true, desc = "Send block" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "B", "<cmd> lua require('iron').core.send_code_block(true)<CR><ESC>", { expr = false, noremap = true, desc = "Send block and move" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "I", "<cmd> lua require('iron').core.send(nil, string.char(03))<CR><ESC>", { expr = false, noremap = true, desc = "Interupt" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "q", "<cmd> lua require('iron').core.close_repl<CR><ESC>", { expr = false, noremap = true, desc = "Exit"})
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "L", "<cmd> lua require('iron').core.send(nil, string.char(12))<CR><ESC>", { expr = false, noremap = true, desc = "Clear"})
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "u", "<cmd> lua require('iron').core.send_until_cursor<CR><ESC>", { expr = false, noremap = true, desc = "Sent until cursor"})

              -- Visidata
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "v", "<cmd> lua visidata_py('float')<CR>", { expr = false, noremap = true, desc = "View DF" })
              vim.api.nvim_buf_set_keymap( 0, "v", prefix .. "v", "<cmd> lua visidata_py('float')<CR>", { expr = false, noremap = true, desc = "View DF" })

              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "Vs", "<cmd> lua visidata_py('vertical size=50')<CR>", { expr = false, noremap = true, desc = "View DF vertical" })
              vim.api.nvim_buf_set_keymap( 0, "n", prefix .. "Vh", "<cmd> lua visidata_py('horizontal size=50')<CR>", { expr = false, noremap = true, desc = "View DF horizontal" })

              local wk = require "which-key"
              wk.add {
                mode = { "n", "v" },
                {
                  prefix,
                  group = " REPL",
                  -- expand = function()
                  -- return require("which-key.extras").expand.buf()
                  -- end
                },
              }
            end,
          },
        },
      },
      mappings = {
        n = {
          -- [prefix] = { desc = " REPL" },
          -- [prefix .. "r"] = { "<cmd>IronRepl<CR>", desc = "Iron start repl" },
          -- [prefix .. "R"] = { "<cmd>IronRestart<CR>", desc = "Iron restart repl" },
          -- [prefix .. "g"] = { "<cmd>IronFocus<CR>", desc = "Iron go to repl" }, -- jump to
          -- [prefix .. "h"] = { "<cmd>IronHide<CR>", desc = "Iron hide repl" },
          -- [prefix .. "f"] = { "<cmd> lua require 'iron.core'.send_file()<CR>", desc = "File send" },
          -- [prefix .. "l"] = { '<cmd> lua require "iron.core".send_line()<CR>', desc = "Line send" },
          -- [ prefix .. 's' ] = {
          --   "<cmd>lua require('nvim-python-repl').send_statement_definition()<CR>",
          --   noremap = false,
          --   desc = "Send semantic unit to REPL",
          -- },
          -- [ prefix .. 'r' ] = {
          --   '<cmd>lua require("nvim-python-repl").open_repl()<CR>',
          --   noremap = false,
          --   desc = "Opens the REPL in a window split",
          -- },
          -- [ prefix .. 'b' ] = {
          --   "<cmd>lua require('nvim-python-repl').send_buffer_to_repl()<CR>",
          --   noremap = false,
          --   desc = "Send entire buffer to REPL",
          -- },
          -- [ prefix .. 't'] = { desc = " Python REPL toggle" },
          -- [ prefix .. 'te' ] = {
          --   "<cmd>lua require('nvim-python-repl').toggle_execute()<CR>",
          --   noremap = false,
          --   desc = "Toggle automatic command execution in REPL",
          -- },
          -- [ prefix .. 'tv' ] = {
          --   "<cmd>lua require('nvim-python-repl').toggle_vertical()<CR>",
          --   noremap = false,
          --   desc = "Toggle vertical REPL split or horizontal split",
          -- },
        },
        v = {
          -- [prefix] = { desc = " REPL" },
          -- [prefix .. "s"] = {
          --   "<cmd> lua require 'iron.core'.send(nil, core.mark_visual())<CR>",
          --   desc = "Visual send selection",
          -- },
        },
      },
    },
  },
}
