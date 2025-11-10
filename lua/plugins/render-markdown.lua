---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- enabled = false,
  cmd = "RenderMarkdown",
  ft = function()
    local plugin = require("lazy.core.config").spec.plugins["render-markdown.nvim"]
    
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    if opts.file_types == nil then
      opts.file_types = {}
    end

    return table.insert(opts.file_types, "quarto") or { "markdown", "quarto" }
  end,
  opts = {
    completions = { lsp = { enabled = true } },
    pipe_table = { enabled = false },
    sign = { enabled = false },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { render_markdown = true } },
    },
  },
}
