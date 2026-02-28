return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		filetypes = {
			"css", "scss", "sass",
			"html", "htmldjango",
			"javascript", "javascriptreact",
			"typescript", "typescriptreact",
			"lua",
		},
		user_default_options = {
			RGB      = true,
			RRGGBB   = true,
			names    = true,
			RRGGBBAA = true,
			css      = true,
			mode     = "background", -- "background" | "foreground" | "virtualtext"
		},
	},
}
