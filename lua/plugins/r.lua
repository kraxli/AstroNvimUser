local prefix = "<Leader>r"
local localleader = "<LocalLeader>"

function keymap_modes (modes, command, keymap)
  for _, mode in ipairs(modes) do
    vim.api.nvim_buf_set_keymap(0, mode, keymap, command, {})
  end
end

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
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})

            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
            vim.api.nvim_buf_set_keymap(0, "n", "<leader>rs", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs", "<Plug>RSendSelection", {})

            keymap_modes({"n","v","i"}, "<Plug>RStart", "<leader>rr")
            keymap_modes({"n","v","i"}, "<Plug>RClearConsole", "<leader>rc")
            keymap_modes({"n","v","i"}, "<Plug>RClearAll", "<leader>rC")

            -- Print,          names,               structure
            keymap_modes({"n", "i", "v"},  "RObjectPr",         "<leader>rp")
            keymap_modes({"n", "i", "v"},  "RObjectNames",      "<leader>rn")
            keymap_modes({"n", "i", "v"},  "RObjectStr",        "<leader>rt")
            keymap_modes({"n", "i", "v"},  "RViewDF",           "<leader>rv")
            keymap_modes({"n", "i", "v"},  "RDputObj",          "<leader>td")

            keymap_modes({"n", "i"}, "RPackages",          "<leader>rP")


            keymap_modes({"n", "i", "v"},  "RViewDFs",   "<leader>rVs")
            keymap_modes({"n", "i", "v"},  "RViewDFv",   "<leader>rVv")
            keymap_modes({"n", "i", "v"},  "RViewDFa",   "<leader>rVh")

            -- Arguments,      example,      help
            keymap_modes({"n", "v", "i"}, "RShowArgs",  "<leader>ra")
            keymap_modes({"n", "v", "i"}, "RShowEx",    "<leader>re")
            keymap_modes({"n", "v", "i"}, "RHelp",      "<leader>rh")

            -- Summary,        plot,       both
            keymap_modes({"n", "i", "v"},  "RSummary",   "<leader>rS")
            keymap_modes({"n", "i", "v"},  "RPlot",      "<leader>rg")
            keymap_modes({"n", "i", "v"},  "RSPlot",     "<leader>rb")

            -- Object Browser
            keymap_modes({"n", "v", "i"}, "ROBToggle",       "<leader>ro")
            keymap_modes({"n", "v", "i"}, "ROBOpenLists",   "<leader>r=")
            keymap_modes({"n", "v", "i"}, "ROBCloseLists",  "<leader>r-")

            -- Render script with rmarkdown
            keymap_modes({ "n", "v", "i" }, "RMakeRmd",   "<leader>kr")
            keymap_modes({ "n", "v", "i" }, "RMakeAll",   "<leader>ka")
            keymap_modes({ "n", "v", "i" }, "RMakePDFK",  "<leader>kp")
            keymap_modes({ "n", "v", "i" }, "RMakePDFKb", "<leader>kl")
            keymap_modes({ "n", "v", "i" }, "RMakeWord",  "<leader>kw")
            keymap_modes({ "n", "v", "i" }, "RMakeHTML",  "<leader>kh")
            keymap_modes({ "n", "v", "i" }, "RMakeODT",   "<leader>ko")


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
      -- if vim.env.R_AUTO_START == "true" then
      --   opts.auto_start = 1
      --   opts.objbr_auto_start = true
      -- end
      opts.auto_start = "always"
      opts.objbr_auto_start = false

      require("r").setup(opts)
    end,
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = {
        autocmds = {
          auto_rlang = {
            {
              event = {
                "FileType",
                "BufWinEnter",
                "BufRead",
                "BufNewFile",
                "BufNew",
                "BufAdd",
                "BufEnter",
                "TabNewEntered",
                "TabEnter",
              },
              pattern = {
                "R",
                "r",
                "rmd",
                "rnoweb",
                "quarto",
                "rhelp",
                "*.R",
                "*.r",
                "*.rmd",
                "*.rnoweb",
                "*.quarto",
                "*.rhelp",
              },
              desc = "R-nvim",
              callback = function()
                local wk = require "which-key"
                wk.add {
                  mode = { "n", "v" },
                  { prefix, group = "󰟔 Rlang" }, -- Copy Glyphs from Oil! :-)
                }
              end,
            },
          },
        },
        mappings = {
          n = {},
          v = {},
        },
      },
    },
  },
}
