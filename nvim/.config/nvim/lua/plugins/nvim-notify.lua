return {
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 2000,
				background_colour = "#000000",
				fps = 60,
			})

			-- Torna o notify padrão do Neovim
			vim.notify = require("notify")
		end,
	},
}
