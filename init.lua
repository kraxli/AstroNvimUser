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

-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Close terminal alike pop-ups",
--   group = vim.api.nvim_create_augroup("auto_close", { clear = true }),
--   pattern = { "toggleterm", "qf", "help", "man", "lspinfo" },
--   callback = function()
--     -- vim.keymap.set("n", "q", "<cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
--     vim.keymap.set("n", "q", "<cmd>close!<CR>", { expr = true, noremap = true, desc = "Close terminal" })
--     -- autocmd FileType toggleterm,qf,help,man,lspinfo nnoremap <silent><buffer> q :close!<CR>  " ,TelescopePrompt
--   end,
-- })
