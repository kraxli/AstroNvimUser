local prefix = "<leader>q"

return {
  {
    "quarto-dev/quarto-nvim",
    -- ft = { "quarto", "qmd" },
    opts = {},
    config = function ()
      local quarto = require('quarto')
      quarto.setup()
      vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true })
    end,
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { "jmbuhr/otter.nvim" },
      -- {'jmbuhr/quarto-nvim-kickstarter'},
      {"AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
        opts = {
          mappings = {
            n = {
              -- ["<leader>q"] = {group = "[q]uarto"},
              [prefix] = {desc = "[q]uarto"},
            },
          },
        }
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
          "r",
          "python",
          "markdown",
          "markdown_inline",
          "julia",
          "bash",
          "yaml",
          "lua",
          "vim",
          "query",
          "vimdoc",
          "latex",
          "html",
          "css",
        })
      end
    end,
  },
}
