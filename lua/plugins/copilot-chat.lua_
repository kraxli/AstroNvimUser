return {
  "CopilotC-Nvim/CopilotChat.nvim",
  enabled = false, -- environment == "work",
  branch = "main",
  cmd = "CopilotChat",
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      model = "auto",    -- Default model to use (run :CopilotChatModels to see available options)
      temperature = 0.1,   -- Lower values (e.g., 0.1) are more focused and precise; higher values are more creative
      auto_insert_mode = true,
      headers = {
        user = "  " .. user .. " ",
        assistant = "  Copilot ",
        tool = "󰊳  Tool ",
      },
      window = {
        width = 0.4,
      },
    }
  end,
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
    {
      "<leader>aa",
      function() return require("CopilotChat").toggle() end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "x" },
    },
    {
      "<leader>ax",
      function() return require("CopilotChat").reset() end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "x" },
    },
    {
      "<leader>aq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input ~= "" then require("CopilotChat").ask(input) end
        end)
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "x" },
    },
    {
      "<leader>ap",
      function() require("CopilotChat").select_prompt() end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "x" },
    },
  },
  config = function(_, opts)
    local chat = require "CopilotChat"

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    chat.setup(opts)
  end,
  specs = {
    {
      "saghen/blink.cmp",
      optional = true,
      dependencies = { "CopilotC-Nvim/CopilotChat.nvim" },
      -- opts = function(_, opts)
      --   if not opts.keymap then opts.keymap = {} end
      --   opts.keymap["<M-CR>"] = { function() return require("CopilotChat").submit() end }
      -- end,
      opts = {
        -- sources = {
        --   per_filetype = {
        --     copilot_chat = { "copilot_chat" },
        --   },
        -- },
        sources = {
          providers = {
            path = {
              -- Path sources triggered by "/" interfere with CopilotChat commands
              enabled = function() return vim.bo.filetype ~= "copilot-chat" end,
            },
          },
        },
      },
    },
  },
}
