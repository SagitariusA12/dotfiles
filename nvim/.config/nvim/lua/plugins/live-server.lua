return {
	"turbio/bracey.vim",
	-- Força o carregamento ao iniciar arquivos HTML
	ft = { "html", "htm" },
	-- Ou use event se preferir
	-- event = "VeryLazy",

	-- Garante que o build rode na primeira instalação
	build = function()
		-- Verifica se npm está disponível
		if vim.fn.executable("npm") == 0 then
			vim.notify("npm não encontrado! Instale o Node.js.", vim.log.levels.ERROR)
			return
		end

		local result = vim.fn.system("npm install --prefix " .. vim.fn.stdpath("data") .. "/lazy/bracey.vim/server")
		if vim.v.shell_error ~= 0 then
			vim.notify("Falha ao instalar dependências do Bracey: " .. result, vim.log.levels.ERROR)
		else
			vim.notify("Bracey: dependências instaladas com sucesso!", vim.log.levels.INFO)
		end
	end,

	-- Comandos disponíveis
	cmd = { "Bracey", "BraceyStop", "BraceyReload" },

	-- Configuração
	config = function()
		-- Atalhos
		vim.keymap.set("n", "<leader>bs", "<cmd>Bracey<CR>", { desc = "Iniciar Bracey" })
		vim.keymap.set("n", "<leader>bx", "<cmd>BraceyStop<CR>", { desc = "Parar Bracey" })
		vim.keymap.set("n", "<leader>br", "<cmd>BraceyReload<CR>", { desc = "Recarregar Bracey" })

		-- Mensagem ao iniciar
		vim.api.nvim_create_autocmd("User", {
			pattern = "BraceyStart",
			callback = function()
				print("Bracey rodando — preview ao vivo ativo! http://localhost:9000")
			end,
		})
	end,
}
