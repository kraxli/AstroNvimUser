local prefix = "<leader>v"

return {
  "benomahony/uv.nvim",
  ft = { "python", "quarto" },
  dependencies = {
    "folke/snacks.nvim",
    -- "nvim-telescope/telescope.nvim"
  },
  opts = {
    picker_integration = true,
  },
  config = function()
    require("uv").setup {
      -- Auto-activate virtual environments when found
      auto_activate_venv = true,
      notify_activate_venv = true,

      -- Auto commands for directory changes
      auto_commands = true,

      -- Integration with snacks picker
      picker_integration = true,

      -- Keymaps to register (set to false to disable)
      -- keymaps = false  -- Disable all keymaps
      keymaps = {
        prefix = prefix, -- Main prefix for uv commands
        commands = true, -- Show uv commands menu (<leader>x)
        run_file = true, -- Run current file (<leader>xr)
        run_selection = true, -- Run selected code (<leader>xs)
        run_function = true, -- Run function (<leader>xf)
        venv = true, -- Environment management (<leader>xe)
        init = true, -- Initialize uv project (<leader>xi)
        add = true, -- Add a package (<leader>xa)
        remove = true, -- Remove a package (<leader>xd)
        sync = true, -- Sync packages (<leader>xc)
        sync_all = true, -- Sync all packages, extras and groups (<leader>xC)
        -- Disable specific keymaps
        -- venv = false,
      },

      -- Execution options
      execution = {
        -- Python run command template
        run_command = "uv run python",
        --   run_command = "python -m",  -- Use standard Python instead of uv

        -- Show output in notifications
        notify_output = true,

        -- Notification timeout in ms
        notification_timeout = 10000,
      },
    }
  end,
}
