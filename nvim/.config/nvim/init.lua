-- Entrada principal: carrega a configuração core (opções, keymaps, autocmds)
require("core")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	import = "plugins",
	install = {
		colorscheme = { "cyberdream" },
	},
	checker = {
		enabled = false,
	},
})

-- O colorscheme é aplicado pelo plugin kolada.lua (priority = 1000)
-- Para trocar de tema: edite lua/plugins/kolada.lua ou lua/plugins/cyberdream.lua
