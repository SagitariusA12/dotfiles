return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = true,
	keys = {
		-- Projeto inteiro
		{
			"<leader>S",
			function()
				require("spectre").toggle()
			end,
			desc = "Spectre: Search & replace (project)",
		},

		-- Palavra sob o cursor → projeto
		{
			"<leader>sw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Spectre: Replace word under cursor (project)",
			mode = "n",
		},

		-- Apenas no arquivo atual
		{
			"<leader>sof",
			function()
				require("spectre").open_file_search()
			end,
			desc = "Spectre: Replace in current file",
		},

		-- APENAS na seleção visual (ATUALIZADO E MELHORADO)
		{
			"<leader>ss",
			function()
				-- Sai do modo visual de forma segura
				local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
				vim.api.nvim_feedkeys(esc, "nx", false)

				-- Abre Spectre com a seleção atual
				require("spectre").open_visual()
			end,
			desc = "Spectre: Replace in visual selection",
			mode = { "v", "x" }, -- Suporta v, V, Ctrl-v
		},
	},
}
