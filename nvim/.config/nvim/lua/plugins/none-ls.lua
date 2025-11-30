return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- ✅ Lua
				null_ls.builtins.formatting.stylua,

				-- ✅ HTML, CSS, JS, TS...
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"html",
						"css",
						"json",
						"yaml",
						"markdown",
					},
				}),

				-- ✅ Python
				null_ls.builtins.formatting.black,

				-- ✅ Django Templates (HTML + {% %} + {{ }})
				null_ls.builtins.formatting.djlint.with({
					filetypes = { "html", "django", "htmldjango" },
					extra_args = { "--profile=django", "--indent=4" },
				}),

				-- ✅ Lint: ESLint
				require("none-ls.diagnostics.eslint_d").with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
				}),
			},

			-- ✅ Formatar ao salvar
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					local group = vim.api.nvim_create_augroup("NullLsFormatting", { clear = true })
					vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
						buffer = bufnr,
						callback = function()
							if vim.fn.bufname(bufnr) ~= "" and vim.bo[bufnr].buftype == "" then
								vim.lsp.buf.format({ bufnr = bufnr, async = false })
							end
						end,
					})
				end
			end,
		})

		-- ✅ Formatador manual
		vim.keymap.set("n", "<leader>gl", function()
			if vim.fn.bufname() ~= "" and vim.bo.buftype == "" then
				vim.lsp.buf.format({ async = false })
			else
				print("Erro: Nenhum arquivo válido para formatação")
			end
		end, { desc = "Formatar arquivo" })

		-- ✅ Correções automáticas ESLint
		vim.keymap.set("n", "<leader>ca", function()
			if vim.fn.bufname() ~= "" and vim.bo.buftype == "" then
				vim.lsp.buf.code_action()
			else
				print("Erro: Nenhum arquivo válido para correções")
			end
		end, { desc = "Aplicar correções de código (eslint_d)" })
	end,
}
