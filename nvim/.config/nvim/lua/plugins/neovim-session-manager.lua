return {
	"Shatur/neovim-session-manager",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local config = require("session_manager.config")
		require("session_manager").setup({
			sessions_dir = vim.fn.stdpath("data") .. "/sessions",
			autoload_mode = config.AutoloadMode.Disabled, -- <-- objeto, não string
			autosave_last_session = false,
			autosave_ignore_not_normal = true,
			autosave_ignore_buftypes = { "nofile", "prompt", "quickfix", "terminal" },
			autosave_ignore_filetypes = { "gitcommit", "gitrebase" },
		})
		vim.defer_fn(function()
			local ok, telescope = pcall(require, "telescope")
			if ok then
				pcall(telescope.load_extension, "session-manager")
			end
		end, 100)
	end,
}
