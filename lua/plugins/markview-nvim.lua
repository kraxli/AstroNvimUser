-- see: https://github.com/AstroNvim/astrocommunity/tree/92c859efc67cf7c29444344a5e033e6c3800806e/lua/astrocommunity/markdown-and-latex/markview-nvim

return {
  "OXY2DEV/markview.nvim",
  enabled=false,
  ft = function()
    local plugin = require("lazy.core.config").spec.plugins["markview.nvim"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    return opts.filetypes or { "markdown", "quarto", "rmd" }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "html", "markdown", "markdown_inline" })
      end
    end,
  },
  opts = {
    preview = {
      hybrid_modes = { "n" },
      headings = { shift_width = 0 },
    },
  },
}
