return {
    "akinsho/bufferline.nvim",
    version = "*",

    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            highlights = {
                buffer_selected = {
                    underline = true,
                    sp = "#89b4fa", -- cor do sublinhado (ajuste para sua colorscheme)
                    bold = true,
                },
                indicator_selected = {
                    fg = "#89b4fa",
                    underline = true,
                    sp = "#89b4fa",
                },
            },
            options = {
                mode = "buffers", -- ou "tabs"
                numbers = "ordinal", -- mostra números nas abas
                diagnostics = "nvim_lsp",
                separator_style = "thin", -- ou "thick", "thin", "padded_slant", "slant"
                show_buffer_close_icons = true,
                show_close_icon = false,
                always_show_bufferline = true,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
            },
        })

        -- Mapas de teclas para navegar entre abas
        vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
        vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
        vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Fechar buffer", silent = true })

        vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>")
        vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
    end,
}
