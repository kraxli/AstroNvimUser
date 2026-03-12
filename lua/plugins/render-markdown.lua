---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- enabled = false,
  cmd = "RenderMarkdown",
  -- ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
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
    sign = { enabled = false },  -- width = "block", right_pad = 1,
    checkbox = { enabled = false, },
    heading = { sign = false, icons = {}, },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { render_markdown = true } },
    },
  },
  -- config = function(_, opts)
  --   require("render-markdown").setup(opts)
  --   Snacks.toggle({
  --     name = "Render Markdown",
  --     get = require("render-markdown").get,
  --     set = require("render-markdown").set,
  --   }):map("<leader>um")
  -- end,
}


