return {
  "Joakker/lua-json5",
  enabled = vim.fn.has("unix") == 1,
  lazy = true,
  build = vim.fn.has("win32") == 1 and "powershell ./install.ps1"
    or "./install.sh",
}
