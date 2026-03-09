return {
	"NvChad/nvim-colorizer.lua",

	opts = {
		filetypes = {
			"css",
			"scss",
			"sass",
			"html",
			"htmldjango",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"lua",
		},

		options = { -- 🔥 AQUI está a diferença
			parsers = {
				css = true, -- ativa preset completo
			},

			display = {
				mode = "background",
			},
		},
	},
}
