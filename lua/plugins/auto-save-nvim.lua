return {
  -- see: community.lua,     astrocommunity/editing-support /auto-save-nvim/
  "auto-save.nvim",
  event = { "User AstroFile", "InsertEnter", "FocusLost" }, --["InsertLeave", "TextChanged", "FocusLost"]
  config = function()
    require("auto-save").setup {
      enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      execution_message = {
        message = function() -- message to print on save
          -- return ("AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S")
          return ""
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
    }
  end,
}
