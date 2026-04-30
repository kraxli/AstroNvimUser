return {
  {
    "tpope/vim-abolish",
    ft = { "markdown", "text", "vimwiki", "R", "r", "tex" },
    config = function()
      vim.cmd [[
  		Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
			Abolish {seperate} {separate}
  		Abolish {infal}{a,}{tion,ted} {infl}{a}{}
  		Abolish {ulita,ulit,utili,utli}mate {ulti}mate 
  		Abolish {anly,anyla,anali}sis {analy}sis
			Abolish {alos} {also}
			Abolish {boostrap} {bootstrap}
			Abolish {exlcl,exlc,exl}ud{e,ed} {excl}ud{}
			Abolish tri{nag,ng}{el}{s} tri{ang}{le}{s}
			Abolish {highlevel} {high-level}
			Abolish {occurence} {occurrence}
			Abolish {heterogen}{ous,ious} {heterogen}{eous} 
			Abolish {tain}ing{s} {train}ing{s}
			Abolish {profit}{abe,abel} {profit}{able}
			Abolish {ifrs, IfRS} {IFRS}
			"Abolish -flags=I {ifrs, IfRS} {IFRS}
			Abolish {ibrn, IBRN}{s} {IBNR}{s}
			Abolish {experiance}{s} {experience}{s}
		  Abolish {dpylr} {dplyr}
		  Abolish {experiance} {experience}
			]]
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "html", "text", "quarto", "Avante" },
    cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "LivePreview",
      "Pv",
      "PreviewClose",
      "Pc",
      "PreviewPeek",
      "Ps",
    },
    build = function()
      require("lazy").load { plugins = { "markdown-preview.nvim" } }
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd [[do FileType]]
      vim.cmd [[let g:mkdp_auto_close = 0 ]]
      -- vim.g.mkdp_auto_open = false
    end,
    specs = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {},
        },
        autocmds = {
          auto_md_preview = {
            {
              event = "FileType",
              desc = "Markdown-preview autocmds",
              pattern = { "markdown", "tex", "text", "org", "norg", "Avante" },
              callback = function()
                -- Commands:
                vim.api.nvim_create_user_command("PreviewStart", ":MarkdownPreview", {})
                vim.api.nvim_create_user_command("Pv", ":MarkdownPreviewToggle", {})
                vim.api.nvim_create_user_command("PreviewClose", ":MarkdownPreviewStop", {})
                vim.api.nvim_create_user_command("Pc", ":MarkdownPreviewStop", {})
                vim.api.nvim_create_user_command("PreviewPick", ":LivePreview pick", {})

                -- Mappings:
                vim.keymap.set(
                  { "n" },
                  "<leader>V",
                  ":MarkdownPreviewToggle<CR>",
                  { expr = false, noremap = true, buffer = true, desc = "Preview" }
                )
              end,
            },
          },
        },
      },
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
    event = "BufEnter",
    ft = { "markdown", "quarto", "latex" },
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
        -- use_absolute_path = vim.fn.has "win32" == 1, -- default to absolute path for windows users
        -- relative_to_current_file = false, ---@type boolean | fun(): boolean
        -- template = "$FILE_PATH", ---@type string | fun(context: table): string
        -- url_encode_path = false, ---@type boolean | fun(): boolean
        -- relative_template_path = true, ---@type boolean | fun(): boolean
      },
    },
    -- config = function()
    --   local oil = require("oil")
    --   local filename = oil.get_cursor_entry().name
    --   local dir = oil.get_current_dir()
    --   oil.close()
    --
    --   local img_clip = require("img-clip")
    --   img_clip.paste_image({}, dir .. filename)
    -- end,
  },
  {
    "dkarter/bullets.vim",
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
          "\ ['nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'],
          "\ ['nmap', '<leader>zt', '<Plug>(bullets-toggle-checkbox)'],
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
      vim.keymap.set("v", "<leader>zt", ":<C-u>lua require('utils').handle_checkbox_range()<CR>", { silent = true })
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    enabled = true,
    -- ft = { "text", "markdown", "org" },
  },
  {
    "skardyy/neo-img",
    enabled = false,
    build = ":NeoImg Install", -- requires go and kitty terminal
    config = function() require("neo-img").setup() end,
  },
}
