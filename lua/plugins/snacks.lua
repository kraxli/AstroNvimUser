local prefixBuffer = "<leader>b"
local prefixFind = "<leader>f"

local Snacks = require "snacks"

---@type LazySpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = { enabled = true },
    indent = { enabled = false },
    notifier = {
      timeout = 1000,
      top_down = false,
    },
    gitbrowse = {
      config = function(opts)
        table.insert(opts.remote_patterns, 1, { "^ssh://git%.mehalter%.com/(.*)", "https://code.mehalter.com/%1" })
      end,
      url_patterns = {
        ["code%.mehalter%.com"] = {
          branch = "/~files/{branch}",
          file = "/~files/{branch}/{file}?position=source-{line_start}-{line_end}",
          permalink = "/~files/{commit}/{file}?position=source-{line_start}-{line_end}",
          commit = "/~commits/{commit}",
        },
      },
    },
  },
  keys = {
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings

        -- Buffers:
        -- n.maps[prefixBuffer] = { desc = "Buffer" },
        maps.n[prefixBuffer .. "."] = { function() require("snacks").picker.buffers() end, desc = "Buffers list" }
        maps.n[prefixBuffer .. "f"] = { function() require("snacks").picker.buffers() end, desc = "Buffers list" }

        -- Find / Search (= name)
        maps.n[prefixFind .. "j"] = {
          '<cmd>lua require("telescope.builtin").jumplist()<CR>',
          desc = "Jump list",
        }
        -- Spelling
        maps.n["z="] = {
          '<cmd>lua require("telescope.builtin").spell_suggest()<CR>',
          desc = "Spell suggestions",
        }

        maps.n[prefixFind .. "/"] = { function() Snacks.picker.lines() end, desc = "Buffer Lines" }
        -- [prefixFind .. "s"] = {
        --   '<cmd>lua require("telescope.builtin").spell_suggest()<CR>',
        --   desc = "Spell suggestions",
        -- },
        -- [prefixFind .. "z"] = {
        --   '<cmd>lua require("telescope.builtin").spell_suggest()<CR>',
        --   desc = "Spell suggestions",
        -- },
        -- [prefixFind .. "N"] = {
        --   '<cmd>lua require"user.plugins.telescope".pickers.notebook()<CR>',
        --   desc = "Notebook",
        -- },
        -- [prefixFind .. "T"] = { "<cmd>Telescope termfinder find<CR>", desc = "Terminals" },
        -- -- ["T"] = { "<Cmd>AerialToggle<CR>", "Code Outline" }, -- already mapped at <leader>lS
        -- -- ["u"] = { '<cmd>lua require("telescope.builtin").oldfiles()<CR>', "Files old" }, -- same as: <leader>fo
        maps.n[prefixFind .. "u"] = { function() Snacks.picker.resume() end, desc = "Resume last" } -- same as: <leader>f<CR>
        maps.n[prefixFind .. "x"] = { function() Snacks.picker.resume() end, desc = "Resume last" } -- same as: <leader>f<CR>

        -- mode insert:
        maps.i["<C-D>"] = { function() Snacks.bufdelete() end, desc = "Delete Buffer" }
      end,
    },
  },
}
