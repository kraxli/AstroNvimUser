local prefix = "<Leader>A"

-- local provider = (environment == "work") and "openai" or "claude"  -- "mistral" -- claude, gemini, glados, mistral, copilot,...
local provider = (environment == "work") and "copilot" or "claude"  -- "mistral", openai, claude, gemini, glados, mistral, copilot,...
local authentication = (environment == "work") and "copilot" or ""

-- Higher temperature values like 0.7 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
local temperature = 0.2

---@type LazySpec
return {
  "yetone/avante.nvim",
  -- enabled = false,  -- test out codecompanion
  build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  -- build = "make",
  event = "User AstroFile",
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteEdit",
    "AvanteRefresh",
    "AvanteSwitchProvider",
    "AvanteShowRepoMap",
    "AvanteModels",
    "AvanteChatNew",
    "AvanteChat",
    "AvanteToggle",
    "AvanteClear",
    "AvanteFocus",
    "AvanteStop",
  },
  dependencies = {
    { "stevearc/dressing.nvim", optional = true },
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "AstroNvim/astrocore", opts = function(_, opts) opts.mappings.n[prefix] = { desc = " Avante" } end },
  },
  opts = {
    provider = provider,
    auto_suggestions_provider = provider,
    auto_suggestions = true,  -- default: false
    providers = {
      gemini = {
        model = "gemini-flash-latest", -- gemini-2.5-flash, gemini-2.5-flash-lite, gemini-flash-latest, gemini-flash-lite-latest
        -- model = "gemini-flash-lite-latest",
        -- api_key_name = 'AVANTE_GEMINI_API_KEY'
      },
      openai = {
        model = "gpt-4o", -- Specify your desired model
        api_key_name = "OPENAI_API_KEY", -- The name of the environment variable holding the key
        endpoint = "https://api.openai.com/v1/chat/completions", -- Default OpenAI endpoint
        -- extra_request_body = { temperature = temperature },
        -- hide_in_model_selector = true
      },
      -- openai = { hide_in_model_selector = true },
      ollama = {
        endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
        model = "qwq:32b",
      },
      mistral = {
        -- works with credit
        __inherited_from = "openai",
        endpoint = "https://api.mistral.ai/v1", -- 'https://api.mistral.ai/v1/chat/completions',
        model = "mistral-large-latest", -- "mistral-small-latest",
        api_key_name = "MISTRAL_API_KEY",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = temperature,
          max_tokens = 20480, -- 4096,  -- to avoid using max_completion_tokens
        },
        -- hide_in_model_selector = true,
      },
      copilot = { hide_in_model_selector = false }, -- api_key_name = "GITHUB_TOKEN",
      claude = {
        -- works with credit
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = temperature,
          -- max_tokens = 20480,
        },
        -- hide_in_model_selector = true,
      },
      vertex = { hide_in_model_selector = true },
      vertex_claude = { hide_in_model_selector = true },
      glados = {
        __inherited_from = "openai",
        endpoint = "https://glados.ctisl.gtri.org/v1",
        model = "meta-llama/Llama-3.3-70B-Instruct",
        api_key_name = "GLADOS_API_KEY",
        disable_tools = true,
        hide_in_model_selector = false,
      },
    },
    acp_providers = {
      ["gemini-cli"] = {
        command = "gemini",
        args = { "--experimental-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          GEMINI_API_KEY = os.getenv "GEMINI_API_KEY",
        },
      },
      ["claude-code"] = {
        command = "npx",
        args = { "@zed-industries/claude-code-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          ANTHROPIC_API_KEY = os.getenv "ANTHROPIC_API_KEY",
        },
      },
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
      proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
    },
    -- other configuration options...
    hints = { enabled = false },
    selection = {
      enabled = true,
      hint_display = "immediate" ,  -- "delayed" | "immediate" | "none"
    },
    mappings = {
      ask = prefix .. "<CR>",
      edit = prefix .. "e",
      refresh = prefix .. "r",
      new_ask = prefix .. "n",
      focus = prefix .. "f",
      stop = prefix .. "S",
      toggle = {
        default = prefix .. "t",
        debug = prefix .. "d",
        hint = prefix .. "h",
        suggestion = prefix .. "s",
        repomap = prefix .. "R",
      },
      diff = {
        next = "]c",
        prev = "[c",
      },
      files = {
        add_current = prefix .. ".",
        add_all_buffers = prefix .. "B",
      },
      suggestion = {
        accept = "<M-$>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      select_model = prefix .. "m",
      select_history = prefix .. "h",
    },
    windows = {
      width = 45,
    },
  },
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = { "yetone/avante.nvim" },
      specs = { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
      opts = {
        sources = {
          per_filetype = {
            AvanteInput = { "avante_commands", "avante_mentions", "avante_files" },
          },
          providers = {
            avante_commands = {
              name = "avante_commands",
              module = "blink.compat.source",
              score_offset = 90, -- show at a higher priority than lsp
              opts = {},
            },
            avante_files = {
              name = "avante_commands",
              module = "blink.compat.source",
              score_offset = 100, -- show at a higher priority than lsp
              opts = {},
            },
            avante_mentions = {
              name = "avante_mentions",
              module = "blink.compat.source",
              score_offset = 1000, -- show at a higher priority than lsp
              opts = {},
            },
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.file_types = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "Avante" })
      end,
    },
    {
      -- make sure `Avante` is added as a filetype
      "OXY2DEV/markview.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.preview then opts.preview = {} end
        if not opts.preview.filetypes then opts.preview.filetypes = { "markdown", "quarto", "rmd" } end
        opts.preview.filetypes = require("astrocore").list_insert_unique(opts.preview.filetypes, { "Avante" })
      end,
    },

    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
      opts = {
        filesystem = {
          commands = {
            avante_add_files = function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local relative_path = require("avante.utils").relative_path(filepath)

              local sidebar = require("avante").get()

              local open = sidebar:is_open()
              -- ensure avante sidebar is open
              if not open then
                require("avante.api").ask()
                sidebar = require("avante").get()
              end

              sidebar.file_selector:add_selected_file(relative_path)

              -- remove neo tree buffer
              if not open then sidebar.file_selector:remove_selected_file "neo-tree filesystem [1]" end
            end,
          },
          window = {
            mappings = {
              ["oa"] = "avante_add_files",
            },
          },
        },
      },
    },
  },
}
