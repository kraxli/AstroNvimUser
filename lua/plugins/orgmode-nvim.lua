return {
  {
    "nvim-orgmode/orgmode",
    enabled = true,
    event = "VeryLazy",
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = vim.g.dirPkd .. "/**/*",
        org_default_notes_file = vim.g.dirPkd .. "/refile.org",
      }

      -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
      -- add `org` to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<leader>o"] = false,
            ["<leader>"] = {
              ["o"] = {
                name = "Orgmode",
                ["b"] = { name = "Tangle" }, -- ??
                ["i"] = { name = "Insert / change" },
                ["l"] = { name = "Lsp" },
                ["x"] = { name = "Clock effort" },
              },
            },
          },
        },
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.1.0",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
        tag = "0.3.4",
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
