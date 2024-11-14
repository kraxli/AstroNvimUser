return {
  "famiu/bufdelete.nvim",
  cmd = { "Bdelete" },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      ignore = {
        buftypes = {'terminal'},
        dirs = {},
        filetypes = {},
      },
      mappings = {
        n = {
          ["q"] = { "<cmd>w!|Bdelete!<cr>", noremap = false, buffer = true, desc = "Delete buffer" },
        },
      },
    },
  },
}
