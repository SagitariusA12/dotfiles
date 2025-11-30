return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_default_mappings = 0  -- desativa os padrões

    vim.g.VM_maps = {
      ["Find Under"]         = "<Leader>m",      -- seleciona palavra sob o cursor
      ["Find Subword Under"] = "<Leader>M",      -- subpalavra
      ["Select Cursor Down"] = "<M-j>",          -- Alt + j
      ["Select Cursor Up"]   = "<M-k>",          -- Alt + k
      ["Add Cursor At Pos"]  = "<Leader>a",      -- adiciona cursor manual
    }
  end,
}

