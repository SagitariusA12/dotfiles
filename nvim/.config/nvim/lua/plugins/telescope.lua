return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
			})

			-- Diretório do arquivo atual
			local function current_dir()
				return vim.fn.expand("%:p:h")
			end

			local function find_local_files()
				builtin.find_files({
					cwd = current_dir(),
					hidden = true,
				})
			end

			local function live_grep_local()
				builtin.live_grep({
					cwd = current_dir(),
					additional_args = function()
						return { "--hidden" }
					end,
				})
			end

			vim.keymap.set("n", "<leader>ff", find_local_files)
			vim.keymap.set("n", "<leader>fg", live_grep_local)
			vim.keymap.set("n", "<leader>fb", builtin.buffers)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<C-p>", find_local_files)
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles)
		end,
	},
}
