require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    -- version = "^4", -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      -- icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      -- pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      -- update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  { import = "community" },
  { import = "base" },
  { import = "plugins" },
  { import = "commands" },
} --[[@as LazySpec]], {
  dev = {
    ---@param plugin LazyPlugin
    path = function(plugin)
      local dir = plugin.url:match "^https://(.*)%.git$"
      return dir and vim.env.GIT_PATH and vim.env.GIT_PATH .. "/" .. dir or "~/projects/" .. plugin.name
    end,
    patterns = {
      -- "AstroNvim", -- local AstroNvim
    },
  },
  defaults = { lazy = true },
  diff = { cmd = "terminal_git" },

  checker = vim.fn.has('unix') == 1 and {enabled = true } or {enabled = false, concurrency = 1 },
  wait = vim.fn.has('unix') == 1 and false or true,
  -- concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
  concurrency = jit.os:find("Windows") and 1 or nil,

  install = { colorscheme = { "catppuccin", "astrodark", "habamax", "kanagawa" } },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
  ui = { backdrop = 50 },
} --[[@as LazyConfig]])
