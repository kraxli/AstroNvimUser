local extra_curl_args = {}
local fuzzy_implementation = "prefer_rust" -- prefer_rust_with_warning

if vim.fn.has "win64" == 1 then
  extra_curl_args = { "-k", "--insecure", "--ssl-no-revoke" }
  fuzzy_implementation = "lua"
end

---@type LazySpec
return {
  "Saghen/blink.cmp",
  version = "^1",
  -- build = 'cargo +nightly build --release',
  opts = {
    fuzzy = {
      implementation = fuzzy_implementation,
      prebuilt_binaries = {
        extra_curl_args = extra_curl_args,
      },
    },
    keymap = {
      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    sources = {
      providers = {
        path = { opts = { trailing_slash = false, show_hidden_files_by_default = true } },
        cmdline = {
          min_keyword_length = function(ctx)
            -- when typing a command, only show when the keyword is 3 characters or longer
            if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
          return 0
          end
        },
      },
    },
    signature = { enabled = true },
    cmdline = {
      -- keymap = { preset = 'inherit' },
      -- completion = { menu = { auto_show = true } },
      enabled = true,
      completion = { menu = { auto_show = true,  }, ghost_text = { enabled = true }, },
      keymap = {
        -- recommended, as the default keymap will only show and select the next item
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "show", "accept", "fallback" },
        ["<Right>"] = { "accept", "fallback" },
        ["<Left>"] = { "cancel", "fallback" },
        ["<ESC>"] = { "cancel", "fallback" },
        ["<CR>"] = { "fallback" },  -- { "accept_and_enter", "fallback" },
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
