-- see also:
-- https://petejon.es/posts/2025-01-29-using-neovim-for-r/

-- https://github.com/jmbuhr/nvim-config/blob/main/lua/plugins/quarto.lua
-- snippets: https://github.com/jmbuhr/nvim-config/blob/main/snips/snippets/quarto.json

return {
  {
    "quarto-dev/quarto-nvim",
    enabled = false,
    ft = { "quarto", "qmd" },
    cmd = { "QuartoPreview" },
    config = function()
      require("quarto").setup {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          -- chunks = "",
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
          default_method = "iron", -- "molten", "slime", "iron" or <function>
          ft_runners = { python = "iron" }, -- filetype to runner, ie. `{ python = "molten" }`.
          -- Takes precedence over `default_method`
          never_run = { "yaml" }, -- filetypes which are never sent to a code runner
        },
      }
    end,
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Vigemus/iron.nvim",
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = {
        autocmds = {
          auto_ft_quarto = {
            {
              event = "FileType",
              desc = "Quarto ft",
              pattern = { "quarto", "qrm", "*.qrm", "*.quarto" },
              callback = function()
                vim.opt.filetype = 'quarto'
                vim.keymap.set({"n"}, "<leader>q", "<nop>", { expr = true, noremap = true, buffer=true, desc = "Insert" })
                vim.keymap.set({"n"}, "<leader>q", "", { expr = true, noremap = true, buffer=true, desc = "Insert" })
                vim.keymap.del({'n'}, '<leader>q', { buffer = 0 })

                local quarto = require('quarto')

                vim.api.nvim_buf_set_keymap(0, 'n', '<leader>qp', "quarto.quartoPreview", { silent = true, noremap = true, desc="Quarto preview" })
                -- vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true, desc="Quarto preview" })
                -- vim.keymap.set("n", "<leader>rc", runner.runner.run_cell,  { desc = "run cell", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>rc", '<cmd>QuartoSend<CR>',  { desc = "Quarto run cell", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>ra", '<cmd>QuartoSendAbove<CR>', { desc = "Quarto run cell & above", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>rb", '<cmd>QuartoSendBelow<CR>', { desc = "Quarto run cell & below", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>rA", '<cmd>QuartoSendAll<CR>',   { desc = "Quarto run all cells", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>rl", '<cmd>QuartoSendLine<CR>',  { desc = "Quarto run line", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>rs", '<cmd>QuartoSendLine<CR>',  { desc = "Quarto run line", silent = true })
                vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs",  '<cmd>QuartoSendRange<CR>', { desc = "Quarto run visual range", silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>rE",
                  "function() quarto.runner.run_all(true) end",
                  { desc = "run everything (all languages)", silent = true }
                )
              end,
            },
          },
        },
      },
    },
  },
  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },
}
