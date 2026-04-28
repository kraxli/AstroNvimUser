---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  build = "./kitty/install-kittens.bash",
  opts = { at_edge = "stop" },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {},
        },
      },
    },
  },
}
