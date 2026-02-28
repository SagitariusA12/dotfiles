-- Cyberdream desativado: usando tema Kolada (lua/themes/kolada/)
-- Para voltar: remova o `enabled = false` e comente lua/plugins/kolada.lua
return {
	"scottmckendry/cyberdream.nvim",
	enabled = false,
	lazy = false,
	priority = 900,
	config = function()
		require("cyberdream").setup({
			transparent = true,
			italic_comments = true,
			saturation = 1,
			hide_fillchars = false,
			terminal_colors = true,
			cache = true,
			borderless_telescope = false,
		})

		vim.cmd.colorscheme("cyberdream")

		-- Força transparência em grupos específicos
		local groups = {
			"Normal", "NormalNC", "NormalFloat", "FloatBorder", "SignColumn",
			"EndOfBuffer", "MsgArea", "TelescopeNormal", "TelescopeBorder",
			"TelescopePromptNormal", "TelescopePromptBorder",
			"TelescopeResultsNormal", "TelescopeResultsBorder",
			"TelescopePreviewNormal", "TelescopePreviewBorder",
			"NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
			"VertSplit", "LineNr", "CursorLineNr",
			"FoldColumn", "TabLine", "TabLineFill",
		}

		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
}
