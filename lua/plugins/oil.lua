---@type LazySpec
return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  init = function() -- start oil on startup lazily if necessary
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      ---@cast arg string
      local stat = (vim.uv or vim.loop).fs_stat(arg)
      local adapter = string.match(arg, "^([%l-]*)://")
      if (stat and stat.type == "directory") or adapter == "oil-ssh" then require "oil" end
    end
  end,
  opts = function()
    local get_icon, cmd = require("astroui").get_icon, require("astrocore").cmd
    local git_avail = vim.fn.executable "git" == 1
    return {
      columns = {
        { "icon", default_file = get_icon "DefaultFile", directory = get_icon "FolderClosed" },
      },
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      keymaps = {
        ["<Tab>"] = "actions.close",
      },
      view_options = {
        is_hidden_file = function(file, bufnr)
          local dir = git_avail and require("oil").get_current_dir(bufnr)
          if vim.startswith(file, ".") then
            if dir then -- show git tracked hidden files
              return cmd({ "git", "-C", dir, "ls-files", "--error-unmatch", file }, false) == nil
            else
              return true
            end
          end
          if dir then -- hide git untracked files
            return cmd(
              { "git", "-C", dir, "ls-files", "--error-unmatch", "--ignored", "--exclude-standard", "--others", file },
              false
            ) ~= nil
          else
            return false
          end
        end,
      },
    }
  end,
  specs = {
    { "nvim-neo-tree/neo-tree.nvim", optional = true, opts = { filesystem = { hijack_netrw_behavior = "disabled" } } },
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          neotree_start = false,
          oil_start = {
            {
              event = "BufNew",
              desc = "start oil when editing a directory",
              callback = function()
                if package.loaded["oil"] then
                  vim.api.nvim_del_augroup_by_name "oil_start"
                elseif vim.fn.isdirectory(vim.fn.expand "<afile>") == 1 then
                  require "oil"
                  vim.api.nvim_del_augroup_by_name "oil_start"
                end
              end,
            },
          },
          oil_settings = {
            {
              event = "FileType",
              desc = "Disable view saving for oil buffers",
              pattern = "oil",
              callback = function(args) vim.b[args.buf].view_activated = false end,
            },
            {
              event = "User",
              pattern = "OilActionsPost",
              desc = "Logic to run after an action in Oil",
              callback = function(args)
                if args.data.err then return end
                for _, action in ipairs(args.data.actions) do
                  ---@cast action oil.Action
                  if action.type == "delete" then
                    ---@cast action oil.DeleteAction
                    local _, path = require("oil.util").parse_url(action.url)
                    local bufnr = vim.fn.bufnr(path)
                    if bufnr ~= -1 then require("astrocore.buffer").wipe(bufnr, true) end
                  end
                end
              end,
            },
          },
        },
        mappings = {
          n = {
            -- ["<Tab>"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
            ["<Space>0"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
            ["<Space>f0"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
            ["<Space>fO"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
          },
        },
      },
    },
    { "AstroNvim/astroui", opts = { status = { winbar = { enabled = { filetype = { "^oil$" } } } } } },
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts)
        if opts.winbar then
          local status = require "astroui.status"
          table.insert(opts.winbar, 1, {
            condition = function(self) return status.condition.buffer_matches({ filetype = "^oil$" }, self.bufnr) end,
            status.component.separated_path {
              padding = { left = 2 },
              max_depth = false,
              suffix = false,
              path_func = function(self) return require("oil").get_current_dir(self.bufnr) end,
            },
          })
        end
      end,
    },
  },
}
