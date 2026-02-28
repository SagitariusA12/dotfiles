return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		opts = {
			enable_close          = true,   -- fecha tag ao digitar >
			enable_rename         = true,   -- renomeia par ao editar tag
			enable_close_on_slash = true,   -- fecha ao digitar </
		},
	},
}
