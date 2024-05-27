return {
  {
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      -- s conflicts with "echasnovski/mini.surround"
      -- { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      -- { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      -- { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
      --
      -- use m instead
      { "m", '<Plug>(leap-forward)', mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "M", '<Plug>(leap-backward)', mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { "gm", '<Plug>(leap-from-window)', mode = { "n", "x", "o" }, desc = "Leap from Windows" },

    },
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(false)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
}
