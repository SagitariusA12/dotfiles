return {
	{
		"hkupty/iron.nvim",
		config = function()
			local iron = require("iron.core")

			iron.setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						python = { command = { "python3" } }, -- Python
						javascript = { command = { "node" } }, -- JavaScript
						lua = { command = { "lua" } }, -- Lua
						sh = { command = { "bash" } }, -- Bash
						cpp = { -- C++
							command = function()
								-- Compila e roda o arquivo atual
								local file = vim.fn.expand("%")
								local output = vim.fn.expand("%:r")
								return { "bash", "-c", "g++ " .. file .. " -o " .. output .. " && ./" .. output }
							end,
						},
					},
					repl_open_cmd = "vertical botright split",
				},
				keymaps = {
					send_motion = "<space>sc",
					visual_send = "<space>sc",
					send_file = "<space>sf",
					send_line = "<space>sl",
					send_mark = "<space>sm",
					mark_motion = "<space>mc",
					mark_visual = "<space>mc",
					remove_mark = "<space>md",
					cr = "<space>s<CR>",
					interrupt = "<space>s<space>",
					exit = "<space>sq",
					clear = "<space>cl",
				},
				highlight = {
					italic = true,
				},
			})
		end,
	},
}
