return {
  {
    "hrsh7th/nvim-cmp",
    -- optional = true,
    ft = {'R'},
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
    opts = function(plugin, opts) 
      table.insert(opts.ensure_installed, { "r", "markdown", "rnoweb", "yaml" }) 
    end,
  },
  {
    "R-nvim/R.nvim",
    -- ft = {'R'},
    config = function()
      -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>rs", "<Plug>RDSendLine", {})
      -- vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs", "<Plug>RSendSelection", {})
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { "--quiet", "--no-save" },
        min_editor_width = 72,
        rconsole_width = 78,
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
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
    lazy = false,
  },

  -- R.nvim requires treesitter parsers for "r", "markdown", "rnoweb", and "yaml". Please, install them.

  -- dependencies = {
  --   "AstroNvim/astrocore",
  --   ---@param opts AstroCoreOpts
  --   opts = {
  --     autocmds = {
  --       auto_r = {
  --         {
  --           event = "FileType",
  --           pattern = { "R" },
  --           desc = "R support",
  --           callback = function()
  --             -- vim.keymap.set("n", prefix .. "r", "<cmd>IronRepl<CR>", { expr = false, noremap = true, buffer = true, desc = " Start REPL" })
  --             vim.api.nvim_buf_set_keymap(0, "n", "<leader>rs", "<Plug>RDSendLine", {})
  --             vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs", "<Plug>RSendSelection", {})
  --           end,
  --         },
  --       },
  --     },
  --     mappings = {},
  --   },
  -- },

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   run = ":TSUpdate",
  --   config = function()
  --     require("nvim-treesitter.configs").setup {
  --       ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb", "yaml" },
  --     }
  --   end,
  -- },
}
