local prefixBuffer = "<leader>b"

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

          -- ["<Up>"] = {
          --   function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>" end,
          --   expr = true,
          --   silent = false,
          --   desc = "Select item above",
          -- },
          -- ["<Down>"] = {
          --   function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>" end,
          --   expr = true,
          --   silent = false,
          --   desc = "Select item below",
          -- },
        },
        i = {
          ["<M-right>"] = { "<C-i>", desc = "Move to next position" },
          -- ["<S-BS>"] = { "<C-i>", desc = "Move to next position" },
          ["<M-left>"] = { "<C-o>", desc = "Move to previous position" },
          ["<C-BS>"] = { "<C-o>", desc = "Move to previous position" },
          -- vim.api.nvim_set_keymap("i", "<M-left>", "<C-o>", { noremap = true })
          -- vim.api.nvim_set_keymap("i", "<M-right>", "<C-i>", { noremap = false })

          -- ["<M-right>"] = { "<C-i>", desc = "Move to next position" },
          -- ["<M-left>"] = { "<C-o>", desc = "Move to previous position" },
          -- ["<C-right>"] = { "<C-i>", desc = "Move to next position" },
          -- ["<C-left>"] = { "<C-o>", desc = "Move to previous position" },
        },
        n = {
          ["diw"] = { "diwx", desc = "Delete word and space" },

          ["<M-right>"] = { "<C-i>", desc = "Move to next position" },
          -- ["<S-BS>"] = { "<C-i>", desc = "Move to next position" },
          ["<M-left>"] = { "<C-o>", desc = "Move to previous position" },
          ["<C-BS>"] = { "<C-o>", desc = "Move to previous position" },
          ["<BS>"] = { "<C-o>", desc = "Move to previous position" },
          -- vim.api.nvim_set_keymap("n", "<BS>", "<C-o>", { noremap = true }) -- backspace

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

          -- Clipboard (yank/copy & paste):
          ["<leader>y"] = { desc = "Yank" },
          ["<leader>ya"] = {
            "<cmd>lua require('utils').copy_absolute_path()<CR>",
            silent = true,
            desc = "Yank absolute path",
          },
          ["<leader>yr"] = {
            "<cmd>lua require('utils').copy_relative_path()<CR>",
            silent = true,
            desc = "Yank relative path",
          },
          -- map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = 'Paste' })
          -- map('x', 'P', 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = 'Paste In-place' })

          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- disable as it conflicts with "native nvim show signature"

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

          -- Buffer:
          -- [prefixBuffer] = { desc = "Buffer" },
          [prefixBuffer .. "R"] = {
            '<cmd> lua require("astrocore.buffer").close_right()<CR>',
            desc = "Close buffers to the right",
          },
          [prefixBuffer .. "L"] = {
            '<cmd> lua require("astrocore.buffer").close_left()<CR>',
            desc = "Close buffers to the left",
          },
          [prefixBuffer .. "r"] = {
            '<cmd> lua require("astrocore.buffer").move(-vim.v.count1)<CR>',
            desc = "Previous buffer",
          },
          [prefixBuffer .. "l"] = {
            '<cmd> lua require("astrocore.buffer").move(vim.v.count1)<CR>',
            desc = "Previous buffer",
          },

          -- Substitute:
          ["<leader>uW"] = { "<cmd>keeppatterns %substitute/\\s\\+$//e<CR>", desc = "Clear postspace" },
          ["<leader>zw"] = { "<cmd>keeppatterns %substitute/\\s\\+$//e<CR>", desc = "Clear postspace" },
          -- -- AstroNvim way:
          -- ["<localleader>r"] = {
          --   function() require("astrocore.buffer").move(-vim.v.count1) end,
          --   desc = "Previous buffer",
          -- },
          ["<localleader>x"] = {
            desc = "xxx",
            -- ["x"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers list" },
          },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
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
