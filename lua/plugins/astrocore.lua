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

---@type AstroCoreOpts
local opts = {
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
      timeoutlen = 150, --- Time out on mappings
      ttimeoutlen = 10, --- Time out on key codes
    },
    g = {
      -- vim.g.autoformat,
      autoformat = false,
    },
  },
  autocmds = {
    auto_close = {
      event = "FileType",
      desc = "Close terminal alike pop-ups",
      pattern = { "toggleterm", "qf", "help", "man", "lspinfo" },
      callback = function()
        -- vim.keymap.set("n", "q", "<cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
        vim.keymap.set("n", "<c-q>", "<cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
        vim.keymap.set("i", "<c-q>", "<esc><cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
        vim.keymap.set("n", "<c-c>", "<cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
        vim.keymap.set("i", "<c-c>", "<esc><cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
        -- autocmd FileType toggleterm,qf,help,man,lspinfo nnoremap <silent><buffer> q :close!<CR>  " ,TelescopePrompt
      end,
    },
    auto_spell = {
      {
        event = "FileType",
        desc = "Enable wrap and spell for text like documents",
        pattern = { "gitcommit", "markdown", "text", "plaintex", "telekasten" },
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
    -- auto_markdown = {
    --   event = "FileType",
    --   desc = "Markdown autocommands",
    --   pattern = { "markdown", "text" },
    --   callback = function()
    --     -- vim.keymap.set("i", "<CR>", "<esc>o<cmd>AutolistNewBullet<cr>")
    --   end,
    -- },
  },
  diagnostics = { update_in_insert = false },
  filetypes = {
    extension = {
      mdx = "markdown.mdx",
      qmd = "markdown",
      yml = yaml_ft,
      yaml = yaml_ft,
    },
    pattern = {
      ["/tmp/neomutt.*"] = "markdown",
    },
  },
  mappings = {
    n = {
      -- disable default bindings
      ["q"] = false,
      ["<leader>o"] = false,

      ["<C-Q>"] = false,
      ["<C-S>"] = false,
      ["q:"] = ":",
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
      -- replace default map for "<leader>o" to use "<leader>o" for orgmode
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
      ["<Leader>tp"] = {
        function()
          local ipython = vim.fn.executable "ipython" == 1 and "ipython"
            or vim.fn.executable "ipython3" == 1 and "ipython3"
          if ipython then require("astrocore").toggle_term_cmd(ipython) end
        end,
        desc = "ToggleTerm ipython",
      },
      ["<Leader>tP"] = {
        function()
          local ipython = vim.fn.executable "ipython" == 1 and "ipython"
            or vim.fn.executable "ipython3" == 1 and "ipython3"
          if ipython then require("astrocore").toggle_term_cmd({cmd='ipython --pylab -i', direction='vertical'}) end
          -- { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
        end,
        desc = "ToggleTerm ipython vsplit",
      },
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
      ["<C-S>"] = false,
      ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },

      -- saving
      ["<C-s>"] = { "<ESC>:w!<CR>a", desc = "Save" },
      -- date/time input
      ["<F4>"] = { '<C-R>=strftime("%Y-%m-%d")<CR>', desc = "Time stamp" },
    },
    -- terminal mappings
    t = {
      ["<C-BS>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
      ["<Esc><Esc>"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },

      ["<C-n>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
      ["<ESC>q"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },
      ["<C-q>"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },
      ["<ESC>k"] = { "<C-\\><C-n>:bd!<CR>", desc = "Terminal kill/delete" },
      ["<ESC>d"] = { "<C-\\><C-n>:bd!<CR>", desc = "Terminal kill/delete" },
    },
    x = {
      ["<C-S>"] = false,
      -- better increment/decrement
      ["+"] = { "g<C-a>", desc = "Increment number" },
      ["-"] = { "g<C-x>", desc = "Descrement number" },
      -- line text-objects
      ["iL"] = { ":<C-u>normal! $v^<CR>", desc = "Inside line text object" },
      ["aL"] = { ":<C-u>normal! $v0<CR>", desc = "Around line text object" },
    },
    o = {
      -- line text-objects
      ["iL"] = { ":<C-u>normal! $v^<CR>", desc = "Inside line text object" },
      ["aL"] = { ":<C-u>normal! $v0<CR>", desc = "Around line text object" },
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
}

local function better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astrocore").notify(error, vim.log.levels.ERROR) end
  end
end
opts.mappings.n.n = { better_search "n", desc = "Next search" }
opts.mappings.n.N = { better_search "N", desc = "Previous search" }

-- add line text object
for lhs, rhs in pairs {
  il = { ":<C-u>normal! $v^<CR>", desc = "inside line" },
  al = { ":<C-u>normal! V<CR>", desc = "around line" },
} do
  opts.mappings.o[lhs] = rhs
  opts.mappings.x[lhs] = rhs
end

-- add missing in between and arround two character pairs
for _, char in ipairs { "_", "-", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
  for lhs, rhs in pairs {
    ["i" .. char] = { (":<C-u>silent! normal! f%sF%slvt%s<CR>"):format(char, char, char), desc = "inside " .. char },
    ["a" .. char] = { (":<C-u>silent! normal! f%sF%svf%s<CR>"):format(char, char, char), desc = "around " .. char },
  } do
    opts.mappings.o[lhs] = rhs
    opts.mappings.x[lhs] = rhs
  end
end

---@type LazySpec
return { "AstroNvim/astrocore", opts = opts }
