-- see: https://codecompanion.olimorris.dev/

local adapter_chat = "copilot" -- or "claude_code", "glados", "openai", "mistral", "gemini", "deepseek", "openrouter"
local adapter_inline = "copilot" -- or "claude_code", "glados", "openai", "mistral", "gemini", "deepseek", "openrouter"
local adapter_cmd = "copilot" -- or "claude_code", "glados", "openai", "mistral", "gemini", "deepseek", "openrouter"
local adapter_background = "copilot" -- or "claude_code", "glados", "openai", "mistral", "gemini", "deepseek", "openrouter"

---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  event = "User AstroFile",
  enabled = false, -- test out Avante
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
    interactions = { -- strategies = {

      chat = {
        adapter = adapter_chat,
      },
      inline = {
        adapter = adapter_inline,
      },
      cmd = {
        adapter = adapter_cmd,
      },
      background = {
        -- adapter = {
        -- name = "ollama",
        -- model = "qwen3:8b",
        -- },
        adapter = adapter_background,
      },
    },

    -- Custom adapter setups with specific models
    adapters = {
      --   opts = { show_defaults = false },
      http = {
        -- 1. Anthropic HTTP Adapter
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                -- default = "claude-haiku-5-5",
                -- default = "claude-opus-5-5",
                default = "claude-3-7-sonnet-20250219",
              },
            },
          })
        end,

        -- 2. Gemini HTTP Adapter (using latest Flash model)
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-3.5-flash",
              },
            },
          })
        end,

        -- 3. Copilot HTTP Adapter
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4o",
                -- default = "claude-3.7-sonnet",
              },
            },
          })
        end,
        --   glados = function()
        --     return require("codecompanion.adapters").extend("openai", {
        --       name = "glados",
        --       formatted_name = "Glados",
        --       url = "https://glados.ctisl.gtri.org/v1/chat/completions",
        --       env = { api_key = "GLADOS_API_KEY" },
        --       schema = {
        --         model = {
        --           default = "meta-llama/Llama-3.3-70B-Instruct",
        --           choices = {
        --             "meta-llama/Llama-3.3-70B-Instruct",
        --             "nvidia/Llama-3_3-Nemotron-Super-49B-v1",
        --             "OpenGVLab/InternVL2_5-38B-MPO",
        --             "mistralai/Mistral-Small-24B-Instruct-2501",
        --             "Qwen/Qwen2.5-Coder-32B-Instruct",
        --             "google/gemma-3-27b-it",
        --           },
        --         },
        --       },
        --     })
        --   end,
      },

      -- 4. ACP (Agent Client Protocol) Adapters for CLI Agents
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            defaults = {
              session_config_options = {
                model = "claude-3-7-sonnet",
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
      "saghen/blink.cmp",
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
  },
}
