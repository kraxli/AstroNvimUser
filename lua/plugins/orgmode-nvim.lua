local prefix = "<Leader>o"

local file_gtd_actions = 'gtd-actions.org'
file_path_gtd_actions = vim.g.dirPkd .. '/org/' .. file_gtd_actions
local cmd_open_org_actions = ":lua vim.cmd(':e ' .. file_path_gtd_actions)"

vim.api.nvim_create_user_command('OrgActions', cmd_open_org_actions, {})
vim.keymap.set('n', '<leader>oo', cmd_open_org_actions .. '<CR>', {noremap = true, desc='Open gtd-actions'})

return {
  {
    "nvim-orgmode/orgmode",
    enabled = true,
    branch = "master",
    event = "VeryLazy",
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = vim.fn.has "unix" and vim.g.dirPkd .. "/**/*" or vim.g.dirPkd .. "/org/**",
        org_default_notes_file = file_path_gtd_actions,  -- refile
        org_startup_folded = "showeverything", -- inherit, showeverything, content, overview
        org_capture_templates = { t = { description = "Task", template = "* TODO %?\nSCHEDULED: %t" } },
        mappings = {
          -- see: https://github.com/nvim-orgmode/orgmode/blob/c9bf6d8e926c5d6ad7103ee8e7b1e38500b7bfc5/lua/orgmode/config/defaults.lua
          global = {
            org_agenda = { prefix .. "a" },
            org_capture = { prefix .. "c" },
          },
          org = {
            org_set_tags_command = prefix .. ":",
            org_todo = prefix .. "t",
            org_todo_prev = prefix .. "T",
            org_open_at_point = prefix .. "O",
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
            -- [prefix] = { desc = "Orgmode" },
            [prefix .. "b"] = { desc = "Tangle" }, -- ??
            [prefix .. "i"] = { desc = "Insert / change" },
            [prefix .. "l"] = { desc = "Lsp" },
            [prefix .. "x"] = { desc = "Clock effort" },
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
    -- enabled=false,
    ft = "org",
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
          checkboxes = {
            half = { "", "OrgTSCheckboxHalfChecked" },
            done = { "✓", "OrgDone" },
            todo = { " ", "OrgTODO" },
            -- todo = { "˟", "OrgTODO" },
          },
        },
      }
    end,
  },
}
