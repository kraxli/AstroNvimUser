return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      -- toggle if diagnostics are enabled on startup
      -- diagnostics = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
    },
    -- Configuration passed to `vim.diagnostic.config()`
    -- All available options can be found with `:h vim.diagnostic.Opts`
    diagnostics = {
      virtual_text = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.HINT },
        -- severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.INFO }, 
      },
      -- virtual_text = true,
      virtual_lines = false,
      -- virtual_lines = { current_line = true, severity = { min = vim.diagnostic.severity.WARN } },
      -- virtual_lines = { current_line = true, severity = { min = vim.diagnostic.severity.ERROR } },
      update_in_insert = false,
      underline = false,
      severity_sort = true,
    },
  },
}
