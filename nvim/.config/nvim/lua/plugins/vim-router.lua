return {
	"airblade/vim-rooter",
	keys = {
		{ "<leader>cr", "<cmd>Rooter<CR>", desc = "Ir para a raiz do projeto" },
	},
	init = function()
		vim.g.rooter_patterns = { ".git", ".hg", ".svn" }
		vim.g.rooter_silent_chdir = 1
		vim.g.rooter_manual_only = 1
	end,
}
