vim.o.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.virtualedit = "onemore"
vim.opt.clipboard = "unnamedplus"


-- Open terminal
vim.keymap.set("n", "<C-t>", ":rightbelow vsplit | term<CR>:startinsert<CR>", { noremap = true, silent = true })


-- Mapeamento para Prettier
vim.keymap.set("n", "<leader>fp", ":!prettier --write %<CR>", { desc = "Formatar com Prettier" })


-- Função para salvar e fechar o buffer atual se for um arquivo, ou apenas fechar a janela
local function save_and_close_or_quit()
  -- Verifica se o buffer atual é um arquivo
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname ~= "" and bufname ~= nil then
    -- Se for um arquivo, salva e fecha
    vim.cmd("w")
  --   -- Verifica se é a última janela
  --   local windows = vim.api.nvim_list_wins()
  --   if #windows == 1 then
  --     vim.cmd("qa")
  --   else
  --     vim.cmd("q")
  --   end
  -- else
  --   -- Caso contrário, apenas fecha a janela
  --   vim.cmd("q")
  end
end

-- Função para fechar sem salvar
local function close_without_saving()
  vim.cmd("q!")
end

-- Mapeia Ctrl+w para a função save_and_close_or_quit (salvar e fechar)
vim.keymap.set("n", "<C-s>", save_and_close_or_quit, { noremap = true, silent = true })
vim.keymap.set("v", "<C-s>", save_and_close_or_quit, { noremap = true, silent = true })
vim.keymap.set("t", "<C-s>", "<C-\\><C-n>:wq<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<C-\\><C-n>:wq<CR>", { noremap = true, silent = true })

-- Mapeia Ctrl+q para a função close_without_saving (fechar sem salvar)
vim.keymap.set("n", "<C-q>", close_without_saving, { noremap = true, silent = true })
vim.keymap.set("v", "<C-q>", close_without_saving, { noremap = true, silent = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:q!<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-q>", "<C-\\><C-n>:q!<CR>", { noremap = true, silent = true })

-- Mapeamento para o modo de comando também
vim.api.nvim_set_keymap('c', '<C-s>', [[<C-\><C-n>:wq<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-q>', [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true })



-- Função para mover o cursor um espaço ao entrar no modo de inserção
local function move_cursor_on_insert()
  -- Pega a posição atual do cursor
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- Move o cursor um espaço para frente (somente se não estiver no final da linha)
  local line_length = #vim.api.nvim_get_current_line()
  if col < line_length then
    vim.api.nvim_win_set_cursor(0, {row, col + 1})
  end
end

-- Autocomando para mover o cursor quando entrar no modo de inserção
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = move_cursor_on_insert,
})
