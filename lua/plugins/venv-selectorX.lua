---@type LazySpec

local prefix = "<leader>v"

return {
  "linux-cultist/venv-selector.nvim",
  -- branch = "regexp",

  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { desc = "Venv & Uv" },
            [prefix .. "v"] = { "<Cmd>VenvSelect<CR>", desc = "Activate virtual environment" },
          },
        },
      },
    },
  },
}
