---@type LazySpec
return {
  "jpalardy/vim-slime",
  enabled = false,
  dependencies = {
    "klafyvel/vim-slime-cells",
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {
            slime_target = "neovim",
          },
        },
      },
    },
  },
}
