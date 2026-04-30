return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
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
      auto_term_enter_cmd = {
        {
          event = { "BufWinEnter", "WinEnter", "TermOpen" },
          desc = "Enter terminal",
          pattern = { "term://*" },
          command = "startinsert",
          -- see: https://vi.stackexchange.com/a/3765
        },
      },
      auto_bufdelete = {
        {
          event = { "BufWinEnter" },
          desc = "Close",
          pattern = { "*" },
          callback = function()
            if
              vim.bo.buftype ~= "terminal"
              and vim.bo.buftype ~= "term"
              and vim.bo.buftype ~= "prompt"
              and vim.bo.filetype ~= "TelescopePrompt"
              and vim.bo.filetype ~= ""
              and vim.bo.buftype ~= "nofile"
            then
              vim.keymap.set(
                "n",
                "q",
                "<cmd>lua require('astrocore.buffer').close(0)<CR>",
                { noremap = true, buffer = true, desc = "Delete buffer" }
              )
            elseif vim.bo.filetype == "" and vim.bo.buftype == "" then -- close empty buffers
              vim.keymap.set(
                "n",
                "q",
                "<cmd>lua require('astrocore.buffer').close(0)<CR>",
                { noremap = true, buffer = true, desc = "Delete buffer" }
              )
              -- else
              -- for R Object_browser
              -- elseif (vim.bo.filetype == '' and vim.bo.buftype == 'nofile') then
              -- vim.keymap.set( "n", "q", "<cmd>quit!<CR>", { expr = false, noremap = true, buffer = true, desc = "Close" }) -- close!
            end
          end,
        },
      },
      auto_term_filetype_close = {
        {
          event = { "FileType" },
          desc = "Terminal keymaps",
          pattern = {
            "fugitiveblame",
            "toggleterm",
            "qf",
            "help",
            "man",
            "lspinfo",
            "nofile",
            "term",
            "rdoc",
            "TelescopePrompt",
            "",
          },
          callback = function()
            -- Notice that buffer = 0 sets this keymap only for current buffer. So when you live the terminal you will not have those keymaps.
            -- Should be the same
            vim.keymap.set("n", "q", "<cmd>quit!<CR>", { expr = false, noremap = true, buffer = true, desc = "Close" }) -- close!
            vim.keymap.set(
              "i",
              "<c-q>",
              "<esc><cmd>quit!<CR>",
              { expr = true, noremap = true, buffer = true, desc = "Close terminal" }
            )
            vim.keymap.set(
              "n",
              "<c-q>",
              "<cmd>quit!<CR>",
              { expr = true, noremap = true, buffer = true, desc = "Close terminal" }
            )
            vim.keymap.set(
              "n",
              "C",
              "<cmd>bd!<CR>",
              { expr = false, noremap = true, buffer = true, desc = "Terminate" }
            )
            vim.keymap.set(
              "n",
              "<c-Q>",
              "<cmd>bd!<CR>",
              { expr = true, noremap = true, buffer = true, desc = "Close terminal" }
            )
            vim.keymap.set(
              "i",
              "<c-Q>",
              "<cmd>bd!<CR>",
              { expr = true, noremap = true, buffer = true, desc = "Close terminal" }
            )
          end,
        },
      },
      auto_org_files = {
        {
          event = "FileType",
          desc = "Orgmode settings",
          pattern = "org",
          callback = function() end,
        },
      },
      auto_clean_cache = {
        {
          event = { "TermClose" }, -- TermLeave (triggers already when entering command line)
          desc = "Clear toggleterm visidata cache",
          callback = function()
            -- the directory variable is defined in: ~/.config/nvim/lua/global_vars.lua
            if vim.fn.has "unix" then
              os.execute("rm -rf " .. dir_vd_temp .. "*")
            else
              -- https://superuser.com/questions/741945/delete-all-files-from-a-folder-and-its-sub-folders
              os.execute('Remove-Item -Path "' .. dir_vd_temp .. '*.*" -recurse -Force')
            end
          end,
        },
      },
      auto_text_files = {
        {
          event = "FileType",
          desc = "Markdown-, text-, tex-file autocmds",
          pattern = { "markdown", "tex", "text", "org", "norg", "Avante" },
          callback = function()
            vim.api.nvim_buf_create_user_command(0, "Pandoc2Docx", ":lua require('utils').pandoc2('docx')", {})
            vim.api.nvim_buf_create_user_command(0, "Pandoc2Html", ":lua require('utils').pandoc2('html')", {})
            vim.api.nvim_buf_create_user_command(0, "Pandoc2Pdf", ":lua require('utils').pandoc2('pdf')", {})

            vim.keymap.set(
              "n",
              "<leader>zh",
              "<cmd>call Header_promote()<CR>",
              { noremap = true, buffer = true, desc = "Header promote" }
            )
            vim.keymap.set(
              "n",
              "<leader>zH",
              "<cmd>call Header_demote()<CR>",
              { noremap = true, buffer = true, desc = "Header demote" }
            )

            -- TODO: mini.snippets equivalent to the below is missing:
            -- vim.keymap.set("i", "<C-l>", function() require("luasnip").snip_expand(require("keymap_snippets")["link2"]) end)
          end,
        },
      },
      auto_diagnostics = {
        {
          event = { "BufWinEnter" }, -- "BufRead"
          pattern = { "*" },
          desc = "diagnostics",
          callback = function()
            local filetypes = { "markdown", "org", "norg", "tex", "text" }
            for _, ft in pairs(filetypes) do
              vim.diagnostic.enable(vim.bo.filetype ~= ft)
              if vim.bo.filetype == ft then break end
            end
            -- vim.diagnostic.config({ virtual_text={ current_line=true }, })  -- virtual_text=false,
            -- vim.diagnostic.config({ virtual_lines={ current_line=true },})
          end,
        },
      },
      auto_neo_tree = {
        {
          event = { "FileType" },
          pattern = "neo-tree",
          callback = function()
            -- local state = require("neo-tree.sources.manager").get_state("filesystem", nil, nil)
            -- state.commands.order_by_modified(state)
          end,
        },
      },
    },
  },
}
