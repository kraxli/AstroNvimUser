---@type LazySpec
return {
"AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      ensure_installed = { "vim", "lua",  "r", "markdown", "rnoweb", "yaml" },
      highlight = true,
      indent = {
        disable = { "yaml" },
      },
      textobjects = {
        select = {
          select_textobject = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
          },
        },
      },
    },
  },
}
