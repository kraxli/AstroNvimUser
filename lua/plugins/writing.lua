return {
  {
    "tpope/vim-abolish",
    ft = { "markdown", "text", "vimwiki" },
    config = function()
      vim.cmd [[
  			Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
			Abolish {seperate} {separate}
  			Abolish {infal}{a,}{tion,ted} {infl}{a}{}
  			Abolish {ulita,ulit,utili,utli}mate {ulti}mate 
  			Abolish {anly,anyla,anali}sis {analy}sis
  			Abolish {Cor, cor}{os,so} {Cor}{So}
			Abolish {alos} {also}
			Abolish {boostrap} {bootstrap}
			Abolish {exlcl,exlc,exl}ud{e,ed} {excl}ud{}
			Abolish tri{nag,ng}{el}{s} tri{ang}{le}{s}
			Abolish {highlevel} {high-level}
			Abolish {occurence} {occurrence}
			Abolish {heterogen}{ous,ious} {heterogen}{eous} 
			Abolish {tain}ing{s} {train}ing{s}
			Abolish {profit}{abe,abel} {profit}{able}
			Abolish {ifrs} {IFRS}
			]]
    end,
  },
  {
    "toppair/peek.nvim",
    lazy = true,
    build = "deno task --quiet build:fast",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        commands = {
          PeekOpen = { function() require("peek").open() end, desc = "Open preview window" },
          Pv = { function() require("peek").open() end, desc = "Open preview window" },
          PeekClose = { function() require("peek").close() end, desc = "Close preview window" },
        },
      },
    },
    opts = {
      theme = "light",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
    -- version = "v0.0.10",
    build = "cd $XDG_DATA_HOME/nvim/lazy/markdown-preview.nvim/app && npm install && npm audit fix --force", -- npm install && npm audit fix --force",
    -- build = function() vim.fn["call mkdp#util#install"]() end,
    ft = { "markdown" },
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
  },
  --  [markdown markmap]
  --  https://github.com/Zeioth/markmap.nvim
  {
    "Zeioth/markmap.nvim",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    ft = "markdown",
    opts = {
      hide_toolbar = "false",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    enabled = false,
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "markmap-cli" })
    end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    opts = {},
  },
  {
    "TobinPalmer/pastify.nvim",
    enabled = false, -- vim.has('win64') == 1
    cmd = { "Pastify" },
    config = function()
      require("pastify").setup {
        opts = {
          apikey = "YOUR API KEY (https://api.imgbb.com/)", -- Needed if you want to save online.
        },
      }
    end,
  },
  {
    "kraxli/clipboard-image.nvim",
    cmd = "PasteImg",
    ft = { "markdown", "text", "vimwiki" },
    config = function()
      require("clipboard-image").setup {
        default = {
          img_dir = "img",
          img_dir_txt = "img",
          img_name = function()
            -- local img_dir = 'img' -- require'clipboard-image.config'.get_config().img_dir()
            return os.date "%Y-%m-%d-%H-%M-%S"
          end,
          affix = function()
            if vim.has "win64" then
              return "![](%s)"
            else
              return "![](/%s)"
            end
          end,
        },
        -- markdown = {
        --   img_dir = 'src/assets/img',
        --   img_dir_txt = '/assets/img',
        --   affix = '![](%s)',
        -- },
      }
    end,
    -- enabled = false,
  },
  {
    "gaoDean/autolist.nvim",
    enabled = false,
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
      "norg",
    },
    config = function()
      require("autolist").setup()

      -- vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      -- vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      -- vim.keymap.set("n", "<C-space>", "<cmd>AutolistToggleCheckbox<cr>")
      vim.keymap.set("n", "<leader>zt", "<cmd>lua require('utils').handle_checkbox_autolist()<CR>")
      -- vim.keymap.set("n", "<C-space>", "<cmd>lua require('utils').handle_checkbox_autolist()<CR>")
      -- vim.keymap.set("v", "<leader>zt", "<cmd>lua require('user.utils').handle_checkbox()<CR>")
      -- vim.keymap.set("v", "<C-space>", "<cmd>lua require('user.utils').handle_checkbox()<CR>")
      vim.keymap.set("i", "<CR>", "<esc>o<cmd>AutolistNewBullet<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "> ", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "< ", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },
  {
    "dkarter/bullets.vim",
    -- enabled = false,
    -- version = "v1.11.0",
    ft = {
      "markdown",
      "plaintex",
      "text",
      "tex",
    },
    -- init
    config = function()
      vim.cmd [[
			  let g:bullets_delete_last_bullet_if_empty = 1
			  let g:bullets_auto_indent_after_colon = 1
			  let g:bullets_max_alpha_characters = 2
			  let g:bullets_renumber_on_change = 1
			  let g:bullets_nested_checkboxes = 1
			  let g:bullets_checkbox_markers = ' .oOX'  " '✗○◐●✓'
			  let g:bullets_checkbox_partials_toggle = 1
			  let g:bullets_set_mappings = 0 " disable adding default key mappings, default = 1
			  let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std-' ]   " -- 'std*', 'std+'

				" default = []
				" N.B. You can set these mappings as-is without using this g:bullets_custom_mappings option but it
				" will apply in this case for all file types while when using g:bullets_custom_mappings it would
				" take into account file types filter set in g:bullets_enabled_file_types, and also
				" g:bullets_enable_in_empty_buffers option.
				let g:bullets_custom_mappings = [
  				\ ['imap', '<cr>', '<Plug>(bullets-newline)'],
  				\ ['inoremap', '<C-cr>', '<cr>'],
  				\
  				\ ['noremap', 'O', 'k<Plug>(bullets-newline)'],
  				\ ['nmap', 'o', '<Plug>(bullets-newline)'],
  				\
  				\ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
  				\ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
  				\
  				\ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
  				\ ['nmap', '>>', '<Plug>(bullets-demote)'],
  				\ ['nmap', '> ', '<Plug>(bullets-demote)'],
  				\ ['vmap', '>', '<Plug>(bullets-demote)'],
  				\ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
  				\ ['nmap', '<<', '<Plug>(bullets-promote)'],
  				\ ['vmap', '<', '<Plug>(bullets-promote)'],
  				\ ['vmap', '< ', '<Plug>(bullets-promote)'],
  				\ ]
  				" \ ['nmap', '<c-space>', '<Plug>(bullets-toggle-checkbox)'],
  				" \ ['nmap', 'zt', '<Plug>(bullets-toggle-checkbox)'],
  				" \

  			imap      <C-CR>    <Plug>(bullets-newline)
  			" inoremap  <C-cr>  <cr>
			  noremap   O       k<Plug>(bullets-newline)
  			nmap      o       <Plug>(bullets-newline)
  			vmap      gN      <Plug>(bullets-renumber)
  			nmap      gN      <Plug>(bullets-renumber)
	      imap      <C-t>   <Plug>(bullets-demote)
  			nmap      gD      <Plug>(bullets-demote)
  			nmap      '> '    <Plug>(bullets-demote)
  			vmap      '> '    <Plug>(bullets-demote)
  			imap      <C-d>   <Plug>(bullets-promote)
  			nmap      gP      <Plug>(bullets-promote)
  			vmap      '< '    <Plug>(bullets-promote)
				]]

      -- vim.keymap.set("n", "<leader>zt", "<cmd>lua require('utils').handle_checkbox_bullets()<CR>")
      -- vim.keymap.set("n", "<C-space>", "<cmd>lua require('utils').handle_checkbox_bullets()<CR>")
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    enabled = true,
    -- ft = { "text", "markdown", "org" },
  },
}
