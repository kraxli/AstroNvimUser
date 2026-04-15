---@type LazySpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = { view = "cmdline" },
    messages = { view_search = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
    },
    routes = {
      { filter = { event = "msg_show", cmdline = "^:lua" }, view = "messages" }, -- send lua output to split
      { filter = { event = "msg_show", min_height = 20 }, view = "messages" }, -- send long messages to split
      { filter = { event = "msg_show", find = "%d+L,%s%d+B" }, opts = { skip = true } }, -- skip save notifications
      { filter = { event = "msg_show", find = "^%d+ more lines$" }, opts = { skip = true } }, -- skip paste notifications
      { filter = { event = "msg_show", find = "^%d+ fewer lines$" }, opts = { skip = true } }, -- skip delete notifications
      { filter = { event = "msg_show", find = "^%d+ lines yanked$" }, opts = { skip = true } }, -- skip yank notifications
      -- { filter = { event = 'msg_show', find = "*lspconfig*" }, opts = { skip = true } }, -- skip lspconfig deprecation warning
      --   { filter = {
      --     event = "msg_show",
      --     any = {
      --       { find = "require('lspconfig') framework is deprecated" },
      --       { find = "lspconfig.lua module will be dropped" },
      --     },
      --   },
      --   opts = { skip = true },
      -- }
      { filter = { find = "lspconfig.*deprecated" }, opts = { skip = true } }, -- skip lspconfig deprecation warning                                                
      { filter = { find = "lspconfig%-nvim%-0%.11" }, opts = { skip = true } }, -- skip lspconfig deprecation warning  
    },
  },
  specs = {
    { "rcarriga/nvim-notify", init = false, config = true },
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { noice = true } },
    },
  },
}
