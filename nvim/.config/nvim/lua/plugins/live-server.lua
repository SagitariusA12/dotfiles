return {
	"turbio/bracey.vim",

	ft = { "html" },

	build = function(plugin)
		local server_path = plugin.dir .. "/server"

		if vim.fn.executable("npm") == 0 then
			vim.notify("npm não encontrado! Instale o Node.js.", vim.log.levels.ERROR)
			return
		end

		local result = vim.fn.system("npm install --prefix " .. server_path)

		if vim.v.shell_error ~= 0 then
			vim.notify("Erro ao instalar Bracey:\n" .. result, vim.log.levels.ERROR)
		else
			vim.notify("Bracey pronto 🚀", vim.log.levels.INFO)
		end
	end,

	config = function()
		vim.keymap.set("n", "<leader>bs", "<cmd>Bracey<CR>", { desc = "Start Bracey" })
		vim.keymap.set("n", "<leader>bx", "<cmd>BraceyStop<CR>", { desc = "Stop Bracey" })
		vim.keymap.set("n", "<leader>br", "<cmd>BraceyReload<CR>", { desc = "Reload Bracey" })

		vim.api.nvim_create_autocmd("User", {
			pattern = "BraceyStart",
			callback = function()
				vim.notify("🌐 Bracey em http://localhost:9000")
			end,
		})
	end,
}
