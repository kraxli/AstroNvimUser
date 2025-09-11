-- see also:
-- https://petejon.es/posts/2025-01-29-using-neovim-for-r/

-- https://github.com/jmbuhr/nvim-config/blob/main/lua/plugins/quarto.lua
-- snippets: https://github.com/jmbuhr/nvim-config/blob/main/snips/snippets/quarto.json

local path_python = vim.fn.exepath "python"
vim.env.QUARTO_PYTHON = path_python


return {
  {
    "quarto-dev/quarto-nvim",
    -- enabled = false,
    ft = { "quarto", "qmd", },  -- "markdown", "md",
    cmd = { "QuartoPreview" },
    opts = {},
    config = function()
      require("quarto").setup {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "",  --  "curly" or ""
          languages = { "python", "julia", "bash", "html" },  -- , "r"
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
          -- ft_runners = { python = "iron" }, -- filetype to runner, ie. `{ python = "iron" }`.
          -- Takes precedence over `default_method`
          never_run = { "yaml" }, -- filetypes which are never sent to a code runner
        },
      }
    end,
    dependencies = {
      { "jmbuhr/otter.nvim" ,
          dependencies = {'nvim-treesitter/nvim-treesitter', },
          opts = {},
      },
      'neovim/nvim-lspconfig',
    },
    specs = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = {
        autocmds = {
          auto_ft_quarto = {
            {
              event = "FileType",
              desc = "Quarto ft",
              pattern = { "quarto", "qrm", "*.qrm", "*.quarto", "markdown", "md", },
              callback = function()

                local quarto = require "quarto"
                local wk = require "which-key"

                vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true, desc="󰐗 Quarto preview" })
                vim.keymap.set('n', '<leader>qc', quarto.quartoClosePreview, { silent = true, noremap = true, desc="󰐗 Quarto close preview" })
                vim.keymap.set('n', '<leader>qu', quarto.quartoUpdatePreview, { silent = true, noremap = true, desc="󰐗 Quarto update preview" })
                vim.keymap.set('n', '<leader>qa', "<cmd>QuartoActivate<CR>", { silent = true, noremap = true, desc="󰐗 Quarto activate" })
                vim.keymap.set('n', '<leader>qh', "<cmd>QuartoHelp<CR>", { silent = true, noremap = true, desc="󰐗 Quarto help" })
                vim.keymap.set('n', '<leader>qd', "<cmd>QuartoDiagnostics<CR>", { silent = true, noremap = true, desc="󰐗 Quarto diagnostics" })

                -- vim.keymap.set("n", "<leader>rc", runner.runner.run_cell,  { desc = "run cell", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>rc", "<cmd>QuartoSend<CR>", { desc = "Quarto run cell", silent = true })  -- 󰐗
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>ra", "<cmd>QuartoSendAbove<CR>", { desc = "Quarto run cell & above", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>rb", "<cmd>QuartoSendBelow<CR>", { desc = "Quarto run cell & below", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>rA", "<cmd>QuartoSendAll<CR>", { desc = "Quarto run all cells", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>rl", "<cmd>QuartoSendLine<CR>", { desc = "Quarto run line", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>rs", "<cmd>QuartoSendLine<CR>", { desc = "Quarto run line", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "v", "<leader>rs", "<cmd>QuartoSendRange<CR>", { desc = "Quarto run visual range", silent = true })
                vim.api.nvim_buf_set_keymap( 0, "n", "<leader>rE", "function() quarto.runner.run_all(true) end", { desc = "Quart run everything (all languages)", silent = true })

                wk.add {
                  mode = { "n", "v" },
                  -- { prefix .. "q", group = " 󰟔 Quarto" },
                  { "<leader>" .. "q", group = "󰐗 Quarto" },
                }

                -- vim.lsp.enable({'basedpyright'})

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
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
          "python",
          "r",
          "markdown",
          "markdown_inline",
          "julia",
          "bash",
          "yaml",
          "lua",
          "vim",
          "query",
          "vimdoc",
          -- "latex",
          "html",
          "css",
        })
      end
    end,
  },
}
