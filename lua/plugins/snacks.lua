---@type LazySpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = { enabled = false },
    indent = { enabled = false },
    notifier = { timeout = 1000 },
    gitbrowse = {
      config = function(opts)
        table.insert(opts.remote_patterns, 1, { "^ssh://git%.mehalter%.com/(.*)", "https://code.mehalter.com/%1" })
      end,
      url_patterns = {
        ["code%.mehalter%.com"] = {
          branch = "/src/branch/{branch}",
          file = "/src/branch/{branch}/{file}#L{line_start}-L{line_end}",
          permalink = "/src/commit/{commit}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
        },
      },
    },
    picker = {
      win = {
        preview = { wo = { number = false, relativenumber = false, signcolumn = "no", foldcolumn = "0" } },
      },
    },
  },
}
