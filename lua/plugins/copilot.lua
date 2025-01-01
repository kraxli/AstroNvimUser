return {
  {
    "zbirenbaum/copilot.lua",
    -- enabled = vim.fn.has "win64" == 1,
    event = "InsertEnter",

    opts = function(_, opts)

      if not opts.filetypes then
        opts.filetypes = {}
      end

      -- table.insert(opts.filetypes, { markdown = true } )
      opts.filetypes["markdown"] = true

    end,

    specs = {
      { import = "astrocommunity.completion.copilot-lua" },
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          local cmp, copilot = require "cmp", require "copilot.suggestion"
          local snip_status_ok, luasnip = pcall(require, "luasnip")
          if not snip_status_ok then return end

          local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
          end

          if not opts.mapping then opts.mapping = {} end

          -- opts.mapping["<Right>"] = cmp.mapping(function(fallback)
          --   if copilot.is_visible() then
          --     copilot.accept()
          --   elseif cmp.visible() then
          --     cmp.select_next_item()
          --   elseif luasnip.expand_or_jumpable() then
          --     luasnip.expand_or_jump()
          --   elseif has_words_before() then
          --     cmp.complete()
          --   else
          --     fallback()
          --   end
          -- end, { "i", "s" })

          opts.mapping["<M-CR>"] = cmp.mapping(function(fallback)
            if copilot.is_visible() then copilot.accept() end
          end, { "i", "s" })

          opts.mapping["<M-down>"] = cmp.mapping(function()
            if copilot.is_visible() then copilot.next() end
          end)
          opts.mapping["<M-up>"] = cmp.mapping(function()
            if copilot.is_visible() then copilot.prev() end
          end)
          opts.mapping["<M-w>"] = cmp.mapping(function()
            if copilot.is_visible() then copilot.accept_word() end
          end)
          opts.mapping["<M-s>"] = cmp.mapping(function()
            if copilot.is_visible() then copilot.accept_line() end
          end)
          -- opts.mapping["<C-j>"] = cmp.mapping(function()
          --   if copilot.is_visible() then copilot.accept_line() end
          -- end)
          opts.mapping["<M-BS>"] = cmp.mapping(function()
            if copilot.is_visible() then copilot.dismiss() end
          end)
          opts.mapping["<M-c>"] = cmp.mapping(function()
            if copilot.is_visible() then copilot.dismiss() end
          end)

          return opts
        end,
      },
    },
  },
  {
    "onsails/lspkind.nvim",
    optional = true,
    -- Adds icon for copilot using lspkind
    opts = function(_, opts) opts.symbol_map.Copilot = "" end,
  },
}
