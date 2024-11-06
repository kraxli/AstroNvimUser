local M = {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  -- example of importing an entire language pack
  -- these packs can set up things such as Treesitter, Language Servers, additional language specific plugins, and more!
  -- { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.python" },
  -- { import = "astrocommunity.editing-support.auto-save-nvim" }, -- Pocco81/auto-save.nvim
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },
}

local win_plugins = {
  -- { import = "astrocommunity.completion.copilot" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}

if vim.fn.has "win64" == 1 then
  for _, v in ipairs(win_plugins) do
    table.insert(M, v)
  end
end

return M
