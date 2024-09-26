-- Notes:
--    DAP-log: ~/.cache/nvim/dap.log
--    Install R debugger: https://manuelhentschel.github.io/vscDebugger/
--    https://github.com/R-nvim/R.nvim/discussions/166
--    https://docs.astronvim.com/recipes/dap/#automatically-install-debuggers

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"

    dap.adapters.r = {
      type = "server",
      port = 18721, -- needs to match `debugadapter::run()`'s `port` argument
      executable = {
        command = "R",
        -- args = { "--slave", "-e", "debugadapter::run()" },
        -- args = { "--slave", "-e", "vscDebugger::.vsc.listen()" },  -- works; alternative is vscDebugger::.vsc.listenForDAP()
        args = { "--slave", "-e", "vscDebugger::.vsc.listenForDAP()" },
      },
    }

    dap.configurations.r = {
      {
        -- type = "R-Debugger",
        type = "r",
        request = "attach",
        -- name = "Attach session",
        name = "Attach R-file",
        debugMode = "file",
        stopOnEntry = false,
      },
    }
  end,
}
