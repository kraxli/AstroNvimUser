---@type LazySpec
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<Tab>"] = {
        function()
          if vim.g.ai_accept then return vim.g.ai_accept() end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    sources = {
      providers = {
        path = { opts = { trailing_slash = false, show_hidden_files_by_default = true } },
      },
    },
    signature = { enabled = true },
  },
}
