-- Sources:
-- https://vhyrro.github.io/posts/neorg-and-luarocks/
-- https://github.com/nvim-neorg/neorg/issues/1342

return {
  {
    "vhyrro/luarocks.nvim",
    enabled = false,
    -- dependencies = {
    --   "MunifTanjim/nui.nvim",
    --   "nvim-neotest/nvim-nio",
    --   "nvim-neorg/lua-utils.nvim",
    --   "nvim-lua/plenary.nvim",
    -- },
    priority = 10000,
    config = true,
    -- build = "nvim -u NORC -l build.lua",
    -- potentially I need to trigger build process by `:Lazy build luarocks.nvim`
  },
  {
    "nvim-neorg/neorg",
    enabled = false,
    dependencies = {
      -- "vhyrro/luarocks.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neorg/lua-utils.nvim",
      "nvim-lua/plenary.nvim",
    },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    -- version = "*", -- Pin Neorg to the latest stable release
    version = "8.0.0", -- Pin Neorg to the latest stable release
    config = true,
    -- potentially run: Lazy build neorg
  },
}
