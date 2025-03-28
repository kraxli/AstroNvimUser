M = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      -- Language Servers
      "ansible-language-server",
      "astro-language-server",
      "basedpyright",
      "bash-language-server",
      "clangd",
      "css-lsp",
      "dockerfile-language-server",
      -- "gopls",
      -- "haskell-language-server",
      "html-lsp",
      "intelephense",
      "jinja-lsp",
      "json-lsp",
      "lua-language-server",
      "markdown-oxide",
      -- "neocmakelsp",
      -- "regols",
      "ruff",
      -- "sqls",
      "sqlls",

      "svelte-language-server",
      "tailwindcss-language-server",
      "taplo",
      "texlab",
      "typos-lsp",
      "vtsls",
      "vue-language-server",
      "yaml-language-server",

      -- Linters
      -- "ansible-lint",
      "selene",
      "shellcheck",
      "sqlfluff",

      -- Formatters
      "black",
      "isort",
      "prettier",
      "shfmt",
      "stylua",

      -- Debuggers
      "bash-debug-adapter",
      "cpptools",
      "debugpy",
      -- "delve",
      -- "haskell-debug-adapter",
      "js-debug-adapter",
      "php-debug-adapter",

      -- Other Tools
      -- "tree-sitter-cli",
    },
    integrations = {
      ["mason-lspconfig"] = false,
      ["mason-nvim-dap"] = false,
    },
  },
}

local tools_unix_only = {
  "tree-sitter-cli",
  -- "delve",
  -- "regols",
  -- "neocmakelsp",
  "ansible-lint",
  -- "gopls",
}

-- if vim.fn.has "unix" == 1 then table.insert(M.opts.ensure_installed, tools_unix_only) end
if vim.fn.has "unix" == 1 then
  for _, v in ipairs(tools_unix_only) do
    table.insert(M.opts.ensure_installed, v)
  end
end

---@type LazySpec
return M
