return {
  {
    "google/executor.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {},
    cmd = {
      "ExecutorRun",
      "ExecutorSetCommand",
      "ExecutorShowDetail",
      "ExecutorHideDetail",
      "ExecutorToggleDetail",
      "ExecutorSwapToSplit",
      "ExecutorSwapToPopup",
      "ExecutorToggleDetail",
      "ExecutorReset",
    },
  },
  {
    "Zeioth/compiler.nvim",
    enabled = false,
    dependencies = {
      {
        "stevearc/overseer.nvim",
        opts = {
          task_list = { -- this refers to the window that shows the result
            direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
            bindings = {
              ["q"] = function() vim.cmd "OverseerClose" end,
            },
          },
        },
        config = function(_, opts) require("overseer").setup(opts) end,
      },
    },
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    opts = {},
  },
}
