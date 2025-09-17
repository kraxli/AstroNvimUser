-- see: astro-community: https://github.com/AstroNvim/astrocommunity/blob/92c859efc67cf7c29444344a5e033e6c3800806e/lua/astrocommunity/editing-support/codecompanion-nvim/init.lua

---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  event = "User AstroFile",
  enabled = false, -- test out / use Avante
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  opts = {
    display = {
      chat = {
        start_in_insert_mode = true,
        window = {
          opts = {
            number = false,
            relativenumber = false,
          },
        },
      },
    },
    strategies = {
      chat = {
        adapter = "gemini_cli", -- "glados",
      },
      inline = {
        adapter = "gemini_cli", -- "glados",
      },
      cmd = {
        adapter = "gemini_cli", -- "glados",
      },
    },
    adapters = {
      http = {
        -- https://github.com/olimorris/codecompanion.nvim/blob/e571dd92e85ae0a7907f6767446f1f0d48e0b61f/doc/extending/adapters.md?plain=1#L44
        opts = { show_defaults = false },
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            name = "gemini",
            formatted_name = "Gemini",
            env = {
              api_key = "GEMINI_API_KEY",
              model = "schema.model.default",
            },
            schema = {
              model = {
                default = "google/gemini-2.5-flash",
                choices = {
                  "google/gemini-2.5-flash",
                  "mistralai/Mistral-Small-24B-Instruct-2501",
                  "google/gemma-3-27b-it",
                  "meta-llama/Llama-3.3-70B-Instruct",
                  "nvidia/Llama-3_3-Nemotron-Super-49B-v1",
                  "OpenGVLab/InternVL2_5-38B-MPO",
                  "Qwen/Qwen2.5-Coder-32B-Instruct",
                },
              },
            },
          })
        end,
        glados = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "glados",
            formatted_name = "Glados",
            url = "https://glados.ctisl.gtri.org/v1/chat/completions",
            env = { api_key = "GLADOS_API_KEY" },
            schema = {
              model = {
                default = "meta-llama/Llama-3.3-70B-Instruct",
                choices = {
                  "meta-llama/Llama-3.3-70B-Instruct",
                  "nvidia/Llama-3_3-Nemotron-Super-49B-v1",
                  "OpenGVLab/InternVL2_5-38B-MPO",
                  "mistralai/Mistral-Small-24B-Instruct-2501",
                  "Qwen/Qwen2.5-Coder-32B-Instruct",
                  "google/gemma-3-27b-it",
                },
              },
            },
          })
        end,
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local prefix = "<Leader>A"
        opts.mappings.n[prefix] = { desc = " AI" }
        opts.mappings.v[prefix] = { desc = " AI" }
        opts.mappings.n[prefix .. "<CR>"] = { function() vim.cmd.CodeCompanionChat "Toggle" end, desc = "AI Chat" }
        opts.mappings.v[prefix .. "<CR>"] = { function() vim.cmd.CodeCompanionChat "Add" end, desc = "Add to AI Chat" }
        opts.mappings.n[prefix .. "A"] = { function() vim.cmd.CodeCompanionActions() end, desc = "AI Actions" }
        opts.mappings.v[prefix .. "A"] = { function() vim.cmd.CodeCompanionActions() end, desc = "AI Actions" }
      end,
    },
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = { "olimorris/codecompanion.nvim" },
      opts = {
        sources = {
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.file_types = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
      end,
    },
    {
      "OXY2DEV/markview.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.preview then opts.preview = {} end
        if not opts.preview.filetypes then opts.preview.filetypes = { "markdown", "quarto", "rmd" } end
        opts.preview.filetypes = require("astrocore").list_insert_unique(opts.preview.filetypes, { "codecompanion" })
      end,
    },
  },
}
