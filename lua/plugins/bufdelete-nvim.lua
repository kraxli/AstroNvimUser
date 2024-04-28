return {
  "famiu/bufdelete.nvim",
  cmd = {"Bdelete"},
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["q"] = { "<cmd>w!|Bdelete!<cr>", noremap = false, desc = "Delete buffer" },
        },
      },
    },
  },
}
