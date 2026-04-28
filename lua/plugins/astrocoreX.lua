return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    opts = require("astrocore").extend_tbl(opts, {
      options = {
        opt = {
          relativenumber = false, -- Show relative numberline
          spellfile = vim.fn.expand "~/.config/nvim/spell/en.utf-8.add",
        },
      },
      filetypes = {
        extension = {
          qmd = "quarto",
        },
        filename = {
          ["docker-compose.yaml"] = "yaml.docker-compose",
          ["docker-compose.yml"] = "yaml.docker-compose",
        },
        pattern = {
          ["%.env%.[%w_.-]+"] = "sh",
          [".*%.pkr.*%.hcl"] = "hcl.packer",
          [".*/kitty/.+%.conf"] = "bash",
          ["/tmp/neomutt.*"] = "markdown",
        },
      },
      mappings = {

        n = {
          -- disable default bindings
          ["sa"] = false,
          ["q"] = false,
          ["<leader>q"] = false,
          ["<leader>o"] = false,
          ["<Leader>ot"] = false,
          ["<Leader>oT"] = false,

          ["<Right>"] = false,
          ["<Left>"] = false,
          ["<Up>"] = false,
          ["<Down>"] = false,

          -- use treesitter spelling suggestions
          ["z="] = false,

          ["<C-Q>"] = false,
          ["q:"] = ":",
          ["c:"] = "q:",
          ["X"] = ":x<CR>",
          -- better buffer navigation
          -- ["]b"] = false,
          -- ["[b"] = false,
          -- ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          -- ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          -- -- better search
          -- -- better increment/decrement
          -- ["-"] = { "<C-x>", desc = "Descrement number" },
          -- ["+"] = { "<C-a>", desc = "Increment number" },
          -- ["<Leader>n"] = { "<Cmd>enew<CR>", desc = "New File" },
          -- ["<Leader>N"] = { "<Cmd>tabnew<CR>", desc = "New Tab" },
          -- ["<Leader><CR>"] = { '<Esc>/<++><CR>"_c4l', desc = "Next Template" },
          -- ["<Leader>."] = { "<Cmd>cd %:p:h<CR>", desc = "Set CWD" },

          -- orgmode: replace default map for "<leader>o" to use "<leader>o" for orgmode
          ["<leader>E"] = {
            function()
              if vim.bo.filetype == "neo-tree" then
                vim.cmd.wincmd "p"
              else
                vim.cmd.Neotree "focus"
              end
            end,
            desc = "Toggle Explorer Focus",
          },
          ["<Leader>o"] = { desc = "Orgmode" },
          ["<Leader>tP"] = {
            function()
              local term_count = vim.api.nvim_buf_get_number(0)
              local ipython = vim.fn.executable "ipython" == 1 and "ipython"
                or vim.fn.executable "ipython3" == 1 and "ipython3"
              if ipython then
                require("astrocore").toggle_term_cmd {
                  cmd = "ipython --pylab -i --no-autoindent",
                  direction = "float",
                  count = term_count,
                } -- , size=80 width=vim.o.columns * 0.3
              end
            end,
            desc = "ToggleTerm ipython",
          },
          ["<Leader>tp"] = { "<cmd>IronRepl<CR><ESC>", desc = "Open Iron repl vsplit" },
          ["<Leader>uo"] = { "<c-w>o", desc = "Only this window" },
          ["<Leader>uv"] = { "<cmd>vert split<CR>", desc = "Vertical split" },

          -- python = { repl = "ipython", exe_file_terminal = "ipython", exe_file_opt = "--pylab -i", exe_cmd = [[\%run]] },
          -- maps.n["<leader>tp"] = { function() require('user.toggleterm').create_toggle_term({cmd=python, direction='vertical'}, py_term_num) end }

          -- recording
          ["Q"] = { "q", desc = "Record" },
          ["gQ"] = { "@q", desc = "Record" },
          -- time stamps
          ["<F4>"] = { '=strftime("%Y-%m-%d")<CR>P', desc = "Time stamp" },
          -- Miscellaneous
          ["<C-z>"] = { ":undo<cr>", desc = "Undo" },
        },
        -- insert mode
        i = {
          -- ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },
          -- date/time input
          ["<F4>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', desc = "Time stamp" },
        },
        -- terminal mappings
        t = {
          ["jj"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
          ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }, -- ["<esc><esc>"]
          ["<C-n>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
          ["<C-q>"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" }, -- :close
          ["<C-Q>"] = { "<C-\\><C-n>:bd!<CR>", desc = "Terminal delete" },
          ["<C-BS>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
        },
        v = {
          ["sa"] = false,
          -- Telekasten:
          ["<c-space>"] = { "<cmd>lua require('telekasten').toggle_todo({v=true})<CR>", desc = "Toggle checkbox" },
        },
        x = {
          ["sa"] = false,
          -- better increment/decrement
          -- ["+"] = { "g<C-a>", desc = "Increment number" },
          -- ["-"] = { "g<C-x>", desc = "Descrement number" },
        },
        -- ia = {
        --   mktmpl = { function() return "<++>" end, desc = "Insert <++>", expr = true },
        --   ldate = { function() return os.date "%Y/%m/%d %H:%M:%S -" end, desc = "Y/m/d H:M:S -", expr = true },
        --   ndate = { function() return os.date "%Y-%m-%d" end, desc = "Y-m-d", expr = true },
        --   xdate = { function() return os.date "%m/%d/%y" end, desc = "m/d/y", expr = true },
        --   fdate = { function() return os.date "%B %d, %Y" end, desc = "B d, Y", expr = true },
        --   Xdate = { function() return os.date "%H:%M" end, desc = "H:M", expr = true },
        --   Fdate = { function() return os.date "%H:%M:%S" end, desc = "H:M:S", expr = true },
        -- },
      },
    } --[[@as AstroCoreOpts]]) --[[@as AstroCoreOpts]]

    return opts
  end,
}
