return {
	"echasnovski/mini.surround",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		mappings = {
			add            = "sa",  -- sa<motion><char> — adicionar envolvimento
			delete         = "sd",  -- sd<char>          — deletar envolvimento
			replace        = "sr",  -- sr<old><new>       — substituir envolvimento
			find           = "sf",  -- sf<char>           — achar próximo
			find_left      = "sF",  -- sF<char>           — achar anterior
			highlight      = "sh",  -- sh<char>           — destacar
			update_n_lines = "sn",  -- sn                 — atualizar n_lines
		},
		n_lines = 20,
	},
}
