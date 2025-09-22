local function toggle()
    vim.go.operatorfunc = "v:lua.require'markdown-togglecheck'.toggle"
    return 'g@l'
end

local function toggle_box()
    vim.go.operatorfunc = "v:lua.require'markdown-togglecheck'.toggle_box"
    return 'g@l'
end

-- local port = vim.fn.has('win64') == 1 ? 8080 : 5500
local port = 5500
if vim.fn.has('win64') == 1 then 
  port = 8086  -- 8060
end

-- vim.keymap.set('n', '<c-space>', toggle, { expr = true, desc = 'Toggle Checkmark' })
-- vim.keymap.set('n', '<leader>zt', toggle_box, { expr = true, desc = 'Toggle Checkbox' })

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
			  Abolish {experiance}{s} {experience}{s}
			]]
    end,
  },
  {
    'brianhuster/live-preview.nvim',
    enabled = vim.fn.has('unix') == 1,
    ft = { 'markdown', 'html', 'text', 'quarto' },
    cmd = { 'LivePreview', 'Pv', 'PreviewClose', 'Pc', 'PreviewPeek', 'Ps', },
    keys = {'<leader>V'},
    dependencies = {
        -- You can choose one of the following pickers
        -- 'nvim-telescope/telescope.nvim',
        -- 'ibhagwan/fzf-lua',
        'echasnovski/mini.pick',
        -- {
        --   "AstroNvim/astrocore",
        --   opts = {
        --     commands = {
        --       PreviewStart = { ":LivePreview start", desc = "Open preview window" },
        --       Pv = { ":LivePreview start", desc = "Open preview window" },
        --       PreviewClose = { ":LivePreview start", desc = "Close preview window" },
        --       Pc = { ":LivePreview start", desc = "Close preview window" },
        --       PreviewPeek =  { ":LivePreview peek", desc = "Preview peek" },
        --       Ps =  { ":LivePreview peek", desc = "Preview peek" },
        --     },
        --     mappings = {
        --       n = {
        --         ["<Leader>V"] = { "<CMD>LivePreview start<CR>", desc = "Preview" },
        --       },
        --     },
        --   },
        -- },
    },
    config = function ()
      require('livepreview.config').set({
	      port = port,
	      browser = 'default',
	      dynamic_root = false,
	      sync_scroll = true,
	      picker = "",
      })
    end
  },
  {
    "toppair/peek.nvim",
    -- enabled = vim.fn.has('win64') == 1,
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
  -- "TobinPalmer/pastify.nvim",
  {
    "HakonHarnes/img-clip.nvim",
    event = 'BufEnter',
    ft = { 'markdown', 'quarto', 'latex' },
    cmd = { "PasteImage", "ImgClipDebug", "ImgClipConfig" },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>P"] = { "<CMD>PasteImage<CR>", desc = "Paste image from system clipboard" },
            },
          },
        },
      },
    },
    opts = {
      default = {
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = vim.fn.has "win32" == 1, -- default to absolute path for windows users
      },
    },
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
        let g:bullets_checkbox_markers = ' .oOx'  " '✗○◐●✓'
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

      vim.keymap.set("n", "<leader>zt", "<cmd>lua require('utils').handle_checkbox_bullets()<CR>")
      -- vim.keymap.set("n", "<C-space>", "<cmd>lua require('utils').handle_checkbox_bullets()<CR>")
      -- vim.keymap.set("v", "<C-space>", "<cmd>lua require('utils').handle_checkbox_bullets()<CR>")
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    enabled = true,
    -- ft = { "text", "markdown", "org" },
  },
  {
    "nfrid/markdown-togglecheck",
    dependencies = { "nfrid/treesitter-utils" },
    ft = { "markdown" },
    config = function()
      require("markdown-togglecheck").setup {
        -- create empty checkbox on item without any while toggling
        create = true,
        -- remove checked checkbox instead of unckecking it while toggling
        remove = false,
      }
    end,
  },
  {
    'skardyy/neo-img',
    enabled = false,
    build = ":NeoImg Install",  -- requires go and kitty terminal
    config = function()
        require('neo-img').setup()
    end
  },
}
