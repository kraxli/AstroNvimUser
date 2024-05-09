return {
  {
    "2kabhishek/tdo.nvim",
    enabled = false, -- works only on linux / unix as it depends on tdo
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<leader>"] = {
                k = {
                  name = "Notes",
                  d = { "<cmd>Tdo<cr>", "Today's Todo" },
                  e = { "<cmd>TdoEntry<cr>", "Today's Entry" },
                  f = { "<cmd>TdoFiles<cr>", "All Notes" },
                  g = { "<cmd>TdoFind<cr>", "Find Notes" },
                  h = { "<cmd>Tdo -1<cr>", "Yesterday's Todo" },
                  j = { "<cmd>put =strftime('%a %d %b %r')<cr>", "Insert Human Date" },
                  J = { "<cmd>put =strftime('%F')<cr>", "Insert Date" },
                  k = { "<cmd>put =strftime('%r')<cr>", "Insert Human Time" },
                  K = { "<cmd>put =strftime('%F-%H-%M')<cr>", "Insert Time" },
                  l = { "<cmd>Tdo 1<cr>", "Tomorrow's Todo" },
                  t = { "<cmd>TdoTodos<cr>", "Incomplete Todos" },
                  n = { "<cmd>TdoNote<cr>", "New Note" },
                  s = {
                    '<cmd>lua require("tdo").run_with("commit " .. vim.fn.expand("%:p")) vim.notify("Commited!")<cr>',
                    "Commit Note",
                  },
                  x = { "<cmd>TdoToggle<cr>", "Toggle Todo" },
                },
              },
            },
            -- i = {},
          },
        },
      },
    },
    cmd = { "Tdo", "TdoEntry", "TdoNote", "TdoTodos", "TdoToggle", "TdoFind", "TdoFiles" },
    keys = { "[t", "]t" },
    config = function()
      vim.env.NOTES_DIR = "~/Dropbox/PKD/"
      vim.env.TODOS_DIR = "~/Dropbox/PKD/"
    end,
  },
  {
    "opdavies/toggle-checkbox.nvim",
    enabled = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>tt"] = { "<Cmd>lua require('toggle-checkbox').toggle()<CR>", desc = "Toggle checkbox" },
            ["<c-space>"] = { "<Cmd>lua require('toggle-checkbox').toggle()<CR>", desc = "Toggle checkbox" },
          },
          x = {
            ["<Leader>tt"] = { "<Cmd>lua require('toggle-checkbox').toggle()<CR>", desc = "Toggle checkbox" },
            ["<c-space>"] = { "<Cmd>lua require('toggle-checkbox').toggle()<CR>", desc = "Toggle checkbox" },
          },
        },
      },
    },
  },
  {
    "tadachs/zettel.nvim",
    enabled = false,
    config = true,
    opts = {
      root_dir = "~/Dropbox/PKD", -- root dir for notes
      format = "md", -- file ending for notes
      link_pattern = "%[%[([^%]]+)%]%]", -- pattern for matching links
      tag_pattern = "#([%w%-%_]+)", -- pattern for matching tags
      title_pattern = "^# (.*)$", -- pattern for matching title of file
      open_cmd = "edit", -- command used for opening files
    },
    cond = function() -- so it only gets loaded in the note directory
      local current_file_path = vim.api.nvim_buf_get_name(0)
      return current_file_path:match ".*/PKD.*"
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
}

-- https://github.com/Furkanzmc/zettelkasten.nvim
-- https://github.com/taDachs/zettel.nvim
-- https://github.com/lervag/wiki.vim
-- https://github.com/2KAbhishek/tdo.nvim
