-- Notes:
--    DAP-log: ~/.cache/nvim/dap.log
--    Install R debugger: https://manuelhentschel.github.io/vscDebugger/
--    https://github.com/R-nvim/R.nvim/discussions/166
--    https://docs.astronvim.com/recipes/dap/#automatically-install-debuggers

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"

    -------------------------------------------------------
    -- R
    -------------------------------------------------------
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
        request = "attach",  -- launch
        -- program = "${file}",
        name = "Attach R-file",  -- Attach session
        debugMode = "file",
        stopOnEntry = false,
      },
    }

    -------------------------------------------------------
    -- Python
    -------------------------------------------------------
    dap.adapters.python = {
      type = "executable",
      -- command = "path/to/virtualenvs/debugpy/bin/python",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        name = "Python: Current file",
        request = "launch",
        console = "externalTerminal",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "/usr/bin/python"
          end
        end,
      },
    }
  end,
}
