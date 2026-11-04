-- see source: https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/completion/copilot-lua-cmp/init.lua

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function copilot_action(action)
  local copilot = require "copilot.suggestion"
  return function()
    if copilot.is_visible() then
      copilot[action]()
      return true -- doesn't run the next command
    end
  end
end

return {
  "zbirenbaum/copilot.lua",
  -- enabled = environment == 'work',
  -- enabled = false,
  event = "User AstroFile", -- "InsertEnter", "BufReadPost",
  cmd = "Copilot",
  opts = {
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<C-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right | bottom |
        ratio = 0.4,
      },
    },
    -- filetypes = {
    --   markdown = true,
    --   help = true,
    -- },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 15,
      max_lines = nil, -- limit suggestion to this many lines (nil = unlimited)
      trigger_on_accept = true,
      keymap = {
        -- accept = "<M-CR>",  -- not working
        accept_word = "<M-w>",
        accept_line = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
        toggle_auto_trigger = false,
      },
    },
    nes = {
      enabled = false, -- requires copilot-lsp as a dependency
      auto_trigger = false,
      keymap = {
        accept_and_goto = false,
        accept = false,
        dismiss = false,
      },
    },
    auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
  },
  specs = {
    {
      "saghen/blink.cmp",
      optional = true,
      opts = function(_, opts)

        -- opts.keymap["<M-[>"] = { copilot_action "prev" }
        -- opts.keymap["<M-]>"] = { copilot_action "next" }

        opts.keymap["<M-Down>"] = { copilot_action "next" }
        opts.keymap["<M-Up>"]   = { copilot_action "prev" }
        opts.keymap["<M-w>"]    = { copilot_action "accept_word" }
        -- opts.keymap["<M-l>"]    = { copilot_action "accept_line" }
        opts.keymap["<M-j>"]    = { copilot_action "accept_line", "select_next", "fallback" }
        opts.keymap["<M-k>"]    = { copilot_action "dismiss", "select_prev", "fallback" }
        opts.keymap["<M-c>"]    = { copilot_action "dismiss" }
        opts.keymap["<M-a>"]    = { copilot_action "toggle_auto_trigger" }
      end,
    },
    {
      "nvim-mini/mini.icons",
      -- optional = true,
      -- Adds icon for copilot using mini.icons
      opts = function(_, opts)
        if not opts.lsp then opts.lsp = {} end
        if not opts.symbol_map then opts.symbol_map = {} end
        opts.symbol_map.copilot = { glyph = "", hl = "MiniIconsAzure" }
      end,
    },
  },
}
