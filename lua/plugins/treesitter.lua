---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed =
      require("astrocore").list_insert_unique(opts.ensure_installed, { "r", "markdown", "rnoweb", "yaml" })
    opts.indent = {
      disable = { "yaml" },
    }
  end,
}
