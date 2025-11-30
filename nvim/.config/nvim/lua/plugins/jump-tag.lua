return {
    "harrisoncramer/jump-tag",
    event = "VeryLazy",
    config = function()
        local ok, jump = pcall(require, "jump-tag")
        if not ok then
            vim.notify("jump-tag não pôde ser carregado", vim.log.levels.ERROR)
            return
        end

        -- 🧭 Keymaps
        vim.keymap.set("n", "<leader>jc", jump.jumpChild, { desc = "Jump to child tag" })
        vim.keymap.set("n", "<leader>jp", jump.jumpParent, { desc = "Jump to parent tag" })
        vim.keymap.set("n", "<leader>jn", jump.jumpNextSibling, { desc = "Jump to next sibling tag" })
        vim.keymap.set("n", "<leader>jb", jump.jumpPrevSibling, { desc = "Jump to previous sibling tag" })
    end,
}
