require("keymaps")

-- Configure leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Delete keypress Ctrl
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", {
	noremap = true,
})
-- nvim-notify
vim.o.termguicolors = true -- Corlors

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("vim-options")
require("lazy").setup({
	import = "plugins",
	install = {
		colorscheme = { "cyberdream" },
	},
	checker = {
		enabled = false,
	},
	spec = { {
		import = "plugins",
	} },
})

-- Aplica o Cyberdream no final
vim.cmd.colorscheme("cyberdream")
