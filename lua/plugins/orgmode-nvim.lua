return {
  {
    "nvim-orgmode/orgmode",
    enabled = true,
    branch = "master",
    event = "VeryLazy",
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = vim.g.dirPkd .. "/**/*",
        org_default_notes_file = vim.g.dirPkd .. "/refile.org",
        org_startup_folded = "showeverything", -- inherit, showeverything, content, overview
        org_capture_templates = { t = { description = "Task", template = "* TODO %?\nSCHEDULED: %t" } },
        mappings = {
          -- see: https://github.com/nvim-orgmode/orgmode/blob/c9bf6d8e926c5d6ad7103ee8e7b1e38500b7bfc5/lua/orgmode/config/defaults.lua
          global = {
            org_agenda = { "<Leader>oa" },
            org_capture = { "<Leader>oc" },
          },
          org = {
            org_set_tags_command = "<Leader>o:",
            org_todo = "<Leader>ot",
            org_todo_prev = "<Leader>oT",
          },
        },
      }

      -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
      -- add `org` to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
      -- NOTE: Windows fixes:
      -- * https://github.com/nvim-orgmode/orgmode/issues/712
      -- * https://github.com/nvim-orgmode/orgmode/issues?q=windows+
      -- * if windows: vim.opt.shellslash = true
    end,
    dependencies = {
      "AstroNvim/astrocore",
      -- opts = function(_, opts)
      --   opts.mappings = {
      --     n = function()
      --       local file_type = vim.bo.filetype
      --       if file_type == "org" then
      --         return {
      --           ["<leader>"] = {
      --             ["o"] = {
      --               name = "Orgmode",
      --               ["b"] = { desc = "Tangle" }, -- ??
      --               ["i"] = { desc = "Insert / change" },
      --               ["l"] = { desc = "Lsp" },
      --               ["x"] = { desc = "Clock effort" },
      --             },
      --           },
      --         }
      --       else
      --         return {
      --           ["<leader>"] = {
      --             ["o"] = {
      --               name = "Orgmode",
      --             },
      --           },
      --         }
      --       end
      --     end,
      --   }
      --   end
      -- },
      opts = {
        mappings = {
          n = {
            ["<leader>"] = {
              ["o"] = {
                ["b"] = { desc = "Tangle" }, -- ??
                ["i"] = { desc = "Insert / change" },
                ["l"] = { desc = "Lsp" },
                ["x"] = { desc = "Clock effort" },
              },
            },
          },
        },
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    enabled = false,
    -- tag = "0.1.0",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
        -- tag = "0.3.4",
      },
    },
    config = function()
      require("org-roam").setup {
        directory = "~/orgfiles",
      }
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup {
        concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
        symbols = {
          -- list symbol
          list = "•",
          -- headlines can be a list
          headlines = { "◉", "○", "✸", "✿" },
          -- or a function that receives the defaults and returns a list
          -- headlines = function(default_list)
          --   table.insert(default_list, "♥")
          --   return default_list
          -- end,
          -- -- or false to disable the symbol. Works for all symbols
          -- headlines = false,
          -- checkboxes = {
          --   half = { "", "OrgTSCheckboxHalfChecked" },
          --   done = { "✓", "OrgDone" },
          --   todo = { "˟", "OrgTODO" },
          -- },
        },
      }
    end,
  },
}
