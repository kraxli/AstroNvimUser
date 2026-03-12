---@type LazySpec
return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = "gemini",
    provider_options = {
      gemini = {
        model = "gemini-2.5-flash",
        api_key = "GEMINI_API_KEY",
      },
    },
  },
}
