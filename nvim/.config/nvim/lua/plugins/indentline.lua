return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup({
      indent = { char = "│" }, -- Pode trocar por "┊" ou "▏"
      scope = { enabled = true },
    })
  end,
}

