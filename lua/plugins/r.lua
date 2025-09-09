local prefix = "<Leader>r"
local localleader = "<LocalLeader>"

-- vim.g.R_filetypes = { "r", "rmd", "rnoweb", "rhelp" }  -- , "quarto"

-- -------------------------------------------------------
-- Set OS specific variables
-- -------------------------------------------------------
local r_path = "/usr/bin"
local csv_app = ':TermExec cmd="vd %s" direction=float name=visidataTerm'
local pdfviewer = "" -- use default pdfviewer

-- for graphical R devices see: https://bookdown.org/rdpeng/exdata/graphics-devices.html
local graphical_device = "X11"

if vim.fn.has "win64" == 1 then
  r_path = "C:\\Program Files\\R\\R-4.4.2\\bin\\x64"
  -- csv_app = "terminal:vd"
  graphical_device = "windows"
  pdfviewer = "mupdf" -- or sumatra
end
-- vim.g.R_path = r_path

-- -------------------------------------------------------
-- Local functions
-- -------------------------------------------------------
local function keymap_modes(modes, command, keymap, opts)
  for _, mode in ipairs(modes) do
    vim.api.nvim_buf_set_keymap(0, mode, keymap, command, opts)
  end
end

function set_csv_app(app, mode, args)
  local default_app = require("r.config").get_config().csv_app
  require("r.config").get_config().csv_app = app
  require("r.run").action("viewobj", mode, args)
  -- require("r.config").get_config().csv_app = default_app
  return default_app
end
-- vim.api.nvim_buf_set_keymap(0, "n", <localleader>Vt, set_csv_app("terminal:vd", "n", ''), {})
-- keymap_modes({"n"}, '<cmd>lua app = set_csv_app("terminal:vd", "n", ''); require("r.config").get_config().csv_app = app<CR>', prefix .. "Vt", {})

local function view_object_details()
  local browser = require 'r.browser'
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local curline = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
  local object_name = browser.get_name(lnum, curline)
  if object_name == '' then
    require('r').warn 'No object selected.'
    return
  end

  -- Open a split window and show the object's details
  vim.cmd 'split'
  vim.cmd 'enew'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'Details of ' .. object_name })
  -- More logic here to fetch and display details
end


-- -------------------------------------------------------

return {
  -- {
  --   "R-nvim/cmp-r",
  --   -- ft = { "R", "r", "rmd", "rnoweb", "quarto", "qmd", "rhelp" },
  --   dependencies = { "Saghen/blink.cmp" },
  --   specs = {
  --     {
  --       "Saghen/blink.cmp",
  --       optional = true,
  --       opts = {
  --         sources = {
  --           providers = {
  --             cmp_r = {
  --               name = "cmp_r",
  --               module = "blink.compat.source",
  --             },
  --           },
  --         },
  --       },
  --       -- opts = function(_, opts)
  --       --   if not opts.sources.providers then opts.sources.providers = {} end
  --       --   -- table.insert()
  --       --   require("astrocore").list_insert_unique(opts.sources.providers, {
  --       --     cmp_r = {
  --       --       name = "cmp_r",
  --       --       module = "blink.compat.source",
  --       --     },
  --       --   })
  --       -- end,
  --     },
  --   },
  -- },
  {
    "R-nvim/R.nvim",
    lazy = false,
    -- branch = 'view_df',  -- or tag, commit
    -- ft = {'R'},
    config = function()
      -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>rs", "<Plug>RDSendLine", {})
      -- vim.api.nvim_buf_set_keymap(0, "v", "<leader>rs", "<Plug>RSendSelection", {})
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_path = r_path, -- vim.g.r_path
        R_args = { "--quiet" },
        min_editor_width = 72,
        rconsole_width = 78,
        pdfviewer = pdfviewer,
        disable_cmds = {},
        pipe_version = "magrittr",  -- or native
        nvimpager = "split_v",
        view_df = {
          n_lines = 0,
          save_fun = "function(obj, obj_name) {f <- paste0(obj_name, '.parquet'); arrow::write_parquet(obj, f) ; f}",
          -- open_app = "terminal:vd",
          open_app = csv_app,
        },
        objbr_mappings = {
          c = 'class({object})',
          dd = 'rm',
          e = view_object_details,
          g = 'dplyr::glimpse',
          h = 'head({object}, 10)', -- Command with arguments
          l = 'length({object})',
          m = 'object.size',
          n = 'names', -- Command without placeholder, object name will be appended.
          p = 'plot({object})',
          s = 'str({object})',
          ss = 'summary({object})',
          v = function()
            require('r.browser').toggle_view()
          end,
          q = function() 
            require('r.browser').start()
          end,
        },
        rm_knit_cache = true,
        synctex = true,
        user_maps_only = false,
        hook = {
          on_filetype = function()
            -- -- httpgd, see:https://github.com/R-nvim/R.nvim/wiki/Configuration#using-httpgd-as-the-default-graphics-device
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "gd", "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>", {desc='httpgd'})
            -- vim.api.nvim_buf_set_keymap(0, "n",  "<localleader>gd", "<cmd>lua require('r.send').cmd('tryCatch({dev.off(); options(device = httpgd::hgd); httpgd::hgd_browse(); dev.off(); options(device = X11)}, error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>", {desc='httpgd'})

            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})
            --
            -- vim.api.nvim_buf_set_keymap(0, "n", "<localleader>rv", set_csv_app('<cmd>TermExec cmd="vd %s" direction=float<CR>', "n", ''), {})

            -- Keymappings:
            -- ,,:                |>
            -- <m--> / Alt + -:   <-
            -- edit & operators
            -- vim.api.nvim_buf_set_keymap(0, "i", "<Plug>RAssign", '<Cmd>lua require("r.edit").assign()<CR>', { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "<m-->", "<Plug>RInsertAssign", { noremap = true })
            vim.api.nvim_buf_set_keymap( 0, "i", "aa", "<Plug>RInsertAssign", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", "ää", "<Plug>RInsertAssign", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", "__", "<Plug>RInsertAssign", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", "..", "<Plug>RInsertAssign", { silent = true, noremap = true, expr = false })
            -- vim.api.nvim_buf_set_keymap(0, "i", "<Plug>RPipe", '<Cmd>lua require("r.edit").pipe()<CR>', { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", "<<", "<Plug>RInsertPipe", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", ",,", "<Plug>RInsertPipe", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", "<m-.>", "<Plug>RInsertPipe", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap( 0, "i", "<m-,>", "<Plug>RInsertPipe", { silent = true, noremap = true, expr = false })
            -- TODO:
            -- keymap_modes({"n", "i", "v"}, "RSetwd", "rd",  {})  -- "<Cmd>lua require('r.run').setwd()"
            -- keymap_modes({"n", "i", "v"}, "RSeparatePath", {})  --    "sp", "<Cmd>lua require('r.path').separate()"
            --
            -- -- Format functions (no need to change defaults)
            -- create_maps("nvi", "RFormatNumbers",    "cn", "<Cmd>lua require('r.format.numbers').formatnum()")
            -- create_maps("nvi", "RFormatSubsetting",    "cs", "<Cmd>lua require('r.format.brackets').formatsubsetting()")

            -- Start
            -- keymap_modes({"n","v","i"}, "<Plug>RStart", prefix .. "r", {})
            keymap_modes( { "n", "v" }, "<Cmd>lua require('r.run').start_R('R')<CR>", prefix .. "r", { desc = "R start" }) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes( { "n", "v" }, "<Cmd>lua require('r.run').start_R('custom')<CR>", prefix .. "R", { desc = "R custom start" }) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- Close
            keymap_modes( { "n", "v" }, "<Cmd>lua require('r.run').quit_R('nosave')<CR>", prefix .. "Q", { desc = "R close" }) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes( { "n", "v" }, "<Cmd>lua require('r.run').quit_R('save')<CR>", prefix .. "W", { desc = "R save & close" }) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- Clear console
            keymap_modes({ "n", "v" }, "<Plug>RClearConsole", prefix .. "d", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RClearAll", prefix .. "D", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- Print,          names,               structure
            keymap_modes({ "n", "v" }, "<Plug>RObjectPr", prefix .. "P", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RObjectNames", prefix .. "n", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RObjectStr", prefix .. "t", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RDputObj", "<leader>td", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            keymap_modes({ "n" }, "<Plug>RPackages", prefix .. "P", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            keymap_modes({ "n", "v" }, "<Plug>RViewDF", prefix .. "v", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RViewDFs", prefix .. "Vs", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RViewDFv", prefix .. "Vv", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RViewDFa", prefix .. "Vh", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- keymap_modes({"n"}, '<cmd>lua app = set_csv_app("terminal:vd"); require("r.config").get_config().csv_app = app<CR>', prefix .. "Vt", {})

            -- Arguments,      example,      help
            keymap_modes({ "n", "v" }, "<Plug>RShowArgs", prefix .. "a", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RShowEx", prefix .. "e", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RHelp", prefix .. "h", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- Summary,        plot,       both
            keymap_modes({ "n", "v" }, "<Plug>RSummary", prefix .. "S", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RPlot", prefix .. "pp", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>RSPlot", prefix .. "ps", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- Object Browser
            keymap_modes({ "n", "v" }, "<Plug>ROBToggle", prefix .. "o", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>ROBOpenLists", prefix .. "=", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
            keymap_modes({ "n", "v" }, "<Plug>ROBCloseLists", prefix .. "-", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- Miscellaneous
            -- keymap_modes({"n", "i", "v"},  "<Plug>RInsertLineOutput",   "o",    {})  --    "<Cmd>lua require('r.run').insert_commented()")
            keymap_modes({ "n", "v" }, "<Plug>RInsertLineOutput", prefix .. "I", {}) --    "<Cmd>lua require('r.run').insert_commented()")  -- i-mode removed (to be mapped to ctrl or alt key combination)

            -- -------------------------------------------------------
            -- R send
            -- -------------------------------------------------------
            vim.api.nvim_buf_set_keymap(0, "n", "<C-Enter>", "<Plug>RSendLine", { desc = "Send line" })
            vim.api.nvim_buf_set_keymap(0, "v", "<C-Enter>", "<Plug>RSendSelection", { desc = "Send selection" })
            vim.api.nvim_buf_set_keymap(0, "n", "<S-Enter>", "<Plug>RDSendLine", { desc = "Send line & down" })
            vim.api.nvim_buf_set_keymap( 0, "v", "<S-Enter>", "<Plug>RDSendSelection", { desc = "Send selection & down" })
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "l", "<Plug>RSendLine", { desc = "Send line" })
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "s", "<Plug>RSendLine", { desc = "Send line" })
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Plug>RDSendLine", { desc = "Send line & down" })
            vim.api.nvim_buf_set_keymap(0, "v", prefix .. "l", "<Plug>RSendSelection", { desc = "Send selection" })
            vim.api.nvim_buf_set_keymap(0, "v", prefix .. "s", "<Plug>RSendSelection", { desc = "Send selection" })
            vim.api.nvim_buf_set_keymap( 0, "v", prefix .. "L", "<Plug>RDSendSelection", { desc = "Send selection & down" })
            vim.api.nvim_buf_set_keymap( 0, "i", "<C-Enter>", "<Cmd>lua require('r.send').line(false)<CR>", { desc = "Send line" })
            vim.api.nvim_buf_set_keymap( 0, "i", "<S-Enter>", "<Cmd>lua require('r.send').line(true)<CR>", { desc = "Send line & down" })

            -- send variable / word under cursor:
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "w", "viW<Plug>RSendSelection", { desc = "Send word / variable" })

            -- Send Pipe chain breaker
            keymap_modes({ "n", "v" }, "RSendChain", prefix .. "xc", {}) -- "<Cmd>lua require('r.send').chain()"

            -- Function
            keymap_modes({ "n", "v" }, "<Plug>RSendAllFun", "fa", {}) -- "<Cmd>lua require('r.send').funs(0, true, false)"
            keymap_modes({ "n", "v" }, "<Plug>RSendCurrentFun", "fc", {}) -- "<Cmd>lua require('r.send').funs(0, false, false)"
            keymap_modes({ "n", "v" }, "<Plug>RSendCurrentFun", prefix .. "xf", {}) -- "<Cmd>lua require('r.send').funs(0, false, false)"
            keymap_modes({ "n", "v" }, "<Plug>RDSendCurrentFun", "fd", {}) -- "<Cmd>lua require('r.send').funs(0, false, true)"
            keymap_modes({ "n", "v" }, "<Plug>RDSendCurrentFun", prefix .. "xF", {}) -- "<Cmd>lua require('r.send').funs(0, false, true)"

            -- Lines
            keymap_modes({ "n" }, "<Plug>RSendMotion", "m", {}) --    "<Cmd>set opfunc=v:lua.require'r.send'.motion<CR>g@", true)  -- "i"
            keymap_modes({ "n" }, "<Plug>RSendMotion", prefix .. "m", {}) --    "<Cmd>set opfunc=v:lua.require'r.send'.motion<CR>g@", true)  --"i"
            -- keymap_modes({"i"},   "<Plug>RSendLAndOpenNewOne", "q",        {})  --"<Cmd>lua require('r.send').line('newline')")
            keymap_modes({ "n" }, "<Plug>RNLeftPart", "r<left>", {}) --"<Cmd>lua require('r.send').line_part('left',  false)")
            keymap_modes({ "n" }, "<Plug>RNLeftPart", prefix .. "x<left>", {}) --"<Cmd>lua require('r.send').line_part('left',  false)")
            keymap_modes({ "n" }, "<Plug>RNRightPart", "r<right>", {}) --"<Cmd>lua require('r.send').line_part('right', false)")
            keymap_modes({ "n" }, "<Plug>RNRightPart", prefix .. "x<right>", {}) --"<Cmd>lua require('r.send').line_part('right', false)")
            -- !! insert mode mappigs without ctrl- or alt-key combination
            keymap_modes({ "i" }, "<Plug>RILeftPart", "r<left>", {}) --"<Cmd>lua require('r.send').line_part('left',  true)")
            keymap_modes({ "i" }, "<Plug>RILeftPart", prefix .. "x<left>", {}) --"<Cmd>lua require('r.send').line_part('left',  true)")
            keymap_modes({ "i" }, "<Plug>RIRightPart", "r<right>", {}) --"<Cmd>lua require('r.send').line_part('right', true)")
            keymap_modes({ "i" }, "<Plug>RIRightPart", prefix .. "x<right>", {}) --"<Cmd>lua require('r.send').line_part('right', true)")

            -- TODO: send motions!

            -- Send Paragraph
            keymap_modes({ "n" }, "<Cmd>lua require('r.send').paragraph(false)<CR>", "pp", {}) -- "RSendParagraph"; i mode ?
            keymap_modes({ "n" }, "<Cmd>lua require('r.send').paragraph(false)<CR>", prefix .. "b", {}) -- "RSendParagraph"; i mode ?
            keymap_modes({ "n" }, "<Cmd>lua require('r.send').paragraph(true)<CR>", "pd", {}) --   RDSendParagraph; i mode ?
            keymap_modes({ "n" }, "<Cmd>lua require('r.send').paragraph(true)<CR>", prefix .. "B", {}) --   RDSendParagraph; i mode ?

            keymap_modes({ "n" }, "<Cmd>lua require('r.send').paragraph(false)<CR>", prefix .. "xp", {}) -- "RSendParagraph"; i mode ?
            keymap_modes({ "n" }, "<Cmd>lua require('r.send').paragraph(false)<CR>", prefix .. "xP", {}) -- "RSendParagraph"; i mode ?

            -- Send block - I don't work often with marks
            -- keymap_modes({"n", "i"},  "<Cmd>lua require('r.send').marked_block(false)<CR>",   "bb", {}) -- "<Plug>RSendMBlock<CR>"
            -- keymap_modes({"n", "i"},  "<Cmd>lua require('r.send').marked_block(true)<CR>",  "bd", {}) -- "<Plug>RDSendMBlock<CR>"

            -- If you want an action over an selection, then the second
            -- argument must be the string `"v"`:
            -- In this case, the beginning and the end of the selection must be
            -- in the same line.
            -- vim.api.nvim_buf_set_keymap(0, "v", "<LocalLeader>T", "<Cmd>lua require('r.run').action('head')<CR>", {})

            -- If a third optional argument starts with a comma, it will be
            -- inserted as argument(s) to the `action`:
            -- vim.api.nvim_buf_set_keymap( 0, "n", "<LocalLeader>H", "<Cmd>lua require('r.run').action('head', 'n', ', n = 10')<CR>", {})

            -- If the command that you want to send does not require an R
            -- object as argument, you can use `cmd()` from the `r.send` module
            -- to send it directly to R Console:
            -- vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>S", "<Cmd>lua require('r.send').cmd('search()')<CR>", {})
          end,
        },
      }
      -- Check if the environment variable "R_AUTO_START" exists. If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      -- if vim.env.R_AUTO_START == "true" then
      --   opts.auto_start = 1
      --   opts.objbr_auto_start = true
      -- end
      opts.auto_start = "always"
      opts.objbr_auto_start = false

      require("r").setup(opts)
    end,
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = {
        autocmds = {
          auto_ft_r = {
            {
              event = { "FileType" }, --  "BufWinEnter", "BufRead", "BufNewFile", "BufNew", "BufAdd", "BufEnter", "TabNewEntered", "TabEnter"
              pattern = { "r", "R" },
              callback = function()
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "l", "<Plug>RSendLine", { desc = "Send line" })
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "s", "<Plug>RSendLine", { desc = "Send line" })
                keymap_modes({ "n" }, "<Cmd>lua require('r.send').source_file()<CR>", "aa", {}) -- "RSendFile"   -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes( { "n" }, "<Cmd>lua require('r.send').source_file()<CR>", prefix .. "f", { desc = "Send file" }) -- "RSendFile"  -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n" }, "<Cmd>lua require('r').show_R_out()<CR>", "ao", {}) -- "RshowRout"  -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n" }, "<Cmd>lua require('r').show_R_out()<CR>", prefix .. "O", { desc = "Show R out" }) -- "RshowRout"  -- i-mode removed (to be mapped to ctrl or alt key combination)

                keymap_modes({ "n" }, "<Plug>RSendAboveLines", prefix .. "xu", {}) -- "<Cmd>lua require('r.send').above_lines()"

                keymap_modes( { "n" }, "<Cmd>lua require('r.send').paragraph(false)<CR>", prefix .. "C", { desc = "Send paragraph" }) -- "RSendParagraph"; i mode ?
                keymap_modes( { "n" }, "<Cmd>lua require('r.send').paragraph(true)<CR>", prefix .. "c", { desc = "Send paragraph & down" }) --   RDSendParagraph; i mode ?
              end,
            },
          },
          auto_rmd_qmd = {
            {
              event = { "FileType" }, --  "BufWinEnter", "BufRead", "BufNewFile", "BufNew", "BufAdd", "BufEnter", "TabNewEntered", "TabEnter"
              pattern = { "rmd", "rnoweb", "*.rmd", "*.rnoweb", "quarto", "*.quarto", "*.qmd", },
              callback = function()
                keymap_modes({ "n" }, "<Plug>RSendChunk", prefix .. "c", {}) -- "<Cmd>lua require('r.rmd').send_R_chunk(false)" -- i-mode ?
                vim.keymap.set(
                  { "n", "v" },
                  prefix .. "C",
                  "<Plug>RDSendChunk",
                  { expr = false, noremap = true, buffer = true, desc = "RDSendChunk" }
                )
                keymap_modes({ "n" }, "<Plug>RNextRChunk", prefix .. "gn", {}) -- "<Cmd>lua require('r.rmd').next_chunk()"
                keymap_modes({ "n" }, "<Plug>RPreviousRChunk", prefix .. "gN", {}) -- "<Cmd>lua require('r.rmd').previous_chunk()"
                keymap_modes({ "n" }, "<Plug>RSendChunkFH", prefix .. "xu", { desc = "Run chunks above" }) -- "<Cmd>lua require('r.send').chunks_up_to_here()" -- i-mode?
                keymap_modes({ "n" }, "<Plug>RSendChunkFH", prefix .. "U", { desc = "Run chunks above" }) -- "<Cmd>lua require('r.send').chunks_up_to_here()" -- i-mode ?

                -- Render script with rmarkdown
                keymap_modes({ "n", "v" }, "<Plug>RMakeRmd", prefix .. "kr", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n", "v" }, "<Plug>RMakeAll", prefix .. "ka", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n", "v" }, "<Plug>RMakePDFK", prefix .. "kp", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n", "v" }, "<Plug>RMakePDFKb", prefix .. "kl", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n", "v" }, "<Plug>RMakeWord", prefix .. "kw", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n", "v" }, "<Plug>RMakeHTML", prefix .. "kh", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)
                keymap_modes({ "n", "v" }, "<Plug>RMakeODT", prefix .. "ko", {}) -- i-mode removed (to be mapped to ctrl or alt key combination)

                -- rmd & quarto
                keymap_modes({ "n", "v" }, "<Plug>RKnit", prefix .. "kk", {}) -- "<Cmd>lua require('r.run').knit()"  -- i-mode removed (to be mapped to ctrl or alt key combination)

                -- if config.rm_knit_cache then
                keymap_modes({ "n", "v" }, "<Plug>RKnitRmCache", prefix .. "kc", {}) -- "<Cmd>lua require('r.rnw').rm_knit_cache()"  -- i-mode removed (to be mapped to ctrl or alt key combination)
                -- end
              end,
            },
          },
          auto_qmd = {
            {
              event = { "FileType" }, --  "BufWinEnter", "BufRead", "BufNewFile", "BufNew", "BufAdd", "BufEnter", "TabNewEntered", "TabEnter"
              pattern = { "quarto", "*.qmd", "*.quarto" },
              callback = function()
                keymap_modes({ "n" }, "<Plug>QuartoRender", prefix .. "qr", {}) -- "<Cmd>lua require('r.quarto').command('render')"
                keymap_modes({ "n" }, "<Plug>QuartoPreview", prefix .. "qp", {}) -- "<Cmd>lua require('r.quarto').command('preview')"
                keymap_modes({ "n" }, "<Plug>QuartoStop", prefix .. "qs", {}) -- "<Cmd>lua require('r.quarto').command('stop')"
              end,
            },
          },
          auto_ft_rnoweb = {
            {
              event = { "FileType" }, --  "BufWinEnter", "BufRead", "BufNewFile", "BufNew", "BufAdd", "BufEnter", "TabNewEntered", "TabEnter"
              pattern = { "rnoweb" },
              callback = function()
                keymap_modes({ "n", "v" }, "<Plug>RSweave", prefix .. "ks", {}) -- "<Cmd>lua require('r.rnw').weave('nobib',  false, false)"  -- i-mode ?
                keymap_modes({ "n", "v" }, "<Plug>RMakePDF", prefix .. "kP", {}) -- "<Cmd>lua require('r.rnw').weave('nobib',  false, true)"  -- i-mode ?
                keymap_modes({ "n", "v" }, "<Plug>RBibTeX", prefix .. "kb", {}) -- "<Cmd>lua require('r.rnw').weave('bibtex', false, true)"  -- i-mode ?
                keymap_modes({ "n", "v" }, "<Plug>RKnit", prefix .. "kn", {}) -- "<Cmd>lua require('r.rnw').weave('nobib',  true, false)"  -- i-mode ?
                keymap_modes({ "n", "v" }, "<Plug>RBibTeXK", prefix .. "kB", {}) -- "<Cmd>lua require('r.rnw').weave('bibtex', true, true)"  -- i-mode ?
                keymap_modes({ "n", "v" }, "<Plug>ROpenPDF", prefix .. "gp", {}) -- "<Cmd>lua require('r.pdf').open('Get Master')"  -- i-mode ?
                keymap_modes({ "n", "v" }, "<Plug>ROpenPDF", prefix .. "Op", {}) -- "<Cmd>lua require('r.pdf').open('Get Master')"  -- i-mode ?
                -- if config.synctex then  -- i-mode ?
                keymap_modes({ "n" }, "<Plug>SyncFor", prefix .. "gs", {}) -- "<Cmd>lua require('r.rnw').SyncTeX_forward(false)"  -- i-mode ?
                keymap_modes({ "n" }, "<Plug>GoToTeX", prefix .. "gt", {}) -- "<Cmd>lua require('r.rnw').SyncTeX_forward(true)"  -- i-mode ?
                keymap_modes({ "n" }, "<Plug>GoToTeX", prefix .. "Ot", {}) -- "<Cmd>lua require('r.rnw').SyncTeX_forward(true)"  -- i-mode ?
                -- end
              end,
            },
          },
          auto_rlang = {
            {
              event = {
                "FileType",
                "BufWinEnter",
                "BufRead",
                "BufNewFile",
                "BufNew",
                "BufAdd",
                "BufEnter",
                "TabNewEntered",
                "TabEnter",
              },
              pattern = {
                "R",
                "r",
                "rmd",
                "rnoweb",
                "quarto",
                "rhelp",
                "*.R",
                "*.r",
                "*.rmd",
                "*.qmd",
                "*.rnoweb",
                "*.quarto",
                "*.rhelp",
              },
              desc = "R-nvim",
              callback = function()
                local wk = require "which-key"
                wk.add {
                  mode = { "n", "v" },
                  { prefix, group = "󰟔 Rlang" }, -- Copy Glyphs from Oil! :-)
                  { "<localleader>", group = "󰟔 Rlang" }, -- Copy Glyphs from Oil! :-)
                  { "<localleader>b", group = " 󰟔 Between send" },
                  { "<localleader>c", group = " 󰟔 Chunk (md)" },
                  { "<localleader>f", group = " 󰟔 Functions send" },
                  { "<localleader>g", group = " 󰟔 Go to" },
                  { "<localleader>i", group = " 󰟔 Install" },
                  { "<localleader>k", group = " 󰟔 Knit" },
                  { "<localleader>p", group = " 󰟔 Paragraph send" },
                  { "<localleader>r", group = " 󰟔 " },
                  { "<localleader>s", group = " 󰟔 More send" },
                  { "<localleader>t", group = " 󰟔 Run (dput)" },

                  -- {prefix .. "m", group = '   Rmarkdown send'},
                  { prefix .. "g", group = " 󰟔 Go to" },
                  { prefix .. "O", group = " 󰟔 Open" },
                  { prefix .. "p", group = " 󰟔 Plots" },
                  -- { prefix .. "q", group = " 󰟔 Quarto" },
                  { prefix .. "x", group = " 󰟔 Execute / Send" },
                }
              end,
            },
          },
        },
        mappings = {
          n = {
            [prefix .. "k"] = { desc = "   Rmarkdown" },
            [prefix .. "V"] = { desc = " View Dataframe" },
          },
          v = {},
        },
      },
    },
  },
}
