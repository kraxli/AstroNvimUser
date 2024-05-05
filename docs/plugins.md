# Plugins to checkout / include

- [ ] "rafi/vim-sidemenu" see rafi/nvim-config
- [ ] https://github.com/amrbashir/nvim-docs-view (just use <leader>K)

## Journaling / writing

- Goyo: For distraction-free writing.
- Limelight: To highlight the area under the cursor.
- Vim-lexical: Spell check and dictionary.
- https://devcharmander.medium.com/neovim-for-journaling-9b5503dc341a
- https://github.com/3rd/image.nvim

  - Mdeval.nvim: A Neovim plugin that evaluates code blocks inside documents

### Vimwiki replacements

- [Mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim): Tools for markdown notebook navigation and management

## General

- SmiteshP/nvim-gps
- inc-rename.nvim
- ixru/nvim-markdown
- kontekt/fasffold
- masukomi/vim-markdown-folding

## Cleaned out from plugins/init.lua

```lua

    -- Markdown, Note taking, Writing:

    -- {
    -- 	"dkarter/bullets.vim",
    -- 	ft = { "markdown", "text", "gitcommit", "scratch" },
    -- 	config = function()
    -- 		vim.g.bullets_enabled_file_types = {
    -- 			"markdown",
    -- 			"text",
    -- 			"gitcommit",
    -- 			"scratch",
    -- 		}
    -- 	end,
    -- },

    -- {
    -- 	"ixru/nvim-markdown",
    -- 	ft = { "markdown" },
    -- 	config = function()
    -- 		require("user.plugins.markdown.vim-markdown")
    -- 	end,
    -- },

    -- {
    -- 	"jakewvincent/mkdnflow.nvim",
    -- 	-- rocks = 'luautf8',
    -- 	config = function()
    -- 		require("mkdnflow").setup({
    -- 			-- Config goes here; leave blank for defaults
    -- 		})
    -- 	end,


	{
		"Pocco81/dap-buddy.nvim",
		-- run = vim.fn.stdpath('data') ..'/site/pack/packer/opt/dap-buddy.nvim/make',
		after = "nvim-dap",
		-- config = function()
		--   require("plugins/dap")
		-- end,
		disable = true,
	},


```
