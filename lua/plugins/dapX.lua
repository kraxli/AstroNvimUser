local r_exe
if vim.fn.has "win64" == 1 then
  r_exe = "R.exe"
else
  r_exe = "R"
end

return {
  "mfussenegger/nvim-dap",
  -- recommended = true,
  --
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        -- local get_icon = require("astroui").get_icon
        local maps = opts.mappings
        -- {
        --   "F8",
        --   function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
        --   desc = "Breakpoint Condition",
        -- },
        maps.n["<F8>"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" }
        maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
        maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
        maps.n["<F7>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
        maps.n["<S-F5>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
        maps.n["<C-F5>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5

        maps.n["<F9>"] = {
          function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
              if condition then require("dap").set_breakpoint(condition) end
            end)
          end,
          desc = "Conditional Breakpoint (S-F9)",
        }
        maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
        maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
        maps.n["<F12>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11,
      end,
    },
  },
  config = function()
    -- see: https://github.com/mfussenegger/nvim-dap/discussions/1274
    --      https://manuelhentschel.github.io/vscDebugger/
    local dap = require "dap"
    dap.adapters.r = {
      type = "server",
      port = "18721",
      name = "R",
      executable = {
        command = r_exe,
        args = { "--slave", "-e", "vscDebugger::.vsc.listenForDAP()" },
        -- args = { "--slave", "-e", "vscDebugger::.vsc.listen()" },
      },
    }
    dap.configurations.r = {
      {
        type = "r",
        name = "Debug R-File",
        request = "attach",
        debugMode = "file",
        stopOnEntry = false,
        enableVariablesPanel = true,
        -- request = "launch",
        -- program = "${file}", -- This configuration will launch the current file if used.
      },
    }
  end,
}
