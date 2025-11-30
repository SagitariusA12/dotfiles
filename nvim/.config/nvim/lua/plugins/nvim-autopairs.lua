return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		npairs.setup({
			check_ts = true,
			enable_check_bracket_line = false,
			map_cr = true,
			map_bs = true,
			fast_wrap = {},
		})

		-- Integração com nvim-cmp
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Regras para mover sobre , ; :
		for _, punct in pairs({ ",", ";", ":" }) do
			npairs.add_rules({
				Rule("", punct)
					:with_pair(function()
						return false
					end)
					:with_move(function(opts)
						return opts.char == punct
					end)
					:with_del(function()
						return false
					end)
					:with_cr(function()
						return false
					end)
					:use_key(punct),
			})
		end
	end,
}
