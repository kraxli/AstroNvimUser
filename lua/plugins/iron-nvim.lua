local prefix = "<Leader>r"
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
            command = { "ipython", "--pylab=qt5" }, -- or { "ipython", "--no-autoindent" } --matplotlib=qt5
            format = require("iron.fts.common").bracketed_paste_python,
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
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<space>rm",
        visual_send = "<space>rs",
        send_file = "<space>rf",
        send_line = "<space>rl",
        send_paragraph = "<space>rp",
        send_until_cursor = "<space>ru",
        -- send_mark = "<space>sm",
        -- mark_motion = "<space>mc",
        -- mark_visual = "<space>mc",
        -- remove_mark = "<space>md",
        cr = "<space>r<cr>",
        interrupt = "<space>r<space>",  -- ri or rd ?
        exit = "<space>rq",  -- TODO: create autocommand with close q
        clear = "<space>rc",
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
      mappings = {
          n = {
            [ prefix ] = { desc = " REPL iron" },
            [ prefix .. "r" ] = {'<cmd>IronRepl<CR>', desc = 'Iron start repl'},
            [ prefix .. "R" ] = {'<cmd>IronRestart<CR>', desc = 'Iron restart repl'},
            [ prefix .. "g" ] = {'<cmd>IronFocus<CR>', desc = 'Iron go to repl'}, -- jump to
            [ prefix .. "h" ] = {'<cmd>IronHide<CR>', desc = 'Iron hide repl'},
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
            -- [prefix] = { desc = " REPL iron" },
            -- [prefix .. "s"] = {"<cmd> lua require('nvim-python-repl').send_visual_to_repl()<CR>", noremap=false, desc="Send visual selection to REPL"},
          },
      },
    },
  },
}