
if environment ~= 'work' then
  provider = {provider = 'gemini', model = "gemini-2.5-flash", api_key = "GEMINI_API_KEY"}
  -- provider = {provider = 'openai',         model = "mistral-large-latest", api_key = "MISTRAL_API_KEY", endpoint = "https://api.mistral.ai/v1/" }
end
-- model = "codestral-latest",

---@type LazySpec
return {
  "milanglacier/minuet-ai.nvim",
  enabled = environment ~= 'work',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = provider['provider'],
    provider_options = {
      gemini = {
        model = provider["model"],
        end_point = provider['endpoint'],
        api_key = provider['api_key'],
      },
    },
  },
}

