return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        c = {

          -- cnoremap <c-v> <MiddleMouse>
          -- cnoremap <S-Insert> <MiddleMouse>
          -- cnoremap <C-s> <cmd>write<CR>
          --
          -- " Navigation in command line
          -- cnoremap <C-h> <Home>
          -- cnoremap <C-l> <End>
          -- cnoremap <C-f> <Right>
          -- cnoremap <C-b> <Left>
          ["<Up>"] = {
            function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>" end,
            expr = true,
            silent = false,
            desc = "Select item above",
          },
          ["<Down>"] = {
            function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>" end,
            expr = true,
            silent = false,
            desc = "Select item below",
          },
        },
        i = {

          -- vim.api.nvim_set_keymap("i", "<M-left>", "<C-o>", { noremap = true })
          -- vim.api.nvim_set_keymap("i", "<M-right>", "<C-i>", { noremap = false })

          -- ["<M-right>"] = { "<C-i>", desc = "Move to next position" },
          -- ["<M-left>"] = { "<C-o>", desc = "Move to previous position" },
          -- ["<C-right>"] = { "<C-i>", desc = "Move to next position" },
          -- ["<C-left>"] = { "<C-o>", desc = "Move to previous position" },
        },
        n = {

          ["<M-right>"] = { "<C-i>", desc = "Move to next position" },
          ["<BS>"] = { "<C-o>", desc = "Move to previous position" },
          -- vim.api.nvim_set_keymap("n", "<BS>", "<C-o>", { noremap = true }) -- backspace
          ["<M-left>"] = { "<C-o>", desc = "Move to previous position" },
          -- ["<C-BS>"] = { "<C-o>", desc = "Move to previous position" },
          -- ["<S-BS>"] = { "<C-i>", desc = "Move to previous position" },

          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          -- ["<Leader>vt"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          -- ["<Leader>vD"] = {
          --   function()
          --     require("astroui.status").heirline.buffer_picker(
          --       function(bufnr) require("astrocore.buffer").close(bufnr) end
          --     )
          --   end,
          --   desc = "Pick to close",
          -- },

          -- quick save
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

          ["<C-PageDown>"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["<C-PageUp>"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          ["]b"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["[b"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          ["<leader>"] = {
            ["b"] = {
              name = "Buffers",
              ["."] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers list" },
              ["f"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers list" },
              ["R"] = {
                '<cmd> lua require("astrocore.buffer").close_right()<CR>',
                "Close buffers to the right",
              },
              ["L"] = {
                '<cmd> lua require("astrocore.buffer").close_left()<CR>',
                "Close buffers to the left",
              },
              ["r"] = {
                '<cmd> lua require("astrocore.buffer").move(-vim.v.count1)<CR>',
                "Previous buffer",
              },
              ["l"] = {
                '<cmd> lua require("astrocore.buffer").move(vim.v.count1)<CR>',
                "Previous buffer",
              },
            },
            ["f"] = {
              -- name = "Find / Search",
              -- " Spelling
              ["s"] = { '<cmd>lua require("telescope.builtin").spell_suggest()<CR>', "Spell suggestions" },
              ["z"] = { '<cmd>lua require("telescope.builtin").spell_suggest()<CR>', "Spell suggestions" },

              ["N"] = { '<cmd>lua require"user.plugins.telescope".pickers.notebook()<CR>', "Notebook" },
              ["T"] = { "<cmd>Telescope termfinder find<CR>", "Terminals" },
              -- ["T"] = { "<Cmd>AerialToggle<CR>", "Code Outline" }, -- already mapped at <leader>lS
              -- ["u"] = { '<cmd>lua require("telescope.builtin").oldfiles()<CR>', "Files old" }, -- same as: <leader>fo
              ["u"] = { '<cmd>lua require("telescope.builtin").resume()<CR>', "Resume last" }, -- same as: <leader>f<CR>
              ["x"] = { '<cmd>lua require("telescope.builtin").resume()<CR>', "Resume last" }, -- same as: <leader>f<CR>
            },
            ["z"] = {
              name = "Text / Zettel",
              ["u"] = { "<cmd>keeppatterns %substitute/\\s\\+$//e<CR>", "Clear postspace" },
            },
          },
          -- -- AstroNvim way:
          -- ["<localleader>r"] = {
          --   function() require("astrocore.buffer").move(-vim.v.count1) end,
          --   desc = "Previous buffer",
          -- },
          ["<localleader>"] = {
            ["x"] = {
              name = "xxx",
              -- ["x"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers list" },
            },
          },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,

          ["jj"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
