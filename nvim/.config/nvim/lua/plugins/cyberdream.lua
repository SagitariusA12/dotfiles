return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- 1️⃣ Carrega o tema com transparência habilitada
        require("cyberdream").setup({
            transparent = true, -- ativa transparência interna do tema
            italic_comments = true,
            saturation = 1,
            hide_fillchars = false,
            terminal_colors = true,
            cache = true,
            borderless_telescope = false,
        })

        -- 2️⃣ Aplica o tema
        vim.cmd.colorscheme("cyberdream")

        -- 3️⃣ Força transparência em tudo (alguns temas ainda pintam fundo)
        local groups = {
            "Normal", "NormalNC", "NormalFloat", "FloatBorder", "SignColumn",
            "EndOfBuffer", "MsgArea", "TelescopeNormal", "TelescopeBorder",
            "TelescopePromptNormal", "TelescopePromptBorder",
            "TelescopeResultsNormal", "TelescopeResultsBorder",
            "TelescopePreviewNormal", "TelescopePreviewBorder",
            "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
            "StatusLine", "StatusLineNC", "VertSplit", "LineNr", "CursorLineNr",
            "FoldColumn", "TabLine", "TabLineFill", "TabLineSel"
        }

        for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
        end
    end,
}
