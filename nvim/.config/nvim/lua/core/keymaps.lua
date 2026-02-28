-- lua/core/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Evita usar Shift para :
map("n", ";", ":", { noremap = true })

-- Saída rápida do modo inserção
map("i", "jk", "<Esc>", opts)

-- Navegação mais rápida (10 linhas de cada vez)
map("n", "<leader>j", "10j", opts)
map("n", "<leader>k", "10k", opts)

-- Salvar rapidamente
map("n", "<leader>w", ":w<CR>", opts)

-- Fechar buffer
map("n", "<leader>q", ":q<CR>", opts)

-- Limpar highlight de busca
map("n", "<Esc>", ":noh<CR>", opts)

-- Redimensionar splits
map("n", "<leader>=", ":resize +5<CR>", opts)
map("n", "<leader>-", ":resize -5<CR>", opts)
map("n", "<leader>>", ":vertical resize +5<CR>", opts)
map("n", "<leader><", ":vertical resize -5<CR>", opts)

-- Mover linhas no modo visual (muito útil)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Manter cursor no centro ao scroll
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Navegar entre splits com Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- LSP format
map("n", "<leader>fp", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer with LSP" })

-- Terminal (split vertical)
map("n", "<C-t>", ":rightbelow vsplit | term<CR>:startinsert<CR>", opts)

-- Salvar com Ctrl+S em todos os modos
map("n", "<C-s>", ":w<CR>", opts)
map("v", "<C-s>", "<Esc>:w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>a", opts)
map("t", "<C-s>", "<C-\\><C-n>:w<CR>", opts)

-- Fechar forçado com Ctrl+Q
map("n", "<C-q>", ":q!<CR>", opts)
map("v", "<C-q>", "<Esc>:q!<CR>", opts)
map("i", "<C-q>", "<Esc>:q!<CR>", opts)
map("t", "<C-q>", "<C-\\><C-n>:q!<CR>", opts)

-- Repete última edição na linha atual
map("n", "<leader>.", ":.norm.<CR>", opts)

return {}
