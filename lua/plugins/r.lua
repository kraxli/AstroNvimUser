local prefix = "<Leader>r"
local localleader = "<LocalLeader>"

function keymap_modes (modes, command, keymap, opts)
  for _, mode in ipairs(modes) do
    vim.api.nvim_buf_set_keymap(0, mode, keymap, command, opts)
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
        assignment_keymap = "<m-->",
        pipe_keymap = ',,',

        hook = {
          on_filetype = function()
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})

            -- send
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {desc='Send line'})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {desc='Send selection'})
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "s", "<Plug>RDSendLine", {desc='Send line'})
            vim.api.nvim_buf_set_keymap(0, "v", prefix .. "s", "<Plug>RSendSelection", {desc='Send selection'})
            -- TODO: send motions!

            -- edit & operators
            -- vim.api.nvim_buf_set_keymap(0, "i", "<Plug>RAssign", '<Cmd>lua require("r.edit").assign()<CR>', { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "--", "<Plug>RAssign", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", ">>", "<Plug>RPipe", { silent = true, noremap = true, expr = false })
            -- vim.api.nvim_buf_set_keymap(0, "i", "<Plug>RPipe", '<Cmd>lua require("r.edit").pipe()<CR>', { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "..", "<Plug>RPipe", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "<m-.>", "<Plug>RPipe", { silent = true, noremap = true, expr = false })
            -- TODO:
            -- create_maps("nvi", "RSetwd", "rd", "<Cmd>lua require('r.run').setwd()")
            -- create_maps("nvi", "RSeparatePath",    "sp", "<Cmd>lua require('r.path').separate()")
            --
            -- -- Format functions
            -- create_maps("nvi", "RFormatNumbers",    "cn", "<Cmd>lua require('r.format.numbers').formatnum()")
            -- create_maps("nvi", "RFormatSubsetting",    "cs", "<Cmd>lua require('r.format.brackets').formatsubsetting()")

            -- Start
            -- keymap_modes({"n","v","i"}, "<Plug>RStart", prefix .. "r", {})
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').start_R('R')<CR>", prefix .. "r", {desc='R start'})
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').start_R('custom')<CR>", prefix .. "R", {desc='R custom start'})

            -- Close
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').quit_R('nosave')<CR>", prefix .. "q", {desc='R close'})
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').quit_R('save')<CR>", prefix .. "w", {desc='R save & close'})

            keymap_modes({"n","v","i"}, "<Plug>RClearConsole", prefix .. "c", {})
            keymap_modes({"n","v","i"}, "<Plug>RClearAll", prefix .. "C", {})

            -- Print,          names,               structure
            keymap_modes({"n", "i", "v"},  "<Plug>RObjectPr",         prefix .. "p", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RObjectNames",      prefix .. "n", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RObjectStr",        prefix .. "t", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDF",           prefix .. "v", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RDputObj",          "<leader>td", {})

            keymap_modes({"n", "i"}, "<Plug>RPackages",          prefix .. "P", {})

            keymap_modes({"n", "i", "v"},  "<Plug>RViewDFs",   prefix .. "Vs", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDFv",   prefix .. "Vv", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDFa",   prefix .. "Vh", {})

            -- Arguments,      example,      help
            keymap_modes({"n", "v", "i"}, "<Plug>RShowArgs",  prefix .. "a", {})
            keymap_modes({"n", "v", "i"}, "<Plug>RShowEx",    prefix .. "e", {})
            keymap_modes({"n", "v", "i"}, "<Plug>RHelp",      prefix .. "h", {})

            -- Summary,        plot,       both
            keymap_modes({"n", "i", "v"},  "<Plug>RSummary",   prefix .. "S", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RPlot",      prefix .. "g", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RSPlot",     prefix .. "b", {})

            -- Object Browser
            keymap_modes({"n", "v", "i"}, "<Plug>ROBToggle",       prefix .. "o", {})
            keymap_modes({"n", "v", "i"}, "<Plug>ROBOpenLists",   prefix .. "=", {})
            keymap_modes({"n", "v", "i"}, "<Plug>ROBCloseLists",  prefix .. "-", {})

            -- Render script with rmarkdown
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeRmd",   prefix .. "kr", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeAll",   prefix .. "ka", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakePDFK",  prefix .. "kp", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakePDFKb", prefix .. "kl", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeWord",  prefix .. "kw", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeHTML",  prefix .. "kh", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeODT",   prefix .. "ko", {})


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
          n = {
            [prefix .. "k"] = { desc = "  Rmarkdown" },
            [prefix .. "V"] = { desc = " View Dataframe" },
          },
          v = {},
        },
      },
    },
  },
}
