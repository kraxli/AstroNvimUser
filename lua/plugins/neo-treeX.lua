local old_guicursor, old_cursor

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = {
      autocmds = {},
      mappings = {
        n = {
          ["<Leader>o"] = false,
          ["<Leader>E"] = {
            function()
              if vim.bo.filetype == "neo-tree" then
                vim.cmd.wincmd "p"
              else
                vim.cmd.Neotree "focus"
              end
            end,
            desc = "Toggle Explorer Focus",
          },
        },
      },
    },
  },
}
