return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			-- Setup do notify (backend visual)
			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 3000,
				background_colour = "#000000",
				top_down = false,
			})

			vim.notify = require("notify")

			require("noice").setup({
				lsp = {
					progress = { enabled = true },
					hover = { enabled = true },
					signature = { enabled = true },
				},

				messages = {
					enabled = true,
				},

				popupmenu = {
					enabled = true,
				},

				notify = {
					enabled = true,
					view = "notify",
				},

				views = {
					notify = {
						position = {
							row = -1,
							col = -1,
						},
						size = {
							width = "40%",
						},
					},

					cmdline_popup = {
						position = {
							row = "40%",
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
						border = {
							style = "rounded",
						},
					},
				},

				routes = {
					-- Mensagens muito grandes vão pro centro
					{
						filter = {
							event = "notify",
							min_height = 10,
						},
						view = "popup",
					},
				},
			})
		end,
	},
}
