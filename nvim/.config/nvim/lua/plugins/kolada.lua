-- lua/plugins/kolada.lua
-- Carrega o tema Kolada local via lazy.nvim
return {
	-- Plugin "virtual" apontando para o diretório local da config
	dir = vim.fn.stdpath("config"),
	name = "kolada",
	lazy = false,
	priority = 1000,
	config = function()
		require("themes.kolada").setup()
		vim.cmd.colorscheme("kolada")
	end,
}
