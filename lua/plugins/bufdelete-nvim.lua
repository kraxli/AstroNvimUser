return {
  "famiu/bufdelete.nvim",
  cmd = { "Bdelete" },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["q"] = { "<cmd>w!|Bdelete!<cr>", noremap = false, desc = "Delete buffer" },
        },
      },
    },
  },
}
