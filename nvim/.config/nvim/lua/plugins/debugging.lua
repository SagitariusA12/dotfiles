return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",  -- Adicionando nvim-dap-python
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("dapui").setup()
		require("dap-go").setup()
		
		-- Configuração do Python usando o Python padrão
		require("dap-python").setup()

		-- Abrir o dap-ui ao iniciar a depuração
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Mapeamento de teclas
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<F5>", dap.continue, {})
	end,
}

