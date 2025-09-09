-- see also: 
-- https://petejon.es/posts/2025-01-29-using-neovim-for-r/

-- https://github.com/jmbuhr/nvim-config/blob/main/lua/plugins/quarto.lua
-- snippets: https://github.com/jmbuhr/nvim-config/blob/main/snips/snippets/quarto.json

return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "qmd", },
    cmd = { "QuartoPreview", },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Vigemus/iron.nvim",
    },
    config = function ()
      require('quarto').setup{
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "iron",  -- "molten", "slime", "iron" or <function>
          ft_runners = { python= "iron" },  -- filetype to runner, ie. `{ python = "molten" }`.
          -- Takes precedence over `default_method`
          never_run = { 'yaml' },  -- filetypes which are never sent to a code runner
        },
    }
  end
  },
  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    'GCBallesteros/jupytext.nvim',
    opts = {
      custom_language_formatting = {
        python = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
        r = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
      },
    },
  },

}
