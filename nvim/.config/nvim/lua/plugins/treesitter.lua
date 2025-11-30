return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"harrisoncramer/jump-tag",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Linguagens instaladas
				ensure_installed = {
					"html",
					"javascript",
					"lua",
					"python",
					"css",
					"json",
					"bash",
					"markdown",
					"typescript",
					"tsx",
				},
				-- Ativar highlight e indentação
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" }, -- Para melhor suporte a markdown
				},
				indent = {
					enable = true,
					disable = { "python" }, -- Python tem indentação própria que pode conflitar
				},
				-- Instalar parsers automaticamente
				auto_install = true,
				-- Configuração do textobjects
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Move automaticamente para o próximo textobject
						keymaps = {
							["at"] = { query = "@tag.outer", desc = "Select around tag" },
							["it"] = { query = "@tag.inner", desc = "Select inner tag" },
							["an"] = { query = "@tag.name", desc = "Select tag name" },
							["aa"] = { query = "@attribute.name", desc = "Select attribute name" },
							["av"] = { query = "@attribute.value", desc = "Select attribute value" },
							["ix"] = { query = "@text.inner", desc = "Select inner text" },
						},
						-- Seleção incremental para alternar entre diferentes textobjects
						selection_modes = {
							["@tag.outer"] = "V", -- Usa modo linha para tags completas
							["@tag.inner"] = "v", -- Usa modo caractere para conteúdo interno
							["@tag.name"] = "v",
							["@attribute.name"] = "v",
							["@attribute.value"] = "v",
							["@text.inner"] = "v",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- Adiciona movimentos ao jumplist
						goto_next_start = {
							["]t"] = { query = "@tag.outer", desc = "Next tag start" },
							["]a"] = { query = "@attribute.name", desc = "Next attribute start" },
							["]x"] = { query = "@text.inner", desc = "Next text start" },
						},
						goto_previous_start = {
							["[t"] = { query = "@tag.outer", desc = "Previous tag start" },
							["[a"] = { query = "@attribute.name", desc = "Previous attribute start" },
							["[x"] = { query = "@text.inner", desc = "Previous text start" },
						},
						goto_next_end = {
							["]T"] = { query = "@tag.outer", desc = "Next tag end" },
						},
						goto_previous_end = {
							["[T"] = { query = "@tag.outer", desc = "Previous tag end" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>sn"] = { query = "@tag.outer", desc = "Swap with next tag" },
							["<leader>sa"] = { query = "@attribute.name", desc = "Swap with next attribute" },
						},
						swap_previous = {
							["<leader>sp"] = { query = "@tag.outer", desc = "Swap with previous tag" },
							["<leader>sA"] = { query = "@attribute.name", desc = "Swap with previous attribute" },
						},
					},
				},
			})

			-- Configuração do jump-tag
			vim.keymap.set("n", "t<C-d>", ":JumpTagJump<CR>", { desc = "Jump to matching tag" })
			vim.keymap.set("i", "<C-t>", "<Esc>:JumpTagInsert<CR>a", { desc = "Insert closing tag" })
			vim.keymap.set("n", "<leader>jt", ":JumpTagJump<CR>", { desc = "Jump to matching tag" })
			vim.keymap.set("n", "<leader>ct", ":JumpTagInsert<CR>", { desc = "Insert closing tag" })

			-- Atalhos adicionais para navegação rápida
			vim.keymap.set("n", "<leader>tn", "]t", { desc = "Go to next tag", remap = true })
			vim.keymap.set("n", "<leader>tp", "[t", { desc = "Go to previous tag", remap = true })
		end,
	},
}
