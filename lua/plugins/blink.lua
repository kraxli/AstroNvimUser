return {
  "Saghen/blink.cmp",
  version = "^1",
  opts = {
    sources = {
      providers = {
        path = { opts = { trailing_slash = false, show_hidden_files_by_default = true } },
      },
    },
    signature = { enabled = true },
    cmdline = {
      completion = { menu = { auto_show = true } },
      keymap = {
        -- recommended, as the default keymap will only show and select the next item
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "show", "accept" },
        -- ["<Tab>"] = {
        --   function(cmp)
        --     if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then return cmp.accept() end
        --   end,
        --   "show_and_insert",
        --   "select_next",
        -- },
      },
    },
  },
}
