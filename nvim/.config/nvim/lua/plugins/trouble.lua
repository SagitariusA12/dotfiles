return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Trouble: diagnósticos do projeto" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: diagnósticos do buffer" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",       desc = "Trouble: símbolos" },
		{ "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>",           desc = "Trouble: referências LSP" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Trouble: quickfix list" },
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>",                     desc = "Trouble: TODOs" },
	},
	opts = {},
}
