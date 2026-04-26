return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
        keys = {
            "<leader>ff",
            "<C-p>",
            "<leader>fg",
            "<leader>fb",
            "<leader>fh",
            "<leader><leader>",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            local ignore_patterns = { "%.git/", "node_modules/", "__pycache__/" }

            -- Cache do root, resetado ao mudar de diretório
            local _root_cache = nil
            vim.api.nvim_create_autocmd("DirChanged", {
                callback = function()
                    _root_cache = nil
                end,
            })

            local function project_root()
                if not _root_cache then
                    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
                    -- Garante que é um caminho real, não uma mensagem de erro do git
                    if git_root and vim.fn.isdirectory(git_root) == 1 then
                        _root_cache = git_root
                    else
                        _root_cache = vim.fn.getcwd()
                    end
                end
                return _root_cache
            end

            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ["<esc>"] = actions.close },
                    },
                    file_ignore_patterns = ignore_patterns,
                    find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("fzf")

            local function find_files()
                builtin.find_files({ cwd = project_root(), hidden = true })
            end

            local function live_grep()
                -- CORRIGIDO: era "[builtin.live](http://builtin.live)_grep"
                builtin.live_grep({ cwd = project_root(), additional_args = { "--hidden" } })
            end

            local keymaps = {
                { "n", "<leader>ff",       find_files },
                { "n", "<C-p>",            find_files },
                { "n", "<leader>fg",       live_grep },
                { "n", "<leader>fb",       builtin.buffers },
                -- CORRIGIDO: era "[builtin.help](http://builtin.help)_tags"
                { "n", "<leader>fh",       builtin.help_tags },
                { "n", "<leader><leader>", builtin.oldfiles },
            }

            for _, map in ipairs(keymaps) do
                vim.keymap.set(map[1], map[2], map[3])
            end
        end,
    },
}
