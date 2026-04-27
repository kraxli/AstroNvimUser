---@type LazySpec
return {
  "jmbuhr/cmp-pandoc-references",
  lazy = true,
  specs = {
    {
      "saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          default = { "pandoc" },
          providers = {
            pandoc = { name = "pandoc_references", module = "cmp-pandoc-references.blink", score_offset = 10 },
          },
        },
      },
    },
  },
}
