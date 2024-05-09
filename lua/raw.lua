local opts = { noremap = true, silent = true }

-- open system app for file under cursor or file explorer
vim.api.nvim_set_keymap("", "<F3>", [[<cmd>lua require('utils').sys_app_open()<CR>]], opts)

-- writer
vim.api.nvim_set_keymap("n", "<c-s-v>", "<cmd>PasteImg<cr>", { noremap = false })

vim.cmd [[
  " map ]z ]Sz=
  " map [z [Sz=
  map ]z ]S<space>fs
  map [z [S<space>fs

  imap jj <ESC>
  imap jk <ESC>

  vmap <c-c> y
  xmap <c-c> y
]]
