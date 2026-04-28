local servers = {} -- only add local servers if their commands are available
for server, cmd in pairs { julials = "julia", r_language_server = "R" } do
  if vim.fn.executable(cmd) == 1 then table.insert(servers, server) end
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      -- format_on_save = false, -- enable or disable automatic formatting on save
      format_on_save = {
        enabled = false,
        ignore_filetypes = {}, -- disable format on save for specified filetypes
        allow_filetypes = {},  -- only allow formatting on save for these filetypes
      },
    },
  },
}
