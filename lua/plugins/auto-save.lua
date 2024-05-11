return {
  -- see: community.lua,     astrocommunity/editing-support /auto-save-nvim/
  "auto-save-nvim",
  event = { "User AstroFile", "InsertEnter", "FocusLost" }, --["InsertLeave", "TextChanged", "FocusLost"]
}
