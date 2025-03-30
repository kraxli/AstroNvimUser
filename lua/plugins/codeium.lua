return {
  "monkoose/neocodeium",
  cmd = "NeoCodeium",
  enabled = vim.fn.has("unix") == 1,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>u!"] = { function() require("neocodeium.commands").toggle() end, desc = "Toggle AI assistant" }
        maps.n["<M-CR>"] = { function() require("neocodeium").chat() end }
        maps.i["<M-]>"] = { function() require("neocodeium").cycle_or_complete() end }
        maps.i["<M-\\>"] = maps.i["<M-]>"]
        maps.i["<M-[>"] = { function() require("neocodeium").cycle_or_complete(-1) end }
        maps.i["<M-CR>"] = { function() require("neocodeium").accept() end }
        maps.i["<M-BS>"] = { function() require("neocodeium").clear() end }

        maps.i["<M-Up>"] = maps.i["<M-[>"]
        maps.i["<M-Down>"] = maps.i["<M-]>"]
        maps.i["<M-z>"] = maps.i["<M-]>"]
        maps.i["<M-x>"] = maps.i["<M-[>"]
        maps.i["<M-c>"] = maps.i["<M-BS>"]

        maps.n["<Leader>;"] = {
          function()
            if vim.g.codeium_enabled == true then
              -- vim.cmd "NeoCodeium disable_buffer"
              require("neocodeium.commands").disable_buffer()
            else
              -- vim.cmd "NeoCodeium toggle_buffer"
              require("neocodeium.commands").toggle_buffer()
              -- require("neocodeium.commands").enable_buffer()
            end
          end,
          silent = true,
          desc = "Codeium toggle",
        }

        opts.autocmds.codeium = {
          {
            event = "User",
            pattern = "NeoCodeiumCompletionDisplayed",
            callback = function() require("cmp").abort() end,
          },
        }
      end,
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require "astroui.status"

        table.insert(
          opts.statusline,
          10,
          status.component.builder {
            {
              provider = function()
                local aistatus, serverstatus = require("neocodeium").get_status()
                return status.utils.stylize(
                  (aistatus ~= 0 and (aistatus == 1 and "󱚧" or "󱙻")) or (serverstatus == 0 and "󰚩" or "󱚢"),
                  { padding = { right = 1 } }
                )
              end,
            },
            hl = { fg = "git_branch_fg" },
            update = { "BufEnter", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
            init = status.init.update_events {
              {
                "User",
                pattern = { "NeoCodeiumServer*", "NeoCodeium*{En,Dis}abled" },
                callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
              },
            },
            surround = {
              separator = "right",
              color = "section_bg",
              condition = function()
                local enabled = vim.g.neocodeium_enabled
                if enabled ~= false and vim.b.neocodeium_enabled ~= nil then enabled = vim.b.neocodeium_enabled end
                return enabled
              end,
            },
          }
        )
      end,
    },
  },
  opts = {
    enabled = false,
    manual = true,
    silent = true,
    filetypes = {
      snacks_picker_input = false,
      TelescopePrompt = false,
      ["dap-repl"] = false,
    },
  },
}
