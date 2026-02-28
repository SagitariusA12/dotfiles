-- lua/core/options.lua
local opt = vim.opt

-- Números de linha
opt.number = true
opt.relativenumber = true -- números relativos (muito útil com j/k)

-- Indentação
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Visual
opt.termguicolors = true
opt.signcolumn = "yes"     -- sempre mostrar sign column (evita layout shift)
opt.cursorline = true      -- highlight na linha do cursor
opt.wrap = false           -- sem quebra de linha automática
opt.scrolloff = 8          -- 8 linhas de margem ao rolar
opt.sidescrolloff = 8

-- Comportamento
opt.virtualedit = "onemore"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true      -- vsplit abre à direita
opt.splitbelow = true      -- split abre abaixo
opt.updatetime = 250       -- mais rápido para CursorHold
opt.timeoutlen = 300       -- tempo para which-key aparecer

-- Arquivos
opt.undofile = true        -- undo persistente entre sessões
opt.swapfile = false
opt.backup = false

-- Busca
opt.hlsearch = true
opt.incsearch = true

return {}
