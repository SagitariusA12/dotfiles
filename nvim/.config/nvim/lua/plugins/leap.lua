return {
	"ggandor/leap.nvim",
	lazy = false,
	config = function()
		require("leap").setup({})

		-- Mapeamentos padrão “manual”
		local map = vim.keymap.set
		map("n", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
		map("n", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
		map("x", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
		map("x", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
		map("o", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
		map("o", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
	end,
}
