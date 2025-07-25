-- see source: https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/completion/copilot-lua-cmp/init.lua}

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
  enabled = vim.fn.has('win64') == 1,
  event = "User AstroFile", -- "InsertEnter", "BufReadPost",
  cmd = "Copilot",
  opts = {
    suggestion = { enabled = true, auto_trigger = true }, -- , debounce = 150
    -- panel = { enabled = false },
  },
  specs = {
    -- for hrsh7th/nvim-cmp support see:
    -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/completion/copilot-lua-cmp/init.lua}
    {
      "Saghen/blink.cmp",
      opts = function(_, opts)
        if not opts.keymap then opts.keymap = {} end

        opts.keymap["<Tab>"] = {
          copilot_action "accept",
          "select_next",
          "snippet_forward",
          function(cmp)
            if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
          end,
          "fallback",
        }
        -- opts.keymap["<M-[>"] = { copilot_action "prev" }
        -- opts.keymap["<M-]>"] = { copilot_action "next" }
        opts.keymap["<M-CR>"] = { copilot_action "accept" }
        opts.keymap["<M-Down>"] = { copilot_action "next" }
        opts.keymap["<M-Up>"] = { copilot_action "prev" }
        opts.keymap["<M-w>"] = { copilot_action "accept_word" }
        opts.keymap["<M-CR>"] = { copilot_action "accept" }
        opts.keymap["<M-l>"] = { copilot_action "accept_line" }
        opts.keymap["<M-j>"] = { copilot_action "accept_line", "select_next", "fallback" }
        opts.keymap["<M-c>"] = { copilot_action "dismiss" }
        opts.keymap["<M-BS>"] = { copilot_action "dismiss" }
      end,
    },
    {
      "echasnovski/mini.icons",
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
