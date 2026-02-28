return {
	"lewis6991/satellite.nvim",
	event = "BufReadPost",
	opts = {
		current_only = false,
		winblend     = 50,
		zindex       = 40,
		excluded_filetypes = { "neo-tree", "alpha", "toggleterm", "nofile" },
		handlers = {
			cursor     = { enable = true },
			diagnostic = { enable = true, signs = { "-", "=", "≡" } },
			gitsigns   = { enable = true },
			marks      = { enable = false },
			search     = { enable = true },
		},
	},
}
