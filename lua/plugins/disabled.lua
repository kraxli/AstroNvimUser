local disabled = {
  "jay-babu/mason-null-ls.nvim",
  "nvimtools/none-ls.nvim",
  "jpalardy/vim-slime",
  "klafyvel/vim-slime-cells",
}

return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, disabled)
