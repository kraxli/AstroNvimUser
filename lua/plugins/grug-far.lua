local prefix = "<Leader>s"
---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {
    windowCreationCommand = "split",
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { desc = "󰛔 Search/Replace" },
            [prefix .. "s"] = {
              function() require("grug-far").grug_far { transient = true } end,
              desc = "Search/Replace workspace",
            },
            [prefix .. "e"] = {
              function()
                local filter = require("astrocore.buffer").is_valid() and vim.fn.expand "%:e" or nil
                require("grug-far").grug_far { transient = true, prefills = { filesFilter = filter } }
              end,
              desc = "Search/Replace filetype",
            },
            [prefix .. "f"] = {
              function()
                local filter = require("astrocore.buffer").is_valid() and vim.fn.expand "%" or nil
                require("grug-far").grug_far { transient = true, prefills = { flags = filter } }
              end,
              desc = "Search/Replace file",
            },
            [prefix .. "w"] = {
              function()
                require("grug-far").grug_far {
                  transient = true,
                  startCursorRow = 4,
                  prefills = { search = vim.fn.expand "<cword>" },
                }
              end,
              desc = "Search/Replace current",
            },
          },
          v = {
            [prefix] = {
              function() require("grug-far").grug_far { transient = true, startCursorRow = 4 } end,
              desc = "Search/Replace",
            },
          },
        },
      },
    },
    { "catppuccin", optional = true, opts = { integrations = { grug_far = true } } },
  },
}
