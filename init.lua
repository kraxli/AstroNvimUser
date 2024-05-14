-- bootstrap lazy.nvim, AstroNvim, and user plugins
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or vim.loop.fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"

-- kraxli: own setup:
pcall(require, "user.settings")
-- local dir_nvim_local =  os.getenv "XDG_CONFIG_HOME"
-- vim.opt.rtp:append(dir_nvim_local)
-- pcall(require, dir_nvim_local .. "/nvim-local.settings")
pcall(require, "raw")
