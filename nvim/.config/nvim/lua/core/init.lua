-- lua/core/init.lua
-- Define o mapleader ANTES de qualquer plugin
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")
require("core.keymaps")
require("core.autocmds")
