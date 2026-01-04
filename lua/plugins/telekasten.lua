-- local keyOpts = { noremap = true, silent = true }
-- vim.cmd [[
-- 	       " inoremap <c-[> <ESC>:lua require('telekasten').insert_link({ i=true })<CR>
-- 	       inoremap <c-l> <ESC>:lua require('telekasten').insert_link({ i=true })<CR>
-- 	       " inoremap <c-space> <ESC>:lua require('telekasten').toggle_todo({ i=true })<CR>
-- 	       " inoremap <c-3> <cmd>lua require('telekasten').show_tags({i = true})<cr>
-- 	       inoremap <c-t> <cmd>lua require('telekasten').show_tags({i = true})<cr>#
--
-- 	       " the following are for syntax-coloring [[links\]\] and ==highlighted text==
-- 	       " (see the section about coloring in README.md)
-- 	       " colors suitable for gruvbox color scheme
-- 	       hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
-- 	       hi tkBrackets ctermfg=gray guifg=gray
-- 	       " real yellow
-- 	       hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
-- 	       " gruvbox
-- 	       "hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold
-- 	       hi link CalNavi CalRuler
-- 	       hi tkTagSep ctermfg=gray guifg=gray
-- 	       hi tkTag ctermfg=175 guifg=#d3869B
-- ]]

vim.g.calendar_keys = { goto_next_month = '<C-Right>', goto_prev_month = '<C-Left>',
                        goto_next_year = 'C-Down', goto_prev_year = '<C-Up>',
                        goto_today = 't'
                      }


local prefix = "<Leader>z"
return {
  "renerocksai/telekasten.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", 
      "nvim-telekasten/calendar-vim",
    },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            -- ["<c>"] = {
            --   ["<space>"] = { "<cmd>lua require('telekasten').toggle_todo()<CR>", "Toggle checkbox" },
            --                 -- { "<cmd>lua require('utils').handle_checkbox_bullets()<CR>", "Toggle checkbox" },
            -- },
            [prefix] = { desc = "󰛔 Telekasten" },
            -- [prefix .. "s"] = { function() require("spectre").toggle() end, desc = "Toggle Spectre" },
            [prefix .. "#"] = { '<cmd>lua require("telekasten").show_tags({i = false})<CR>', desc = "Show tags" },
            [prefix .. "b"] = { '<cmd>lua require("utils").insert_list_bullet()<CR>', desc = "Set bullet" },
            [prefix .. "B"] = { '<cmd>lua require("utils").show_backlinks()<CR>', desc = "Show back links" },
            [prefix .. "c"] = { '<cmd>lua require("telekasten").show_calendar()<CR>', desc = "Show calendar" },
            [prefix .. "C"] = { "<cmd> CalendarT<CR>", desc = "Calendar" },
            [prefix .. "f"] = { desc = "Find / Search" },
            [prefix .. "f#"] = { '<cmd>lua require("telekasten").show_tags({i = false})<CR>', desc = "Find tags" },
            [prefix .. "fd"] = { '<cmd>lua require("telekasten").find_dialy_notes()<CR>', desc = "Find daily note" },
            [prefix .. "ff"] = { '<cmd>lua require("telekasten").find_notes()<CR>', desc = "Find note" },
            [prefix .. "fF"] = { '<cmd>lua require("telekasten").find_friends()<CR>', desc = "Find friends" },
            [prefix .. "fg"] = { '<cmd>lua require("telekasten").search_notes()<CR>', desc = "Search notes" },
            [prefix .. "fw"] = { '<cmd>lua require("telekasten").find_weekly_notes()<CR>', desc = "Find note" },
            -- [prefix .. "h"] = { "<cmd>call Header_promote()<CR>", desc = "Header promote" },
            -- [prefix .. "H"] = { "<cmd>call Header_demote()<CR>", desc = "Header demote" },
            [prefix .. "i"] = { '<cmd>lua require("telekasten").insert_link({ i=false })<CR>', desc = "Insert link" },
            [prefix .. "I"] = {
              '<cmd>lua require("telekasten").insert_img_link({ i=true })<CR>',
              desc = "Insert image link",
            },
            [prefix .. "J"] = { '<cmd>lua require("telekasten").paste_img_and_link()<CR>', desc = "Paste img & link" },
            [prefix .. "l"] = { '<cmd>lua require("telekasten").follow_link()<CR>', desc = "Follow link" },
            [prefix .. "n"] = { '<cmd>lua require("telekasten").new_note()<CR>', desc = "New note" },
            [prefix .. "N"] = { '<cmd>lua require("telekasten").new_templated_note()<CR>', desc = "New template note" },
            [prefix .. "m"] = { '<cmd>lua require("telekasten").browse_media()<CR>', desc = "Brows media" },
            [prefix .. "p"] = { '<cmd>lua require("telekasten").preview_img()<CR>', desc = "Preview img" },
            [prefix .. "r"] = { '<cmd>lua require("telekasten").rename_note()<CR>', desc = "Rename this note" },
            -- t = { "<cmd>lua require('utils').handle_checkbox_bullets()<CR>", desc = "Toggle todo" },
            [prefix .. "t"] = { "<cmd>lua require('telekasten').toggle_todo()<CR>", desc = "Toggle checkbox" },
            [prefix .. "T"] = { '<cmd>lua require("telekasten").goto_today()<CR>', desc = "Goto today" },
            [prefix .. "W"] = { '<cmd>lua require("telekasten").goto_thisweek()<CR>', desc = "Goto this week" },
            [prefix .. "y"] = { '<cmd>lua require("telekasten").yank_notelink()<CR>', desc = "Yank note link" },
            [prefix .. "z"] = { '<cmd>lua require("telekasten").panel()<CR>', desc = "Panel" },
            [prefix .. "x"] = { "<cmd>PasteImg<cr>", desc = "Paste Image" },

            ["<c-space>"] = { "<cmd>lua require('telekasten').toggle_todo()<CR>", desc = "Toggle checkbox" },
          },
          i = {
            -- ["<c-i>"] = false,
            ["]]"] = {
              -- "<Cmd>lua require('telekasten').insert_link({ i=true })<CR>",
              "<cmd>Telekasten insert_link<CR>",
              desc = "Telekasten insert link",
            },
            -- ["<c>"] = {
            --   ["<i>"] = {
            --     -- "<Cmd>lua require('telekasten').insert_link({ i=true })<CR>",
            --     "<cmd>Telekasten insert_link<CR>",
            --     desc = "Telekasten insert link",
            --   },
            --   ["<l>"] = {
            --     '<cmd>lua require("telekasten").follow_link()<CR>',
            --     desc = "Follow link",
            --   },
            --   ["<t>"] = {
            --     "<Cmd><cmd>lua require('telekasten').show_tags({i = true})<CR>",
            --     desc = "Telekasten show tags",
            --   },
            -- },
          },
          v = {
            -- ["<C-space>"] = { "<cmd>lua require('telekasten').toggle_todo( { v=true} )<CR>", "Toggle checkbox" },
            ["<leader>zt"] = {
              "<cmd>lua require('telekasten').toggle_todo( { v=true } )<CR>",
              desc = "Toggle checkbox",
            },
          },
        },
      },
    },
  },
  on_attach = function(bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr }
    -- map({'v', 'x'}, "<C-space>", "<cmd>lua require('telekasten').toggle_todo( { v=true } )<CR>", opts)
  end,
  ft = { "markdown", "vimwiki", "text", "telekasten" },
  keys = { "<leader>z" },
  cmd = { "Telekasten", "Tk", "Calendar", "CalendarT", "CalendarH" },
  init = function()
    vim.cmd [[
         command! Tk :Telekasten
         au! FileType telekasten set filetype=markdown syntax=markdown
      ]]
  end,
  opts = function()
    local status, _ = pcall(require, "local.settings")
    if status then
      home = vim.fn.expand(vim.g.dirPkd)
    -- home = vim.fn.expand("~/Dropbox/PKD/")
    -- home = vim.fn.expand(require("local.settings").dirPkd)
    else
      home = "."
    end
    -- local home = vim.fn.expand("~/Dropbox/PKD")

    require("telekasten").setup {
      home = home,

      -- if true, telekasten will be enabled when opening a note within the configured home
      take_over_my_home = false,

      -- auto-set telekasten filetype: if false, the telekasten filetype will not be used and thus the telekasten syntax will not be loaded either
      auto_set_filetype = false,

      -- dir names for special notes (absolute path or subdir name)
      dailies = home .. "/" .. "daily",
      weeklies = home .. "/" .. "weekly",
      templates = home .. "/" .. "templates", -- "$XDG_CONFIG_HOME/astronvim/templates",

      -- image (sub)dir for pasting
      -- dir name (absolute path or subdir name)
      -- or nil if pasted images shouldn't go into a special subdir
      image_subdir = "img",

      -- markdown file extension
      extension = ".md",

      -- Generate note filenames. One of:
      -- "title" (default) - Use title if supplied, uuid otherwise
      -- "uuid" - Use uuid
      -- "uuid-title" - Prefix title by uuid
      -- "title-uuid" - Suffix title with uuid
      new_note_filename = "uuid-title",
      -- file uuid type ("rand" or input for os.date such as "%Y%m%d%H%M")
      uuid_type = "%Y%m%d", -- %H%M",
      -- UUID separator
      uuid_sep = "-",

      -- following a link to a non-existing note will create it
      follow_creates_nonexisting = true,
      dailies_create_nonexisting = true,
      weeklies_create_nonexisting = true,

      -- -- template for new notes (new_note, follow_link)
      -- -- set to `nil` or do not specify if you do not want a template
      template_new_note = home .. "/" .. "templates/telekasten_base.md",
      --
      -- -- template for newly created daily notes (goto_today)
      -- -- set to `nil` or do not specify if you do not want a template
      -- template_new_daily = home .. '/' .. 'templates/daily.md',
      --
      -- -- template for newly created weekly notes (goto_thisweek)
      -- -- set to `nil` or do not specify if you do not want a template
      -- template_new_weekly= home .. '/' .. 'templates/weekly.md',

      -- image link style
      -- wiki:     ![[image name]]
      -- markdown: ![](image_subdir/xxxxx.png)
      image_link_style = "markdown",

      -- integrate with calendar-vim
      plug_into_calendar = true,
      calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = "left-fit",
      },

      -- telescope actions behavior
      close_after_yanking = false,
      insert_after_inserting = true,

      -- tag notation: '#tag', ':tag:', 'yaml-bare'
      tag_notation = "#tag",

      -- command palette theme: dropdown (window) or ivy (bottom panel)
      command_palette_theme = "ivy",

      -- tag list theme:
      -- get_cursor: small tag list at cursor; ivy and dropdown like above
      show_tags_theme = "ivy",

      -- when linking to a note in subdir/, create a [[subdir/title]] link
      -- instead of a [[title only]] link
      subdirs_in_links = true,

      -- -- template_handling
      -- -- What to do when creating a new note via `new_note()` or `follow_link()`
      -- -- to a non-existing note
      -- -- - prefer_new_note: use `new_note` template
      -- -- - smart: if day or week is detected in title, use daily / weekly templates (default)
      -- -- - always_ask: always ask before creating a note
      template_handling = "smart",

      -- path handling:
      --   this applies to:
      --     - new_note()
      --     - new_templated_note()
      --     - follow_link() to non-existing note
      --
      --   it does NOT apply to:
      --     - goto_today()
      --     - goto_thisweek()
      --
      --   Valid options:
      --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
      --              all other ones in home, except for notes/with/subdirs/in/title.
      --              (default)
      --
      --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
      --                    except for notes with subdirs/in/title.
      --
      --     - same_as_current: put all new notes in the dir of the current note if
      --                        present or else in home
      --                        except for notes/with/subdirs/in/title.
      new_note_location = "smart",

      -- should all links be updated when a file is renamed
      rename_update_links = true,
    }
  end,

  -- vim.api.nvim_set_keymap('i', '<c-a>', "<ESC>:lua require('telekasten').insert_link({ i=true })<CR>", keyOpts)
  -- vim.api.nvim_set_keymap('i', '<c-#>', "<cmd>lua require('telekasten').show_tags({i = true})<cr>", keyOpts)

  -- vim.api.nvim_set_keymap(
  -- 	"n",
  -- 	"<c-space>",
  -- 	"<ESC>:lua require('telekasten').toggle_todo({ i=false })<CR>",
  -- 	keyOpts
  -- )
  -- vim.api.nvim_set_keymap(
  -- 	"i",
  -- 	"<c-space>",
  -- 	"<ESC>:lua require('telekasten').toggle_todo({ i=true })<CR>",
  -- 	keyOpts
  -- )
}
