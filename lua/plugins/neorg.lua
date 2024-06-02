-- Sources:
-- https://vhyrro.github.io/posts/neorg-and-luarocks/
-- https://github.com/nvim-neorg/neorg/issues/1342

return {
  {
    "vhyrro/luarocks.nvim",
    enabled = false,
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    enabled = false,
    dependencies = { "luarocks.nvim" },
    version = "*",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },

  -- {
  --   "vhyrro/luarocks.nvim",
  --   -- enabled = false,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-neotest/nvim-nio",
  --     "nvim-neorg/lua-utils.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   priority = 10000,
  --   config = true,
  --   -- build = "nvim -u NORC -l build.lua",
  --   -- potentially I need to trigger build process by `:Lazy build luarocks.nvim`
  -- },
  -- {
  --   "nvim-neorg/neorg",
  --   -- enabled = false,
  --   dependencies = {
  --     "vhyrro/luarocks.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-neotest/nvim-nio",
  --     "nvim-neorg/lua-utils.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  --   -- version = "*", -- Pin Neorg to the latest stable release
  --   version = "8.0.0", -- Pin Neorg to the latest stable release
  --   -- config = true,
  --   config = function(_, opts) require("neorg").setup(opts) end,
  --
  --   -- potentially run: Lazy build neorg
  -- },
}
