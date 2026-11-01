local prefix = "<Leader>a"

---@type LazySpec
return {
  "folke/sidekick.nvim",
  ---@type sidekick.Config
  opts = {
    nes = {
      enabled = false,
      debounce = 200,
      diff = {
        inline = "words",
        show = "always",
      },
      signs = true,
      jumplist = true,
    },
    cli = {
      watch = true,
      mux = {
        -- backend = "tmux",
        enabled = true,
      },
      tools = {
        claude = {
          cmd = { "claude" },
        },
        gemini = {
          cmd = { "gemini" },
        },
        antigravity = {
          cmd = { "agy" },
          is_proc = "\\<agy\\>",
          url = "https://github.com/google-gemini/antigravity",
          resume = { "--continue" },
          continue = { "--continue" },
          format = function(text)
            require("sidekick.text").transform(
              text,
              function(str) return str:gsub("([^%w/_%.%-])", "\\%1") end,
              "SidekickLocFile"
            )
          end,
        },
        agy = {
          cmd = { "agy" },
          is_proc = "\\<agy\\>",
          url = "https://github.com/google-gemini/antigravity",
          resume = { "--continue" },
          continue = { "--continue" },
          format = function(text)
            require("sidekick.text").transform(
              text,
              function(str) return str:gsub("([^%w/_%.%-])", "\\%1") end,
              "SidekickLocFile"
            )
          end,
        },
        copilot = {
          cmd = { "copilot", "--banner", "--allow-tool", "write" },
        },
      },
    },
  },

  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        -- options = { },
        -- autocmds = {
        -- auto_sidekick = {
        --   {
        --     event = "FileType",
        --     desc = "Ensure Copilot LSP is registered and enabled for sidekick NES",
        --     callback = function()
        --       if vim.lsp.config and not (vim.lsp.config._configs and vim.lsp.config._configs["copilot"]) then
        --         pcall(vim.lsp.config, "copilot", {})
        --       end
        --       if not vim.lsp.is_enabled "copilot" then
        --         vim.lsp.enable("copilot", true)
        --       end
        --     end,
        --   },
        -- },
        -- },
        mappings = {
          n = {
            -- Quick AI CLI Toggles
            [prefix .. "<CR>"] = {
              function() require("sidekick.cli").toggle { name = "gemini", focus = true } end,
              desc = "Toggle Gemini",
            },
            [prefix .. "g"] = {
              function() require("sidekick.cli").toggle { name = "gemini", focus = true } end,
              desc = "Toggle Gemini",
            },
            [prefix .. "c"] = {
              function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
              desc = "Toggle Claude",
            },
            [prefix .. "A"] = {
              function() require("sidekick.cli").toggle { name = "antigravity", focus = true } end,
              desc = "Toggle Antigravity (agy)",
            },
            [prefix .. "C"] = {
              function() require("sidekick.cli").toggle { name = "copilot", focus = true } end,
              desc = "Toggle Copilot CLI",
            },
            [prefix .. "a"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
            --   -- Next Edit Suggestions (NES) Controls
            --   [prefix .. "n"] = {
            --     function() require("sidekick").nes_jump_or_apply() end,
            --     desc = "Jump or Apply Next Edit (NES)",
            --   },
            --   [prefix .. "u"] = {
            --     function() require("sidekick.nes").update() end,
            --     desc = "Update/Fetch NES suggestions",
            --   },
            --   [prefix .. "x"] = {
            --     function() require("sidekick.nes").clear() end,
            --     desc = "Clear/Dismiss NES suggestions",
            --   },
            --   [prefix .. "N"] = {
            --     function() require("sidekick.nes").toggle() end,
            --     desc = "Toggle NES enabled/disabled",
            --   },
            --   -- Fast NES Jump/Apply in Normal Mode
            --   ["<M-down>"] = {
            --     function() require("sidekick").nes_jump_or_apply() end,
            --     desc = "Jump or Apply Next Edit",
            --   },
            --   ["<M-right>"] = {
            --     function() require("sidekick").nes_jump_or_apply() end,
            --     desc = "Jump or Apply Next Edit",
            --   },
            --   ["<M-j>"] = {
            --     function() require("sidekick").nes_jump_or_apply() end,
            --     desc = "Jump or Apply Next Edit",
            --   },
            --   ["<C-right>"] = {
            --     function() require("sidekick").nes_jump_or_apply() end,
            --     desc = "Jump or Apply Next Edit",
            --   },
            -- },
            i = {
              -- ["<M-CR>"] = {
              --   function()
              --     if require("sidekick").nes_jump_or_apply() then return end
              --     if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then return end
              --     return "<C-CR>"
              --   end,
              --   expr = true,
              --   desc = "Accept NES or inline completion",
              -- },
              -- ["<M-down>"] = {
              --   function() require("sidekick").nes_jump_or_apply() end,
              --   desc = "Jump or Apply Next Edit",
              -- },
              -- ["<M-right>"] = {
              --   function() require("sidekick").nes_jump_or_apply() end,
              --   desc = "Jump or Apply Next Edit",
              -- },
              -- ["<M-j>"] = {
              --   function() require("sidekick").nes_jump_or_apply() end,
              --   desc = "Jump or Apply Next Edit",
              -- },
              -- ["<C-right>"] = {
              --   function() require("sidekick").nes_jump_or_apply() end,
              --   desc = "Jump or Apply Next Edit",
              -- },
              -- ["<M-u>"] = {
              --   function() require("sidekick.nes").update() end,
              --   desc = "Update NES suggestions",
              -- },
              -- ["<M-BS>"] = {
              --   function() require("sidekick.nes").clear() end,
              --   desc = "Clear NES suggestions",
              -- },
              -- },
            },
          },
        },
      },
      -- {
      --   "saghen/blink.cmp",
      --   optional = true,
      --   opts = function(_, opts)
      --     opts.keymap = opts.keymap or {}
      --     local prev_tab = opts.keymap["<Tab>"] or { "snippet_forward", "fallback" }
      --     if type(prev_tab) ~= "table" then prev_tab = { prev_tab } end
      --
      --     local nes_accept = function()
      --       if require("sidekick").nes_jump_or_apply() then
      --         return true
      --       end
      --     end
      --
      --     opts.keymap["<Tab>"] = vim.list_extend({ nes_accept }, prev_tab)
      --   end,
      -- },
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = function(_, opts)
          opts.features = opts.features or {}
          opts.servers = opts.servers or {}
          if not vim.tbl_contains(opts.servers, "copilot") then table.insert(opts.servers, "copilot") end
          opts.handlers = opts.handlers or {}
          opts.handlers.copilot = function(server) vim.lsp.enable(server, true) end
        end,
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          if not vim.tbl_contains(opts.ensure_installed, "copilot-language-server") then
            table.insert(opts.ensure_installed, "copilot-language-server")
          end
        end,
      },
    },
  },
}
