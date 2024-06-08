return {
  "Exafunction/codeium.vim",
  enabled = vim.fn.has "unix" == 1,
  event = "BufEnter", -- "User AstroFile",
  cmd = "Codeium",
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local options, maps = opts.options, opts.mappings
      options.g.codeium_disable_bindings = 1
      options.g.codeium_manual = true
      -- symbol_map = { Codeium = "" }, -- "" """ "🟆", / nf-weather-stars / \ue370

      maps.n["<M-CR>"] = { function() return vim.fn["codeium#Chat"]() end, expr = true, silent = true }
      maps.i["<M-]>"] = { function() return vim.fn["codeium#CycleOrComplete"]() end, expr = true, silent = true }
      maps.i["<M-\\>"] = maps.i["<M-]>"]
      maps.i["<M-[>"] = { function() return vim.fn["codeium#CycleCompletions"](-1) end, expr = true, silent = true }
      maps.i["<M-CR>"] = { function() return vim.fn["codeium#Accept"]() end, expr = true, silent = true }
      maps.i["<M-BS>"] = { function() return vim.fn["codeium#Clear"]() end, expr = true, silent = true }
      maps.n["<Leader>;"] = { function()
        if vim.g.codeium_enabled == true then
          vim.cmd "CodeiumDisable"
        else
          vim.cmd "CodeiumEnable"
        end
      end, silent=true, desc='Codeium toggle' }
    end,
  },
}

-- return {
--   "Exafunction/codeium.nvim",
--   enabled = false,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "hrsh7th/nvim-cmp",
--   },
--   event = "User AstroFile",
--   cmd = "Codeium",
--   config = function()
--     require("codeium").setup {
--       formatting = {
--         format = require("lspkind").cmp_format {
--           mode = "symbol",
--           maxwidth = 50,
--           ellipsis_char = "...",
--           symbol_map = { Codeium = "" }, -- "" """ "🟆", / nf-weather-stars / \ue370
--         },
--       },
--     }
--
--     vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
--     vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
--     vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
--     vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
-- }
