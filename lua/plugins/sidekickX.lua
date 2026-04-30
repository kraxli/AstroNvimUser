local prefix = "<Leader>A"
local enable_nes = vim.fn.has "unix" == 1

return {
  "folke/sidekick.nvim",
  ---@type sidekick.Config
  opts = {
    nes = { enabled = enable_nes },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {},
        },
        autocmds = {
          auto_sidekick = {
            {
              event = "FileType",
              desc = "Enable sidekick inline suggestions (copilot)",
              pattern = { "*" },
              callback = function() vim.lsp.enable("copilot", enable_nes) end,
            },
          },
        },
        mappings = {
          n = {
            [prefix] = { desc = " AI" },
            -- ["<C-.>"] = false,
            -- ["<C-.>"] = {
            --   function() require("sidekick.cli").toggle { filter = { installed = true } } end,
            --   desc = "Toggle AI CLI",
            -- },
            [prefix .. "<CR>"] = {
              function() require("sidekick.cli").toggle { name = "gemini", focus = true } end,
              desc = "Toggle Gemini",
            },
            ["<M-down>"] = { function() require("sidekick.nes").update() end, desc = "Update sidekick" },
          },
          x = {},
          t = {},
          i = {
            ["<C-CR>"] = {
              function()
                if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then return end
                return "<C-CR>"
              end,
              expr = true,
              desc = "Accept inline completion",
            },
            ["<M-down>"] = { function() require("sidekick.nes").update() end, expr = true, desc = "Update sidekick" },
            ["<M-right>"] = { function() require("sidekick.nes").update() end, desc = "Update sidekick" },
            ["<M-j>"] = { function() require("sidekick.nes").update() end, desc = "Update sidekick" },
            ["<C-right>"] = { function() require("sidekick.nes").update() end, desc = "Update sidekick" },
            -- ["<C-.>"] = {
            --   function() require("sidekick.cli").toggle { filter = { installed = true } } end,
            --   desc = "Toggle AI CLI",
            -- },
          },
        },
      },
    },
  },
}
