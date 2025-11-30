return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"clangd",
					"jsonls",
					"pyright",
					"bashls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				lua_ls = {},
				ts_ls = {},
				pyright = {},
				html = {},
				cssls = {},
				clangd = {},
				jsonls = {},
				bashls = {},
			}

			if vim.lsp.start then
				-- Neovim 0.11+ (nova API)
				for name, config in pairs(servers) do
					local final_config = vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, config)

					local lsp_conf = vim.lsp.config(name, final_config)
					if lsp_conf then
						vim.lsp.start(lsp_conf)
					end
				end
			else
				-- Fallback para Neovim <= 0.10
				local lspconfig = require("lspconfig")
				for name, config in pairs(servers) do
					config.capabilities = capabilities
					lspconfig[name].setup(config)
				end
			end

			-- Keymaps LSP
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<C-y>", vim.lsp.codelens.run, opts)
		end,
	},
}
