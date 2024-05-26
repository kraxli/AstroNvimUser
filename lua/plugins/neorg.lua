return {
  {
    "vhyrro/luarocks.nvim",
    enabled = false,
    priority = 1000,
    config = true,
    -- build = "nvim -u NORC -l build.lua",
    -- potentially I need to trigger build process by `:Lazy build luarocks.nvim`
  },
  {
    "nvim-neorg/neorg",
    enabled = false,
    dependencies = { "luarocks.nvim" },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    -- version = "*", -- Pin Neorg to the latest stable release
    version = "7.0.0", -- Pin Neorg to the latest stable release
    config = true,
    -- potentially run: Lazy build neorg
  },
}
