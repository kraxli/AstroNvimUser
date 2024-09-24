---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local function yaml_ft(path, bufnr)
      local buf_text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
      if
        -- check if file is in roles, tasks, or handlers folder
        vim.regex("(tasks\\|roles\\|handlers)/"):match_str(path)
        -- check for known ansible playbook text and if found, return yaml.ansible
        or vim.regex("hosts:\\|tasks:"):match_str(buf_text)
      then
        return "yaml.ansible"
      elseif vim.regex("AWSTemplateFormatVersion:"):match_str(buf_text) then
        return "yaml.cfn"
      else -- return yaml if nothing else
        return "yaml"
      end
    end
    opts = require("astrocore").extend_tbl(opts, {
      rooter = {
        ignore = { servers = { "julials" } },
        autochdir = true,
      },
      options = {
        opt = {
          conceallevel = 1, -- enable conceal
          list = true, -- show whitespace characters
          listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
          showbreak = "↪ ",
          showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
          spellfile = vim.fn.expand "~/.config/nvim/spell/en.utf-8.add",
          splitkeep = "screen",
          swapfile = false,
          thesaurus = vim.fn.expand "~/.config/nvim/spell/thesaurus.txt",
          wrap = true, -- soft wrap lines
          relativenumber = false, -- Show relative numberline
          signcolumn = "auto", -- sets `vim.opt.relativenumber`
          number = true,
          timeoutlen = 250, --- Time out on mappings (150)
          ttimeoutlen = 10, --- Time out on key codes
          foldlevel = 99,
        },
        g = {
          -- vim.g.autoformat,
          autoformat = false,
        },
      },
      signs = {
        BqfSign = { text = " " .. require("astroui").get_icon "Selected", texthl = "BqfSign" },
      },
      autocmds = {
        auto_spell = {
          {
            event = "FileType",
            desc = "Enable wrap and spell for text like documents",
            pattern = { "gitcommit", "markdown", "text", "plaintex" },
            callback = function()
              vim.opt_local.wrap = true
              vim.opt_local.spell = true
              vim.opt_local.spelllang = "de,en"
            end,
          },
        },
        autohide_tabline = {
          {
            event = "User",
            desc = "Auto hide tabline",
            pattern = "AstroBufsUpdated",
            callback = function()
              local new_showtabline = #vim.t.bufs > 1 and 2 or 1
              if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
            end,
          },
        },
        auto_term = {
          {
            event = "FileType",
            desc = "Close",
            pattern = { 'term'},
            callback = function()
              vim.keymap.set("n", "q", "<cmd>close<CR>", { expr = false, noremap = true, buffer = true, desc = "Close" })

              -- vim.keymap.set("i", "<c-q>", "<esc><cmd>quit!<CR>", { expr = true, noremap = true, buffer = true, desc = "Close terminal" })
              -- vim.keymap.set("n", "<c-q>", "<cmd>quit!<CR>", { expr = true, noremap = true, buffer = true, desc = "Close terminal" })
              -- vim.keymap.set("n", "C", "<cmd>bd!<CR>", { expr = false, noremap = true, buffer = true, desc = "Terminate" })
            end,
          },
        },
        auto_close = {
          {
            event = "FileType",
            desc = "Close",
            pattern = { "fugitiveblame",  "toggleterm", "qf", "help", "man", "lspinfo", ''}, -- , 'term'
            callback = function()
              vim.keymap.set("n", "q", "<cmd>quit!<CR>", { expr = false, noremap = true, buffer = true, desc = "Close" })
              -- vim.keymap.set("n", "<esc>", "<cmd>quit<CR>", { expr = false, noremap = true, buffer = true, desc = "Close terminal" })

              vim.keymap.set("i", "<c-q>", "<esc><cmd>quit!<CR>", { expr = true, noremap = true, buffer = true, desc = "Close terminal" })
              vim.keymap.set("n", "<c-q>", "<cmd>quit!<CR>", { expr = true, noremap = true, buffer = true, desc = "Close terminal" })
              vim.keymap.set("n", "C", "<cmd>bd!<CR>", { expr = false, noremap = true, buffer = true, desc = "Terminate" })
            end,
          },
        },
        auto_org_files = {
          {
            event = "FileType",
            desc = "Orgmode settings",
            pattern = "org",
            callback = function()
              -- vim.keymap.set("n", "i", "", { expr = true, noremap = true, desc = "Insert" })
            end,
          },
        },
        sync_term_background = {
          {
            event = { "UIEnter", "User" },
            desc = "Set background of terminal automatically",
            callback = function(args)
              if args.event == "UIEnter" or args.match == "AstroColorScheme" then
                local bg = vim.tbl_get(require("astroui").get_hlgroup "Normal", "bg")
                if bg then io.write(string.format("\027]11;#%06x\027\\", bg)) end
              end
            end,
          },
          {
            event = "UILeave",
            desc = "Restore terminal background when leaving",
            callback = function() io.write "\027]111\027\\" end,
          },
        },
      },
      diagnostics = {
        update_in_insert = false,
        virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
      },
      filetypes = {
        extension = {
          mdx = "markdown.mdx",
          qmd = "markdown",
          yaml = yaml_ft,
          yml = yaml_ft,
        },
        filename = {
          ["docker-compose.yaml"] = "yaml.docker-compose",
          ["docker-compose.yml"] = "yaml.docker-compose",
        },
        pattern = {
          ["%.env%.[%w_.-]+"] = "sh",
          [".*%.pkr%.hcl"] = "hcl.packer",
          [".*/kitty/.+%.conf"] = "bash",
          ["/tmp/neomutt.*"] = "markdown",
        },
      },
      mappings = {
        n = {
          -- disable default bindings
          ["sa"] = false,
          ["q"] = false,
          ["<leader>o"] = false,
          ["<Leader>ot"] = false,
          ["<Leader>oT"] = false,

          ["<C-Q>"] = false,
          ["<C-S>"] = false,
          ["q:"] = ":",
          ["c:"] = "q:",
          ["X"] = ":x<CR>",
          -- better buffer navigation
          ["]b"] = false,
          ["[b"] = false,
          ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          -- better search
          -- better increment/decrement
          ["-"] = { "<C-x>", desc = "Descrement number" },
          ["+"] = { "<C-a>", desc = "Increment number" },
          ["<Leader>n"] = { "<Cmd>enew<CR>", desc = "New File" },
          ["<Leader>N"] = { "<Cmd>tabnew<CR>", desc = "New Tab" },
          ["<Leader><CR>"] = { '<Esc>/<++><CR>"_c4l', desc = "Next Template" },
          ["<Leader>."] = { "<Cmd>cd %:p:h<CR>", desc = "Set CWD" },
          -- Telekasten:
          ["<c-space>"] = { "<cmd>lua require('telekasten').toggle_todo()<CR>", desc = "Toggle checkbox" },
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
                require("astrocore").toggle_term_cmd { cmd = "ipython --pylab -i --no-autoindent", direction = "float",
                  count=term_count}  -- , size=80 width=vim.o.columns * 0.3
              end

            end,
            desc = "ToggleTerm ipython",
          },
          ["<Leader>tp"] = {"<cmd>IronRepl<CR>", desc = "Open Iron repl vsplit", },
          ["<Leader>uo"] = { "<c-w>o", desc = "Only this window" },
          ["<Leader>uv"] = { "<cmd>vert split<CR>", desc = "Vertical split" },

          -- python = { repl = "ipython", exe_file_terminal = "ipython", exe_file_opt = "--pylab -i", exe_cmd = [[\%run]] },
          -- maps.n["<leader>tp"] = { function() require('user.toggleterm').create_toggle_term({cmd=python, direction='vertical'}, py_term_num) end }

          ["<C-s>"] = { ":w!<CR>", desc = "Save" },
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
          ["<C-S>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature Help" },
          ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },

          -- saving
          ["<C-s>"] = { "<ESC>:w!<CR>a", desc = "Save" },
          -- date/time input
          ["<F4>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', desc = "Time stamp" },
        },
        -- terminal mappings
        t = {
          ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
          ["<C-n>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
          ["<C-q>"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },
          ["<C-d>"] = { "<C-\\><C-n>:bd!<CR>", desc = "Terminal delete" },
          ["<Esc>q"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },
          -- ["<Esc><Esc>"] = { "<C-\\><C-n><CR>", desc = "Terminal quit" },
          ["<C-BS>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
        },
        v = {
          ["sa"] = false,
          -- Telekasten:
          ["<c-space>"] = { "<cmd>lua require('telekasten').toggle_todo({v=true})<CR>", desc = "Toggle checkbox" },
        },
        x = {
          ["sa"] = false,
          ["<C-S>"] = false,
          -- better increment/decrement
          ["+"] = { "g<C-a>", desc = "Increment number" },
          ["-"] = { "g<C-x>", desc = "Descrement number" },
        },
        ia = vim.fn.has "nvim-0.10" == 1 and {
          mktmpl = { function() return "<++>" end, desc = "Insert <++>", expr = true },
          ldate = { function() return os.date "%Y/%m/%d %H:%M:%S -" end, desc = "Y/m/d H:M:S -", expr = true },
          ndate = { function() return os.date "%Y-%m-%d" end, desc = "Y-m-d", expr = true },
          xdate = { function() return os.date "%m/%d/%y" end, desc = "m/d/y", expr = true },
          fdate = { function() return os.date "%B %d, %Y" end, desc = "B d, Y", expr = true },
          Xdate = { function() return os.date "%H:%M" end, desc = "H:M", expr = true },
          Fdate = { function() return os.date "%H:%M:%S" end, desc = "H:M:S", expr = true },
        } or nil,
      },
    } --[[@as AstroCoreOpts]]) --[[@as AstroCoreOpts]]

    local maps = opts.mappings
    ---@cast maps -nil

    -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
    maps.n.n = { "'Nn'[v:searchforward].'zv'", expr = true, desc = "Next Search Result" }
    maps.x.n = { "'Nn'[v:searchforward]", expr = true, desc = "Next Search Result" }
    maps.o.n = { "'Nn'[v:searchforward]", expr = true, desc = "Next Search Result" }
    maps.n.N = { "'nN'[v:searchforward].'zv'", expr = true, desc = "Prev Search Result" }
    maps.x.N = { "'nN'[v:searchforward]", expr = true, desc = "Prev Search Result" }
    maps.o.N = { "'nN'[v:searchforward]", expr = true, desc = "Prev Search Result" }

    -- add line text object
    for lhs, rhs in pairs {
      il = { ":<C-u>normal! $v^<CR>", desc = "inside line" },
      al = { ":<C-u>normal! V<CR>", desc = "around line" },
    } do
      maps.o[lhs] = rhs
      maps.x[lhs] = rhs
    end

    -- add missing in between and around two character pairs
    for _, char in ipairs { "_", "-", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
      for lhs, rhs in pairs {
        ["i" .. char] = { (":<C-u>silent! normal! f%sF%slvt%s<CR>"):format(char, char, char), desc = "inside " .. char },
        ["a" .. char] = { (":<C-u>silent! normal! f%sF%svf%s<CR>"):format(char, char, char), desc = "around " .. char },
      } do
        maps.o[lhs] = rhs
        maps.x[lhs] = rhs
      end
    end

    return opts
  end,
}
