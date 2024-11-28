local prefix = "<Leader>r"
local localleader = "<LocalLeader>"

-- -------------------------------------------------------
-- Set OS specific variables
-- -------------------------------------------------------
local r_path = '/usr/bin'
local csv_app = ':TermExec cmd="vd %s" direction=float name=visidataTerm'
local pdfviewer = ''  -- use default pdfviewer

-- for graphical R devices see: https://bookdown.org/rdpeng/exdata/graphics-devices.html
local graphical_device = 'X11'

if vim.fn.has('win64') == 1 then
  r_path = "C:\\Program Files\\R\\R-4.3.1\\bin\\x64"
  -- csv_app = "terminal:vd"
  graphical_device = 'windows'
  pdfviewer = 'mupdf'  -- or sumatra
end

-- -------------------------------------------------------
-- Local functions
-- -------------------------------------------------------
local function keymap_modes (modes, command, keymap, opts)
  for _, mode in ipairs(modes) do
    vim.api.nvim_buf_set_keymap(0, mode, keymap, command, opts)
  end
end

function set_csv_app(app, mode, args)
  local default_app = require("r.config").get_config().csv_app
  require("r.config").get_config().csv_app = app
  require('r.run').action('viewobj', mode, args )
  -- require("r.config").get_config().csv_app = default_app
  return default_app
end
-- vim.api.nvim_buf_set_keymap(0, "n", <localleader>Vt, set_csv_app("terminal:vd", "n", ''), {})
-- keymap_modes({"n"}, '<cmd>lua app = set_csv_app("terminal:vd", "n", ''); require("r.config").get_config().csv_app = app<CR>', prefix .. "Vt", {})

-- -------------------------------------------------------

return {
  {
    "hrsh7th/nvim-cmp",
    -- optional = true,
    ft = { "R", "r", "rmd", "rnoweb", "quarto", "rhelp" },
    dependencies = { "R-nvim/cmp-r" },
    opts = function(_, opts)
      if not opts.sources then opts.sources = {} end
      table.insert(opts.sources, {
        { name = "cmp_r", priority = 800 },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(plugin, opts) table.insert(opts.ensure_installed, { "r", "markdown", "rnoweb", "yaml" }) end,
  },
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
        R_path = r_path,  -- vim.g.r_path
        R_args = { "--quiet", },
        min_editor_width = 72,
        rconsole_width = 78,
        pdfviewer = pdfviewer,
        disable_cmds = {},
        nvimpager = "split_v",
        view_df = {
            n_lines = 0,
            save_fun = "function(obj, obj_name) {f <- paste0(obj_name, '.parquet'); arrow::write_parquet(obj, f) ; f}",
            -- open_app = "terminal:vd",
            open_app = csv_app,
        },
        -- csv_app = csv_app,
        -- ,,:                |>
        -- <m--> / Alt + -:   <-
        user_maps_only = false,
        assignment_keymap = "<m-->",
        pipe_keymap = ',,',

        hook = {
          on_filetype = function()

            -- -- httpgd, see:https://github.com/R-nvim/R.nvim/wiki/Configuration#using-httpgd-as-the-default-graphics-device
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "gd", "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>", {desc='httpgd'})
            -- vim.api.nvim_buf_set_keymap(0, "n",  "<localleader>gd", "<cmd>lua require('r.send').cmd('tryCatch({dev.off(); options(device = httpgd::hgd); httpgd::hgd_browse(); dev.off(); options(device = X11)}, error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>", {desc='httpgd'})

            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})
            -- vim.api.nvim_buf_set_keymap(0, "n", prefix .. "L", "<Cmd>lua require('r.run').action('levels')<CR>", {})
            --
-- vim.api.nvim_buf_set_keymap(0, "n", "<localleader>rv", set_csv_app('<cmd>TermExec cmd="vd %s" direction=float<CR>', "n", ''), {})

            -- send
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {desc='Send line'})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {desc='Send selection'})
            vim.api.nvim_buf_set_keymap(0, "n", prefix .. "s", "<Plug>RDSendLine", {desc='Send line'})
            vim.api.nvim_buf_set_keymap(0, "v", prefix .. "s", "<Plug>RSendSelection", {desc='Send selection'})
            -- TODO: send motions!

            -- edit & operators
            -- vim.api.nvim_buf_set_keymap(0, "i", "<Plug>RAssign", '<Cmd>lua require("r.edit").assign()<CR>', { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "--", "<Plug>RAssign", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "__", "<Plug>RAssign", { silent = true, noremap = true, expr = false })
            -- vim.api.nvim_buf_set_keymap(0, "i", "<Plug>RPipe", '<Cmd>lua require("r.edit").pipe()<CR>', { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "<<", "<Plug>RPipe", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "<m-.>", "<Plug>RPipe", { silent = true, noremap = true, expr = false })
            vim.api.nvim_buf_set_keymap(0, "i", "<m-,>", "<Plug>RPipe", { silent = true, noremap = true, expr = false })
            -- TODO:
            -- keymap_modes({"n", "i", "v"}, "RSetwd", "rd",  {})  -- "<Cmd>lua require('r.run').setwd()"
            -- keymap_modes({"n", "i", "v"}, "RSeparatePath", {})  --    "sp", "<Cmd>lua require('r.path').separate()"
            --
            -- -- Format functions (no need to change defaults)
            -- create_maps("nvi", "RFormatNumbers",    "cn", "<Cmd>lua require('r.format.numbers').formatnum()")
            -- create_maps("nvi", "RFormatSubsetting",    "cs", "<Cmd>lua require('r.format.brackets').formatsubsetting()")

            -- Start
            -- keymap_modes({"n","v","i"}, "<Plug>RStart", prefix .. "r", {})
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').start_R('R')<CR>", prefix .. "r", {desc='R start'})
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').start_R('custom')<CR>", prefix .. "R", {desc='R custom start'})

            -- Close
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').quit_R('nosave')<CR>", prefix .. "q", {desc='R close'})
            keymap_modes({"n", "i", "v"}, "<Cmd>lua require('r.run').quit_R('save')<CR>", prefix .. "w", {desc='R save & close'})

            keymap_modes({"n","v","i"}, "<Plug>RClearConsole", prefix .. "c", {})
            keymap_modes({"n","v","i"}, "<Plug>RClearAll", prefix .. "C", {})

            -- Print,          names,               structure
            keymap_modes({"n", "i", "v"},  "<Plug>RObjectPr",         prefix .. "p", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RObjectNames",      prefix .. "n", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RObjectStr",        prefix .. "t", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDF",           prefix .. "v", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RDputObj",          "<leader>td", {})

            keymap_modes({"n", "i"}, "<Plug>RPackages",          prefix .. "P", {})

            keymap_modes({"n", "i", "v"},  "<Plug>RViewDF",   prefix .. "v", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDFs",   prefix .. "Vs", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDFv",   prefix .. "Vv", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RViewDFa",   prefix .. "Vh", {})

            -- keymap_modes({"n"}, '<cmd>lua app = set_csv_app("terminal:vd"); require("r.config").get_config().csv_app = app<CR>', prefix .. "Vt", {})

            -- Arguments,      example,      help
            keymap_modes({"n", "v", "i"}, "<Plug>RShowArgs",  prefix .. "a", {})
            keymap_modes({"n", "v", "i"}, "<Plug>RShowEx",    prefix .. "e", {})
            keymap_modes({"n", "v", "i"}, "<Plug>RHelp",      prefix .. "h", {})

            -- Summary,        plot,       both
            keymap_modes({"n", "i", "v"},  "<Plug>RSummary",   prefix .. "S", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RPlot",      prefix .. "pp", {})
            keymap_modes({"n", "i", "v"},  "<Plug>RSPlot",     prefix .. "ps", {})

            -- Object Browser
            keymap_modes({"n", "v", "i"}, "<Plug>ROBToggle",       prefix .. "o", {})
            keymap_modes({"n", "v", "i"}, "<Plug>ROBOpenLists",   prefix .. "=", {})
            keymap_modes({"n", "v", "i"}, "<Plug>ROBCloseLists",  prefix .. "-", {})

            -- Render script with rmarkdown
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeRmd",   prefix .. "kr", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeAll",   prefix .. "ka", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakePDFK",  prefix .. "kp", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakePDFKb", prefix .. "kl", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeWord",  prefix .. "kw", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeHTML",  prefix .. "kh", {})
            keymap_modes({ "n", "v", "i" }, "<Plug>RMakeODT",   prefix .. "ko", {})


            -- Send block
            keymap_modes({"n", "i"},  "<Cmd>lua require('r.send').marked_block(false)<CR>",   "bb", {}) -- "<Plug>RSendMBlock<CR>"
            keymap_modes({"n", "i"},  "<Cmd>lua require('r.send').marked_block(true)<CR>",  "bd", {}) -- "<Plug>RDSendMBlock<CR>"

            -- -- Function
            -- keymap_modes({"n", "i", "v"}, "<Plug>RSendAllFun",    "fa",     {})  -- "<Cmd>lua require('r.send').funs(0, true, false)"
            -- keymap_modes({"n", "i", "v"}, "<Plug>RSendCurrentFun",   "fc",  {})  -- "<Cmd>lua require('r.send').funs(0, false, false)"
            -- keymap_modes({"n", "i", "v"}, "<Plug>RDSendCurrentFun",   "fd", {})  -- "<Cmd>lua require('r.send').funs(0, false, true)"
            --
            -- -- Pipe chain breaker
            -- keymap_modes({"n", "v"}, "RSendChain",      "sc",  {})  -- "<Cmd>lua require('r.send').chain()"
            --
            -- -- Selection
            -- keymap_modes({"n", "v"}, "RSendSelection",  "ss", {})  -- "<Cmd>lua require('r.send').selection(false)"
            -- keymap_modes({"n", "v"}, "RDSendSelection", "sd", {})  -- "<Cmd>lua require('r.send').selection(true)"
            --
            -- -- Paragraph
            keymap_modes({"n", "i"}, "<Cmd>lua require('r.send').paragraph(false)<CR>",  prefix .. "pp", {})  -- "RSendParagraph"; i mode ? 
            keymap_modes({"n", "i"}, "<Cmd>lua require('r.send').paragraph(false)<CR>",  "pp", {})  -- "RSendParagraph"; i mode ? 
            keymap_modes({"n", "i"}, "<Cmd>lua require('r.send').paragraph(true)<CR>", prefix .. "pd", {})  --   RDSendParagraph; i mode ?
            keymap_modes({"n", "i"}, "<Cmd>lua require('r.send').paragraph(true)<CR>","pd", {})  --   RDSendParagraph; i mode ?
            --
            -- -- *Line*
            -- keymap_modes({"n", "i"},  "RSendLine",           "l",    {})  --    "<Cmd>lua require('r.send').line(false)")
            -- keymap_modes({"n", "i"},  "RDSendLine",          "d",    {})  --    "<Cmd>lua require('r.send').line(true)")
            -- keymap_modes({"n", "i"},  "RInsertLineOutput",   "o",    {})  --    "<Cmd>lua require('r.run').insert_commented()")
            -- keymap_modes({"n", "i", "."}, "RSendMotion",     "m",    {})  --    "<Cmd>set opfunc=v:lua.require'r.send'.motion<CR>g@", true)
            -- keymap_modes({"v"},   "RInsertLineOutput",   "o",        {})  --"<Cmd>lua require('r').warn('This command does not work over a selection of lines.')")
            -- keymap_modes({"i"},   "RSendLAndOpenNewOne", "q",        {})  --"<Cmd>lua require('r.send').line('newline')")
            -- keymap_modes({"n"},   "RNLeftPart",          "r<left>",  {})  --"<Cmd>lua require('r.send').line_part('left',  false)")
            -- keymap_modes({"n"},   "RNRightPart",         "r<right>", {})  --"<Cmd>lua require('r.send').line_part('right', false)")
            -- keymap_modes({"i"},   "RILeftPart",          "r<left>",  {})  --"<Cmd>lua require('r.send').line_part('left',  true)")
            -- keymap_modes({"i"},   "RIRightPart",         "r<right>", {})  --"<Cmd>lua require('r.send').line_part('right', true)")
            --
            -- -- TODO: clean up and file type specific commands
            --
            --   if file_type == "r" then
            --       keymap_modes({"n"},   "RSendAboveLines", "su", {})  -- "<Cmd>lua require('r.send').above_lines()"
                  keymap_modes({"n", "i"},  "<Cmd>lua require('r.send').source_file()<CR>", "aa", {})  -- "RSendFile"
                  keymap_modes({"n", "i"},  "<Cmd>lua require('r.send').source_file()<CR>", prefix .. 'f', {desc="Send file"})  -- "RSendFile"
                  keymap_modes({"n", "i"},  "<Cmd>lua require('r').show_R_out()<CR>", "ao", {})  -- "RshowRout"
                  keymap_modes({"n", "i"},  "<Cmd>lua require('r').show_R_out()<CR>", prefix .. "O", {desc="Show R out"})  -- "RshowRout"
            --   end
            --   -- if file_type == "rmd" or file_type == "quarto" then
            --       keymap_modes({"n", "v", "i"}, "RKnit",           "kn", {})  -- "<Cmd>lua require('r.run').knit()"
                  keymap_modes({"n", "i"},  "<Plug>RSendChunk",      prefix .. "C", {})  -- "<Cmd>lua require('r.rmd').send_R_chunk(false)"
                  keymap_modes({"n", "i"},  "<Plug>RDSendChunk",     prefix .. "c", {})  -- "<Cmd>lua require('r.rmd').send_R_chunk(true)"
                  keymap_modes({"n"},   "<Plug>RNextRChunk",     prefix .. "mn", {})  -- "<Cmd>lua require('r.rmd').next_chunk()"
                  keymap_modes({"n"},   "<Plug>RPreviousRChunk", prefix .. "mN", {})  -- "<Cmd>lua require('r.rmd').previous_chunk()"
            --   -- end
            --   -- if file_type == "rnoweb" or file_type == "rmd" or file_type == "quarto" then
                  keymap_modes({"n", "i"}, "<Plug>RSendChunkFH", prefix .. "mh", {})  -- "<Cmd>lua require('r.send').chunks_up_to_here()"
            --   -- if config.rm_knit_cache then
            --           keymap_modes({"n", "v", "i"}, "RKnitRmCache", "kc", {})  -- "<Cmd>lua require('r.rnw').rm_knit_cache()"
            --       -- end
            --   -- end
            --   -- if file_type == "quarto" then
            --       keymap_modes({"n"},   "RQuartoRender",   "qr", {})  -- "<Cmd>lua require('r.quarto').command('render')"
            --       keymap_modes({"n"},   "RQuartoPreview",  "qp", {})  -- "<Cmd>lua require('r.quarto').command('preview')"
            --       keymap_modes({"n"},   "RQuartoStop",     "qs", {})  -- "<Cmd>lua require('r.quarto').command('stop')"
            --   -- end
            --   -- if file_type == "rnoweb" then
            --       keymap_modes({"n", "v", "i"}, "RSweave",         "sw", {})  -- "<Cmd>lua require('r.rnw').weave('nobib',  false, false)"
            --       keymap_modes({"n", "v", "i"}, "RMakePDF",        "sp", {})  -- "<Cmd>lua require('r.rnw').weave('nobib',  false, true)"
            --       keymap_modes({"n", "v", "i"}, "RBibTeX",         "sb", {})  -- "<Cmd>lua require('r.rnw').weave('bibtex', false, true)"
            --       keymap_modes({"n", "v", "i"}, "RKnit",        "kn", {})  -- "<Cmd>lua require('r.rnw').weave('nobib',  true, false)"
            --       keymap_modes({"n", "v", "i"}, "RMakePDFK",    "kp", {})  -- "<Cmd>lua require('r.rnw').weave('nobib',  true, true)"
            --       keymap_modes({"n", "v", "i"}, "RBibTeXK",     "kb", {})  -- "<Cmd>lua require('r.rnw').weave('bibtex', true, true)"
            --       keymap_modes({"n", "i"},  "RSendChunk",   "cc", {})  -- "<Cmd>lua require('r.rnw').send_chunk(false)"
            --       keymap_modes({"n", "i"},  "RDSendChunk",  "cd", {})  -- "<Cmd>lua require('r.rnw').send_chunk(true)"
            --       keymap_modes({"n", "v", "i"}, "ROpenPDF",     "op", {})  -- "<Cmd>lua require('r.pdf').open('Get Master')"
            --   -- if config.synctex then
            --           keymap_modes({"n", "i"}, "RSyncFor", "gp", {})  -- "<Cmd>lua require('r.rnw').SyncTeX_forward(false)"
            --           keymap_modes({"n", "i"}, "RGoToTeX", "gt", {})  -- "<Cmd>lua require('r.rnw').SyncTeX_forward(true)"
            --       -- end
            --       keymap_modes({"n"}, "RNextRChunk",     "gn", {})  -- "<Cmd>lua require('r.rnw').next_chunk()"
            --       keymap_modes({"n"}, "RPreviousRChunk", "gN", {})  -- "<Cmd>lua require('r.rnw').previous_chunk()"
            --   -- end
            --   -- if file_type == "rdoc" then
            --       vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>quit<CR>",
            --           { silent = true, noremap = true, expr = false, desc = "Close this window" })
            --   -- end


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
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
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
                }
              end,
            },
          },
        },
        mappings = {
          n = {
            [prefix .. "k"] = { desc = "  Rmarkdown" },
            [prefix .. "V"] = { desc = " View Dataframe" },
          },
          v = {},
        },
      },
    },
  },
}
