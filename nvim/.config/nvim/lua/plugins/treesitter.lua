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
					"c",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
				indent = {
					enable = true,
					disable = { "python" },
				},
				auto_install = true,
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["at"] = { query = "@tag.outer", desc = "Select around tag" },
							["it"] = { query = "@tag.inner", desc = "Select inner tag" },
							["an"] = { query = "@tag.name", desc = "Select tag name" },
							["aa"] = { query = "@attribute.name", desc = "Select attribute name" },
							["av"] = { query = "@attribute.value", desc = "Select attribute value" },
							["ix"] = { query = "@text.inner", desc = "Select inner text" },
						},
						selection_modes = {
							["@tag.outer"] = "V",
							["@tag.inner"] = "v",
							["@tag.name"] = "v",
							["@attribute.name"] = "v",
							["@attribute.value"] = "v",
							["@text.inner"] = "v",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
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

			-- Atalhos de navegação de tags (sem conflitar com toggleterm <leader>tn)
			vim.keymap.set("n", "<leader>tj", "]t", { desc = "Go to next tag", remap = true })
			vim.keymap.set("n", "<leader>tk", "[t", { desc = "Go to previous tag", remap = true })
		end,
	},
}
