---@type LazySpec
return {
  "rebelot/heirline.nvim",
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        status = {
          separators = {
            -- left = { "", " " },
            -- right = { " ", "" },
            left = { " ", "" },
            right = { " ", "" },
          },
        },
      },
    },
  },
}
