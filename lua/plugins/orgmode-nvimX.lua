local prefix = "<Leader>o"

local file_gtd_actions = "gtd-actions.org"
file_path_gtd_actions = vim.g.dirPkd .. "/org/" .. file_gtd_actions
local cmd_open_org_actions = ":lua vim.cmd(':e ' .. file_path_gtd_actions)"

vim.api.nvim_create_user_command("OrgActions", cmd_open_org_actions, {})
vim.keymap.set("n", "<leader>oo", cmd_open_org_actions .. "<CR>", { noremap = true, desc = "Open gtd-actions" })

return {
  {
    "nvim-orgmode/orgmode",
    branch = "master",
    event = "VeryLazy",
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = vim.fn.has "unix" and vim.g.dirPkd .. "/**/*" or vim.g.dirPkd .. "/org/**",
        org_default_notes_file = file_path_gtd_actions, -- refile
        org_startup_folded = "showeverything", -- inherit, showeverything, content, overview
        org_capture_templates = { t = { description = "Task", template = "* TODO %?\nSCHEDULED: %t" } },
        mappings = {
          org_return_uses_meta_return = true,
          global = {
            org_agenda = { prefix .. "a" },
            org_capture = { prefix .. "c" },
          },
          org = {
            org_set_tags_command = prefix .. ":",
            org_todo = prefix .. "t",
            org_todo_prev = prefix .. "T",
            org_open_at_point = prefix .. "O",
          },
        },
      }
    end,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { desc = "Orgmode" },
            [prefix .. "b"] = { desc = "Tangle" }, -- ??
            [prefix .. "i"] = { desc = "Insert / change" },
            [prefix .. "l"] = { desc = "Lsp" },
            [prefix .. "x"] = { desc = "Clock effort" },
          },
        },
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          opts.autocmds.org_lists = {
            {
              event = "FileType",
              pattern = "org",
              desc = "Continue Org lists or exit empty items",
              callback = function(args)
                local function list_content()
                  local line = vim.api.nvim_get_current_line()
                  return line:match "^%s*[-+]%s+(.*)$"
                    or line:match "^%s+%*%s+(.*)$"
                    or line:match "^%s*%d+[.)]%s+(.*)$"
                end

                local function exit_empty_item(content)
                  if content and (vim.trim(content) == "" or content:match "^%[[ Xx%-]%]%s*$") then
                    vim.api.nvim_set_current_line ""
                    vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", 0 })
                    return true
                  end
                end

                local function is_task_line()
                  local line = vim.api.nvim_get_current_line()
                  local content = line:match "^%*+%s+(.*)$" or list_content() or vim.trim(line)
                  return content:match "^TODO%f[%W]" or content:match "^DONE%f[%W]"
                end

                vim.keymap.set("i", "<CR>", function()
                  if is_task_line() then
                    vim.api.nvim_feedkeys(vim.keycode "<CR>", "n", false)
                    return
                  end
                  if exit_empty_item(list_content()) then return end
                  require("orgmode").action "org_mappings.org_return"
                end, { buffer = args.buf, silent = true, desc = "Continue Org list or exit empty item" })

                vim.keymap.set("n", "o", function()
                  local content = list_content()
                  if is_task_line() then
                    vim.api.nvim_feedkeys("o", "n", false)
                  elseif exit_empty_item(content) then
                    vim.cmd.startinsert()
                  elseif content then
                    require("orgmode").action "org_mappings.meta_return"
                  else
                    vim.api.nvim_feedkeys("o", "n", false)
                  end
                end, { buffer = args.buf, silent = true, desc = "Open line or continue Org list" })
              end,
            },
          }
          opts.autocmds.org_treesitter = {
            {
              event = "FileType",
              pattern = "org",
              desc = "Enable Tree-sitter highlighting for Org",
              callback = function(args)
                vim.schedule(function()
                  if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == "org" then
                    vim.treesitter.start(args.buf)
                  end
                end)
              end,
            },
          }
        end,
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    enabled = false,
    dependencies = {
      {
        "nvim-orgmode/orgmode",
      },
    },
    config = function()
      require("org-roam").setup {
        directory = "~/orgfiles",
      }
    end,
  },
  {
    "nvim-orgmode/org-bullets.nvim",
    ft = "org",
    config = function()
      require("org-bullets").setup {
        concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
        symbols = {
          list = "•",
          headlines = { "◉", "○", "✸", "✿" }, -- headlines = false,
          checkboxes = {
            half = { "", "OrgTSCheckboxHalfChecked" },
            done = { "✓", "OrgDone" },
            todo = { " ", "OrgTODO" },
          },
        },
      }
    end,
  },
}
