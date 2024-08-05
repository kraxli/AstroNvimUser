local prefix = "<Leader>r"
return {
  "geg2102/nvim-python-repl",
  ft = { "python", "lua", "scala" },
  config = function()
    require("nvim-python-repl").setup {
      execute_on_send = true,
      vsplit = true,
    }
  end,
  dependencies = {
    { "nvim-treesitter" },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = {
        mappings = {
          n = {
            [ prefix ] = { desc = " Python REPL" },
            [ prefix .. 's' ] = {
              "<cmd>lua require('nvim-python-repl').send_statement_definition()<CR>",
              noremap = false,
              desc = "Send semantic unit to REPL",
            },
            [ prefix .. 'r' ] = {
              '<cmd>lua require("nvim-python-repl").open_repl()<CR>',
              noremap = false,
              desc = "Opens the REPL in a window split",
            },
            [ prefix .. 'b' ] = {
              "<cmd>lua require('nvim-python-repl').send_buffer_to_repl()<CR>",
              noremap = false,
              desc = "Send entire buffer to REPL",
            },
            [ prefix .. 't'] = { desc = " Python REPL toggle" },
            [ prefix .. 'te' ] = {
              "<cmd>lua require('nvim-python-repl').toggle_execute()<CR>",
              noremap = false,
              desc = "Toggle automatic command execution in REPL",
            },
            [ prefix .. 'tv' ] = {
              "<cmd>lua require('nvim-python-repl').toggle_vertical()<CR>",
              noremap = false,
              desc = "Toggle vertical REPL split or horizontal split",
            },
          },
          v = {
            [prefix] = { desc = " Python REPL" },
            [prefix .. "s"] = {"<cmd> lua require('nvim-python-repl').send_visual_to_repl()<CR>", noremap=false, desc="Send visual selection to REPL"},
            -- vim.keymap.set("v", "<leader>rs", function() require('nvim-python-repl').send_visual_to_repl() end, { desc = "Send visual selection to REPL"})
          },
        },
      },
    },
  },
}
