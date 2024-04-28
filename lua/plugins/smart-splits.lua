---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          -- resize with arrows
          ["<C-Up>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
          ["<C-Down>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
          ["<C-Left>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
          ["<C-Right>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
        },
      },
    },
  },
  build = "./kitty/install-kittens.bash",
  opts = function(_, opts) opts.at_edge = require("smart-splits.types").AtEdgeBehavior.stop end,
}
