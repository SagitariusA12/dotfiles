return {
	"mrjones2014/legendary.nvim",
	version = "^2.1.0",
	dependencies = {
		"kkharji/sqlite.lua", -- opcional, melhora a performance
		"stevearc/dressing.nvim", -- opcional, deixa visual mais bonito
	},
	config = function()
		require("legendary").setup({
			include_builtin = true, -- inclui comandos padrão do Neovim
			include_legendary_cmds = true,
		})

		-- ⚡ substitui os dois-pontos por Legendary
		vim.keymap.set("n", "<leader>p", "<cmd>Legendary<CR>", {
			noremap = true,
			silent = true,
			desc = "Abrir Command Palette (Legendary)",
		})
	end,
}
