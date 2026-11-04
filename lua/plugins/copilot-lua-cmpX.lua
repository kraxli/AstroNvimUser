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
      auto_trigger = false,
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
    -- for hrsh7th/nvim-cmp support see:
    -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/completion/copilot-lua-cmp/init.lua
    -- {
    --   "AstroNvim/astrocore",
    --   ---@type AstroCoreOpts
    --   opts = {
    --     options = {
    --       g = {
    --         ai_accept = function()
    --           if require("copilot.suggestion").is_visible() then 
    --                require('utils').create_undo()
    --                require("copilot.suggestion").accept() 
    --             return true
    --           end
    --           return (vim.lsp.inline_completion and vim.lsp.inline_completion.get())
    --         end,
    --         --   ai_accept = function()
    --         --     -- return require("sidekick").nes_jump_or_apply()
    --         --       -- or (vim.lsp.inline_completion and vim.lsp.inline_completion.get())
    --         --   end,
    --       },
    --     },
    --   },
    -- },
    {
      "saghen/blink.cmp",
      optional = true,
      opts = function(_, opts)
        -- if not opts.keymap then opts.keymap = {} end
        -- opts.keymap["<Tab>"] = {
        --   "snippet_forward",
        --   function()
        --     if vim.g.ai_accept then return vim.g.ai_accept() end
        --   end,
        --   "fallback",
        -- }
        -- opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }

        -- opts.keymap["<Tab>"] = {
        --   -- copilot_action "accept",
        --   require("copilot.suggestion").accept(), -- modifier
        --   require("copilot.suggestion").next(),
        --   "snippet_forward",
        --   function(cmp)
        --     if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
        --   end,
        --   "fallback",
        -- }
        -- opts.keymap["<M-[>"] = { copilot_action "prev" }
        -- opts.keymap["<M-]>"] = { copilot_action "next" }
        -- opts.keymap["<M-CR>"] = { require("copilot.suggestion").accept() }  -- modifier
        -- opts.keymap["<M-Down>"] = { copilot_action "next" }
        --

        -- the below doesn't seem to work
        opts.keymap["<M-Down>"] = { require("copilot.suggestion").next() }
        opts.keymap["<M-Up>"]   = { require("copilot.suggestion").prev() }
        opts.keymap["<M-w>"]    = { require("copilot.suggestion").accept_word() }
        opts.keymap["<M-l>"]    = { require("copilot.suggestion").accept_line() }
        -- opts.keymap["<M-j>"]    = { require("copilot.suggestion").accept_line(), "snippet_forward", "fallback" }    -- conflict
        -- opts.keymap["<M-k>"]    = { require("copilot.suggestion").accept_line(), "snippet_backward", "fallback" }   -- conflict
        opts.keymap["<M-c>"]    = { require("copilot.suggestion").dismiss() }
        opts.keymap["<M-a>"]    = { require("copilot.suggestion").toggle_auto_trigger() }

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
