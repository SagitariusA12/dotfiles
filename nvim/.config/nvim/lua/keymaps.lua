-- lua/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navegação mais rápida (10 linhas de cada vez)
map("n", "<leader>j", "10j", opts) -- <leader>j → desce 10 linhas
map("n", "<leader>k", "10k", opts) -- <leader>k → sobe 10 linhas

-- Evita usar Shift para :
map("n", ";", ":", { noremap = true })

-- Saída rápida do modo inserção (útil se Esc for difícil de alcançar)
map("i", "jk", "<Esc>", opts)

-- Repete última edição na linha atual (útil para edições repetitivas)
map("n", "<leader>.", ":.norm.<CR>", opts)

-- Salvar rapidamente com <leader>w
map("n", "<leader>w", ":w<CR>", opts)

-- Fechar buffer rapidamente
map("n", "<leader>q", ":q<CR>", opts)

map("n", "<leader>=", ":resize +5<CR>", opts) -- Aumentar altura
map("n", "<leader>-", ":resize -5<CR>", opts) -- Diminuir altura
map("n", "<leader>>", ":vertical resize +5<CR>", opts) -- Aumentar largura
map("n", "<leader><", ":vertical resize -5<CR>", opts) -- Diminuir largura

-- Prettier
vim.keymap.set("n", "<leader>fp", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer with LSP" })

