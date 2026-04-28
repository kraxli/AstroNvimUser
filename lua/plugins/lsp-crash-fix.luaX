return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Neovim 0.11+ deprecates `require("lspconfig")` and prints an annoying 
      -- "stack traceback" warning for every single language server AstroNvim sets up.
      -- This silences ONLY that specific nvim-lspconfig deprecation warning.
      local orig_deprecate = vim.deprecate
      if orig_deprecate then
        vim.deprecate = function(name, alternative, version, plugin, backtrace)
          if plugin == "nvim-lspconfig" and name:match("lspconfig") then
            return -- Silence the warning
          end
          return orig_deprecate(name, alternative, version, plugin, backtrace)
        end
      end
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      -- We override the default handler to catch any real crashes from nvim-lspconfig
      -- when setting up removed or invalid servers (like tsserver).
      opts.handlers = {
        function(server, server_opts)
          local ok, err = pcall(function()
            require("lspconfig")[server].setup(server_opts)
          end)
          
          if not ok then
            vim.schedule(function()
              vim.notify(
                "AstroLSP ignored a crash setting up server: " .. server .. "\n" ..
                "Error: " .. tostring(err),
                vim.log.levels.WARN
              )
            end)
          end
        end
      }
    end,
  }
}
