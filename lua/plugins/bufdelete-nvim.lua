return {
  "famiu/bufdelete.nvim",
  cmd = { "Bdelete" },
  enabled = false,
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      ignore = {
        buftypes = { "terminal" },
        dirs = {},
        filetypes = {},
      },
      autocmds = {
        auto_bufdelete = {
          {
            event = "FileType",
            desc = "Close",
            pattern = { "*" },
            callback = function()
              if vim.bo.buftype ~= "terminal" or vim.bo.buftype ~= "term" then
                vim.keymap.set( "n", "q", "<cmd>w!|Bdelete!<CR>", {  noremap = true, buffer = true, desc = "Close terminal" })
                -- vim.keymap.set("n", "q", "<cmd>lua require('astrocore.buffer').close(0)<CR>", { noremap = true, buffer = true, desc = "Close terminal" })
              end
            end,
          },
        },
      },
    },
  },
}
