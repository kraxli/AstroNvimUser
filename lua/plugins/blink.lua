---@type LazySpec
return {
  "Saghen/blink.cmp",
  version = "^1",
  opts = {
    keymap = {
      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    sources = {
      providers = {
        path = { opts = { trailing_slash = false, show_hidden_files_by_default = true } },
      },
    },
    signature = { enabled = true },
    cmdline = {
      enabled = true,
      completion = { menu = { auto_show = false } },
      keymap = {
        -- recommended, as the default keymap will only show and select the next item
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "show", "accept" },
        ["<Right>"] =  { "accept", "fallback" },
        ['<Left>'] = { 'cancel' },
        ['<ESC>'] = { 'cancel', 'fallback' },
        ['<CR>'] = {'accept_and_enter', 'fallback'},
        -- ["<Right>"] = {
        --   function(cmp)
        --     if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then return cmp.accept() end
        --   end,
        --   "show_and_insert",
        --   "cancel",  -- "accept", --"select_next",
        -- },
      },
    },
  },
}
