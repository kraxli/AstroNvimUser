local prefix = "<Leader>m"
---@type LazySpec
return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
  opts = {
    setup = {
      task_list = {
        strategy = "toggleterm",
        bindings = {
          ["<C-L>"] = false,
          ["<C-H>"] = false,
          ["<C-K>"] = false,
          ["<C-J>"] = false,
          q = "<Cmd>close<CR>",
          K = "IncreaseDetail",
          J = "DecreaseDetail",
          ["<C-P>"] = "ScrollOutputUp",
          ["<C-N>"] = "ScrollOutputDown",
        },
      },
    },
    templates = {
      {
        name = "compile with compiler",
        builder = function() return { cmd = { "compiler" }, args = { vim.fn.expand "%:p" } } end,
      },
      {
        name = "view file output",
        builder = function() return { cmd = { "opout" }, args = { vim.fn.expand "%:p" } } end,
      },
      {
        name = "present with pdfpc",
        builder = function() return { cmd = { "pdfpc" }, args = { vim.fn.expand "%:r" .. ".pdf" } } end,
        condition = { callback = function() return vim.fn.filereadable(vim.fn.expand "%:r" .. ".pdf") == 1 end },
      },
      {
        name = "g++ build",
        builder = function()
          -- Full path to current file (see :help expand())
          local file = vim.fn.expand("%:p")
          local file_out = vim.fn.expand("%:p:r") 
          return {
            cmd = { "g++"},
            args = { file },
            -- args = { file,  ' -o ' .. file_out .. '.out'},
            components = { { "on_output_quickfix", open = true }, "default" },
          }
        end,
        condition = {
          filetype = { "cpp" },
        },
      },
      {
        name = "run script",
        builder = function()
          local file = vim.fn.expand("%:p")
          local cmd = { file }
          if vim.bo.filetype == "go" then
            cmd = { "go", "run", file }
          end
          return {
            cmd = cmd,
            components = {
              { "on_output_quickfix", set_diagnostics = true },
              "on_result_diagnostics",
              "default",
            },
          }
        end,
        condition = {
          filetype = { "sh", "python", "go" },
        },
      },
    },
  },
  config = function(_, opts)
    require("overseer").setup(opts.setup)
    vim.tbl_map(require("overseer").register_template, opts.templates)
  end,
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { overseer = true } },
    },
    {
      "AstroNvim/astrocore",
      opts = {
        commands = {
          OverseerWatchRun = {
            function()
              local overseer = require("overseer")
              overseer.run_template({ name = "run script" }, function(task)
                if task then
                  task:add_component({ "restart_on_save", paths = {vim.fn.expand("%:p")} })
                  local main_win = vim.api.nvim_get_current_win()
                  overseer.run_action(task, "open vsplit")
                  vim.api.nvim_set_current_win(main_win)
                else
                  vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
                end
              end)
            end
          },
          AutoCompile = {
            function()
              require("overseer").run_template({ name = "compile with compiler" }, function(task)
                if task then
                  task:add_component { "restart_on_save", paths = { vim.fn.expand "%:p" } }
                else
                  vim.notify("Error setting up auto compilation", vim.log.levels.ERROR)
                end
              end)
            end,
            desc = "Automatically compile the current file with `compiler` on save",
          },
          Compile = {
            function() require("overseer").run_template { name = "compile with compiler" } end,
            desc = "Compile the current file with `compiler`",
          },
          OpOut = {
            function() require("overseer").run_template { name = "view file output" } end,
            desc = "View the current file ouptut with `opout`",
          },
          Present = {
            function()
              require("overseer").run_template({ name = "present with pdfpc" }, function(task)
                if not task then vim.notify("Unable to start presentation", vim.log.levels.ERROR) end
              end)
            end,
            desc = "Present the current file with `pdfpc`",
          },
        },
        mappings = {
          n = {
            [prefix] = { desc = " Overseer" },
            [prefix .. "a"] = { "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" },
            [prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Overseer Info" },
            [prefix .. "k"] = { "<Cmd>Compile<CR>", desc = "Compile" },
            [prefix .. "K"] = { "<Cmd>AutoCompile<CR>", desc = "Auto Compile" },
            [prefix .. "<CR>"] = { "<Cmd>OverseerToggle<CR>", desc = "Overseer" },
            [prefix .. "p"] = { "<Cmd>Present<CR>", desc = "Present file output" },
            [prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Run" },
            [prefix .. "v"] = { "<Cmd>OpOut<CR>", desc = "View Output" },
          },
        },
      },
    },
  },
}
