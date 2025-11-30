return {
	"Shatur/neovim-session-manager",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	event = "BufReadPost", -- Load after VimEnter to avoid early initialization
	config = function()
		local config = require("session_manager.config")
		require("session_manager").setup({
			sessions_dir = vim.fn.stdpath("data") .. "/sessions",
			autoload_mode = "Disabled", -- Disable all automatic session loading
			autosave_last_session = true,
			autosave_ignore_not_normal = true,
			autosave_ignore_buftypes = { "nofile", "prompt", "quickfix", "terminal" },
			autosave_ignore_filetypes = { "gitcommit", "gitrebase" },
		})
		-- Load Telescope extension only after Telescope is ready
		vim.defer_fn(function()
			local ok, telescope = pcall(require, "telescope")
			if ok then
				pcall(telescope.load_extension, "session-manager")
			else
				print("Telescope not found, skipping session-manager extension")
			end
		end, 100) -- Delay by 100ms to ensure Telescope is loaded
	end,
}
