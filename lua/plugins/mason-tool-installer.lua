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
      "haskell-language-server",
      "html-lsp",
      "intelephense",
      "jinja-lsp",
      "json-lsp",
      -- HACK: pin version until lazydev bug is resolved: https://github.com/folke/lazydev.nvim/issues/136
      { "lua-language-server", version = "3.16.4", auto_update = false },
      "markdown-oxide",
      "neocmakelsp",
      "sqls",
      "svelte-language-server",
      "tailwindcss-language-server",
      "taplo",
      "texlab",
      "typos-lsp",
      "vtsls",
      "vue-language-server",
      "yaml-language-server",

      "opa",

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
      "haskell-debug-adapter",
      "js-debug-adapter",
      "php-debug-adapter",
    },
    integrations = {
      ["mason-lspconfig"] = false,
      ["mason-nvim-dap"] = false,
    },
  },
}
