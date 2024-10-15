return(
  {
        "Willem-J-an/visidata.nvim",
        enabled = false,
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui"
        },
        config = function()
            local dap = require("dap")
            dap.defaults.fallback.external_terminal = {
                command = "zsh",
                args = { "--hold", "--command" },
            }
            vim.keymap.set("v", "<leader>vd", "<cmd>lua require('visidata').visualize_pandas_df()<CR>", { desc = "Visidata for pandas df" })
        end,
    }
)
