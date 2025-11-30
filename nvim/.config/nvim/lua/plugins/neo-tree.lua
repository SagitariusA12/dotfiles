return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- Setup do neo-tree com handler para fechar ao abrir arquivo
			require("neo-tree").setup({
				-- Mostrar arquivos ocultos
				filesystem = {
					filtered_items = {
						hide_dotfiles = false, -- false = mostrar arquivos iniciados com .
						hide_gitignored = false, -- opcional, mostrar arquivos gitignored
					},
				},
				event_handlers = {
					{
						event = "file_open_requested",
						handler = function()
							-- Fecha o neo-tree automaticamente ao abrir um arquivo
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
			})

			-- Mapeamentos para abrir/fechar manualmente
			vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>nf", ":Neotree close<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
}
