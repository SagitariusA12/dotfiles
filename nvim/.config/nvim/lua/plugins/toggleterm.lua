return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		-- Configuração base
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
		})

		-- Acesso rápido ao módulo
		local Terminal = require("toggleterm.terminal").Terminal

		---------------------------------------------------------------------------
		-- Atalhos para abrir terminais em diferentes direções
		---------------------------------------------------------------------------
		vim.keymap.set("n", "<leader>th", function()
			Terminal:new({ direction = "horizontal" }):toggle()
		end, { desc = "Terminal Horizontal" })

		vim.keymap.set("n", "<leader>tv", function()
			Terminal:new({ direction = "vertical" }):toggle()
		end, { desc = "Terminal Vertical" })

		vim.keymap.set("n", "<leader>tf", function()
			Terminal:new({ direction = "float" }):toggle()
		end, { desc = "Terminal Flutuante" })

		vim.keymap.set("n", "<leader>tt", function()
			Terminal:new({ direction = "tab" }):toggle()
		end, { desc = "Terminal em Aba" })

		---------------------------------------------------------------------------
		-- Fechar todos os terminais com segurança
		---------------------------------------------------------------------------
		vim.keymap.set("n", "<leader>ta", function()
			local ok, err = pcall(require("toggleterm").toggle_all)
			if not ok then
				vim.notify("Erro ao fechar terminais: " .. err, vim.log.levels.WARN)
			end
		end, { desc = "Fechar todos os terminais com segurança" })

		---------------------------------------------------------------------------
		-- Esc para sair do modo terminal (voltar ao modo normal)
		---------------------------------------------------------------------------
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
			desc = "Sair do modo terminal",
			noremap = true,
		})

		---------------------------------------------------------------------------
		-- Terminais fixos
		---------------------------------------------------------------------------

		-- Terminal: Live Server (em janela flutuante)
		local live_server = Terminal:new({
			cmd = "live-server",
			hidden = true,
			direction = "float",
			id = 100,
		})

		vim.keymap.set("n", "<leader>ls", function()
			live_server:toggle()
		end, { desc = "Iniciar Live Server" })

		-- Terminal: Node.js REPL (abaixo)
		local node_term = Terminal:new({
			cmd = "node",
			hidden = true,
			direction = "horizontal",
			id = 101,
		})

		vim.keymap.set("n", "<leader>tn", function()
			node_term:toggle()
		end, { desc = "Abrir Node.js REPL" })

		-- Terminal: Htop (monitor do sistema, flutuante)
		local htop_term = Terminal:new({
			cmd = "htop",
			hidden = true,
			direction = "float",
			id = 102,
		})

		vim.keymap.set("n", "<leader>ht", function()
			htop_term:toggle()
		end, { desc = "Abrir Htop" })
	end,
}
