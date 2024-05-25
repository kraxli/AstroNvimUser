return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = function()
			return not (vim.bo.filetype == "markdown" and vim.fn.has("win64") == 1)  -- jit.os:find("Windows")
		end,
	},
}
