return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		-- Salto normal (modo n, x, o)
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},

		-- Buscar palavra sob o cursor
		{
			"S",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},

		-- Repetir último salto
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
	},
}
