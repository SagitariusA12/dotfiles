return {
  "nyoom-engineering/oxocarbon.nvim",
  priority = 1000,
  lazy = false, -- Carregar imediatamente
  config = function()
    vim.cmd.colorscheme("oxocarbon")
  end,
}
