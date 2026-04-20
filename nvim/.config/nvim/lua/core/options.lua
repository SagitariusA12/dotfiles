-- lua/core/options.lua
local opt          = vim.opt

-- Números de linha
opt.number         = true
opt.relativenumber = true

-- Indentação
opt.tabstop        = 4
opt.softtabstop    = 4
opt.shiftwidth     = 4
opt.expandtab      = true
opt.smartindent    = true

-- Quebra de linha
opt.wrap           = true -- visual apenas, não altera o arquivo
opt.linebreak      = true -- quebra em espaço/pontuação, não no meio da palavra
opt.breakindent    = true -- linha continuada respeita indentação
opt.showbreak      = "↪ " -- indicador de linha continuada

-- Visual
opt.termguicolors  = true
opt.signcolumn     = "yes" -- evita layout shift
opt.cursorline     = true
opt.scrolloff      = 8
opt.sidescrolloff  = 8

-- Comportamento
opt.virtualedit    = "onemore"
opt.clipboard      = "unnamedplus"
opt.ignorecase     = true
opt.smartcase      = true
opt.splitright     = true
opt.splitbelow     = true
opt.updatetime     = 250
opt.timeoutlen     = 300

-- Busca
opt.hlsearch       = true
opt.incsearch      = true

-- Arquivos
opt.undofile       = true
opt.swapfile       = false
opt.backup         = false

-- Corretor ortográfico
opt.spell          = true
opt.spelllang      = { "pt_br", "en_us" } -- múltiplos idiomas ao mesmo tempo

return {}
