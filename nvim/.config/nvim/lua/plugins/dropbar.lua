return {
	"Bekaboo/dropbar.nvim",
	event = { "BufReadPost", "BufNewFile" },

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	keys = {
		{
			"<leader>;",
			function()
				require("dropbar.api").pick()
			end,
			mode = "n",
			desc = "Dropbar Pick",
		},
		{
			"[;",
			function()
				require("dropbar.api").goto_context_start()
			end,
			mode = "n",
			desc = "Context Start",
		},
		{
			"];",
			function()
				require("dropbar.api").select_next_context()
			end,
			mode = "n",
			desc = "Next Context",
		},
	},

	opts = {},
}
