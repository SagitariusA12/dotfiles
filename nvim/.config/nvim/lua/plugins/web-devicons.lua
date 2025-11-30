return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      default = true, -- Habilita ícones padrão para tipos de arquivos
      override = {}, -- Pode adicionar ícones personalizados aqui, se desejar
    })
  end,
}