---@type LazySpec
return {
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
      "gopls",
      -- "haskell-language-server",
      "html-lsp",
      "intelephense",
      "jinja-lsp",
      "json-lsp",
      "lua-language-server",
      "markdown-oxide",
      "marksman",
      "neocmakelsp",
      "regols",
      "sqls",
      -- "svelte-language-server",
      "tailwindcss-language-server",
      "taplo",
      "texlab",
      "typos-lsp",
      "vtsls",
      "vue-language-server",
      "yaml-language-server",

      -- Linters
      "ansible-lint",
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
      "delve",
      -- "haskell-debug-adapter",
      "js-debug-adapter",
      "php-debug-adapter",

      -- Other Tools
      "tree-sitter-cli",

      "markdownlint-cli2",
      "markdown-toc",
    },
    integrations = {
      ["mason-lspconfig"] = false,
      ["mason-nvim-dap"] = false,
    },
  },
}
