return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- ou "tabs"
        numbers = "ordinal", -- mostra números nas abas
        diagnostics = "nvim_lsp",
        separator_style = "slant", -- ou "thick", "thin", "padded_slant"
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = true,
      },
    })

    -- Mapas de teclas para navegar entre abas
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
    vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Fechar buffer", silent = true })
  end,
}

