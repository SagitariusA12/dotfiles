return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		signs = true,
		keywords = {
			FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
			PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		},
	},
	keys = {
		{ "]t",          function() require("todo-comments").jump_next() end, desc = "Próximo TODO" },
		{ "[t",          function() require("todo-comments").jump_prev() end, desc = "TODO anterior" },
		{ "<leader>ft",  "<cmd>TodoTelescope<cr>",                           desc = "TODO: buscar no projeto" },
		{ "<leader>fT",  "<cmd>TodoTrouble<cr>",                             desc = "TODO: abrir no Trouble" },
	},
}
