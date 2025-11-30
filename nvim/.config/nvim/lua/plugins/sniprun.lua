return {
	"michaelb/sniprun",
	build = "sh install.sh",
	opts = {
		display = { "Classic", "VirtualTextOk" },
		live_mode_toggle = "enable_live_mode",
	},
	cmd = "SnipRun",
	keys = {
		-- Executa o buffer inteiro no modo normal
		{
			"<leader>rp",
			function()
				vim.cmd("normal! ggVG")
				vim.cmd("SnipRun")
			end,
			mode = "n",
			desc = "Executar todo o buffer com SnipRun",
		},

		-- Executa apenas a seleção visual
		{
			"<leader>rp",
			"<Plug>SnipRun",
			mode = "v",
			desc = "Executar seleção com SnipRun",
		},
	},
}
