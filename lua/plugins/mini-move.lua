---@type LazySpec
return {
  "nvim-mini/mini.move",
  keys = {
    { "<M-S-Right>", mode = { "n", "v" } },
    { "<M-S-Left>", mode = { "n", "v" } },
    { "<M-S-Down>", mode = { "n", "v" } },
    { "<M-S-Up>", mode = { "n", "v" } },
  },
  opts = {
    mappings = {
      left = "<M-S-Left>",
      right = "<M-S-Right>",
      down = "<M-S-Down>",
      up = "<M-S-Up>",
      line_left = "<M-S-Left>",
      line_right = "<M-S-Right>",
      line_down = "<M-S-Down>",
      line_up = "<M-S-Up>",
    },
  },
}
