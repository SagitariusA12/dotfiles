return {
	"nvimtools/none-ls.nvim",

	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- HTML, CSS, JS, TS, JSON, YAML, Markdown
				null_ls.builtins.formatting.prettier.with({
					prefer_local = "node_modules/.bin",
					extra_args = { "--tab-width", "4" },
					filetypes = {
						"html",
						"css",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"json",
						"yaml",
						"markdown",
					},
				}),

				-- Python
				null_ls.builtins.formatting.black,

				-- Django Templates
				null_ls.builtins.formatting.djlint.with({
					filetypes = {
						"django",
						"htmldjango",
					},
					extra_args = {
						"--profile=django",
						"--indent=4",
					},
				}),

				-- ESLint
				require("none-ls.diagnostics.eslint_d").with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
				}),
			},

			-- Formatar automaticamente ao salvar
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					local group = vim.api.nvim_create_augroup("NullLsFormatting_" .. bufnr, { clear = true })

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
						buffer = bufnr,
						callback = function()
							if vim.fn.bufname(bufnr) ~= "" and vim.bo[bufnr].buftype == "" then
								vim.lsp.buf.format({
									bufnr = bufnr,
									name = "null-ls",
									async = false,
									timeout_ms = 5000,
								})
							end
						end,
					})
				end
			end,
		})

		-- Formatação manual
		vim.keymap.set("n", "<leader>gl", function()
			if vim.fn.bufname() ~= "" and vim.bo.buftype == "" then
				vim.lsp.buf.format({
					bufnr = 0,
					name = "null-ls",
					async = false,
					timeout_ms = 5000,
				})
			else
				print("Erro: Nenhum arquivo válido para formatação")
			end
		end, {
			desc = "Formatar arquivo",
		})
	end,
}
