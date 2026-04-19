return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            local ignore_patterns = { "%.git/", "node_modules/", "__pycache__/" }

            local function project_root()
                return vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
            end

            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ["<esc>"] = actions.close },
                    },
                    file_ignore_patterns = ignore_patterns,
                },
            })

            local function find_files()
                builtin.find_files({
                    cwd = project_root(),
                    hidden = true,
                })
            end

            local function live_grep()
                builtin.live_grep({
                    cwd = project_root(),
                    additional_args = { "--hidden" },
                })
            end

            local keymaps = {
                { "n", "<leader>ff",       find_files },
                { "n", "<C-p>",            find_files },
                { "n", "<leader>fg",       live_grep },
                { "n", "<leader>fb",       builtin.buffers },
                { "n", "<leader>fh",       builtin.help_tags },
                { "n", "<leader><leader>", builtin.oldfiles },
            }

            for _, map in ipairs(keymaps) do
                vim.keymap.set(map[1], map[2], map[3])
            end
        end,
    },
}
