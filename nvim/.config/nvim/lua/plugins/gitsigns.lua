return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = true,
    })

    -- Mapeia teclas aqui dentro, com segurança
    local gs = require("gitsigns")

    vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Git preview hunk" })
    vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Git reset hunk" })
    vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Git stage hunk" })
    vim.keymap.set("n", "]c", gs.next_hunk, { desc = "Próximo hunk" })
    vim.keymap.set("n", "[c", gs.prev_hunk, { desc = "Hunk anterior" })
  end,
}
