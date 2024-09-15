local prefix = "<Leader>r"
local localleader = "<LocalLeader>"
return {
  {
    "hrsh7th/nvim-cmp",
    -- optional = true,
    ft = { "R", "r", "rmd", "rnoweb", "quarto", "rhelp" },
    dependencies = { "R-nvim/cmp-r" },
    opts = function(_, opts)
      if not opts.sources then opts.sources = {} end
      table.insert(opts.sources, {
        { name = "cmp_r", priority = 800 },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(plugin, opts) table.insert(opts.ensure_installed, { "r", "markdown", "rnoweb", "yaml" }) end,
  },
  {
    "R-nvim/R.nvim",
    lazy = false,
    -- ft = {'R'},
    config = function()
      -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>rs", "<Plug>RDSendLine", {})
      -- vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs", "<Plug>RSendSelection", {})
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { "--quiet", "--no-save" },
        min_editor_width = 72,
        rconsole_width = 78,
        disable_cmds = {},
        nvimpager = "split_v",
        -- ,,:                |>
        -- <m--> / Alt + -:   <-
        user_maps_only = false,
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})

            -- If you want an action over an selection, then the second
            -- argument must be the string `"v"`:
            -- In this case, the beginning and the end of the selection must be
            -- in the same line.
            -- vim.api.nvim_buf_set_keymap(0, "v", "<LocalLeader>T", "<Cmd>lua require('r.run').action('head')<CR>", {})

            -- If a third optional argument starts with a comma, it will be
            -- inserted as argument(s) to the `action`:
            -- vim.api.nvim_buf_set_keymap( 0, "n", "<LocalLeader>H", "<Cmd>lua require('r.run').action('head', 'n', ', n = 10')<CR>", {})

            -- If the command that you want to send does not require an R
            -- object as argument, you can use `cmd()` from the `r.send` module
            -- to send it directly to R Console:
            -- vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>S", "<Cmd>lua require('r.send').cmd('search()')<CR>", {})
          end,
        },
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = 1
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = {
        autocmds = {
          auto_rlang = {
            {
              event = "FileType",
              pattern = { "R", "r", "rmd", "rnoweb", "quarto", "rhelp" },
              desc = "R-nvim",
              callback = function()
                local wk = require "which-key"
                wk.add({
                  mode = {"n", "v"},
                  {prefix, group = "󰟔 Rlang" },  -- Copy Glyphs from Oil! :-)
                })
              end,
            },
          },
        },
        mappings = {
          n = {
          },
          v = {
          },
        },
      },
    },
  },
}
