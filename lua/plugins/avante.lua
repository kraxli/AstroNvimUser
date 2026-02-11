local prefix = "<Leader>A"
---@type LazySpec
return {
  "yetone/avante.nvim",
  -- enabled = false, -- test out CodeCompanion
  build = "make",
  event = "User AstroFile",
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteEdit",
    "AvanteRefresh",
    "AvanteSwitchProvider",
    "AvanteChat",
    "AvanteToggle",
    "AvanteClear",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "AstroNvim/astrocore", opts = function(_, opts) opts.mappings.n[prefix] = { desc = " Avante" } end },
  },
  opts = {
    provider = "glados",
    auto_suggestions_provider = "glados",
    providers = {
      copilot = { api_key_name = "GITHUB_TOKEN", hide_in_model_selector = false },
      openai = { hide_in_model_selector = true },
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
    hints = { enabled = false },
    mappings = {
      ask = prefix .. "<CR>",
      edit = prefix .. "e",
      refresh = prefix .. "r",
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
      select_model = prefix .. "m",
      select_history = prefix .. "h",
    },
    windows = {
      width = 45,
    },
  },
  specs = {
    {
      "Kaiser-Yang/blink-cmp-avante",
      lazy = true,
      specs = {
        "saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            per_filetype = {
              AvanteInput = { "avante" },
            },
            providers = {
              avante = { module = "blink-cmp-avante", name = "Avante", opts = {} },
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
  },
}
