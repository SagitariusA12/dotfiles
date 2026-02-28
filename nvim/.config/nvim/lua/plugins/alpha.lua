return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- importa banners
		local banners = require("tables.banners")

		-- seed realmente aleatória
		math.randomseed(vim.loop.hrtime())

		-- pega chaves
		local keys = vim.tbl_keys(banners)

		-- escolhe uma
		local random_banner = banners[keys[math.random(#keys)]]

		-- aplica
		dashboard.section.header.val = random_banner

		dashboard.section.buttons.val = {
			dashboard.button("n", "  Novo arquivo", ":ene <BAR> startinsert <CR>"),
			dashboard.button("p", "󰈞  Procurar arquivo", ":Telescope find_files<CR>"),
			dashboard.button("r", "  Arquivos recentes", ":Telescope oldfiles<CR>"),
			dashboard.button("g", "󰈬  Buscar palavra", ":Telescope live_grep<CR>"),
			dashboard.button("m", "󰆓  Marcadores", ":lua require('harpoon.ui').toggle_quick_menu()<CR>"),
			dashboard.button("s", "󰁯  Sessão (restaurar)", ":SessionManager load_session<CR>"),
			dashboard.button("q", "  Sair", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
