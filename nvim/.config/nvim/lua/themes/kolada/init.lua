-- lua/themes/kolada/init.lua
-- Tema Kolada para Neovim — portado do VSCode (kaliahayes.kolada)
-- com overrides do settings.json aplicados

local M = {}
local c = require("themes.kolada.palette")

M.setup = function()
	-- limpa highlights anteriores
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.background = "dark"
	vim.o.termguicolors = true
	vim.g.colors_name = "kolada"

	local hi = vim.api.nvim_set_hl

	-- ─────────────────────────────────────────────────────────────────────
	-- EDITOR BASE
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "Normal", { fg = c.fg, bg = c.bg })
	hi(0, "NormalNC", { fg = c.fg, bg = c.bg })
	hi(0, "NormalFloat", { fg = c.fg_dim, bg = c.bg2 })
	hi(0, "FloatBorder", { fg = c.border, bg = c.bg2 })
	hi(0, "FloatTitle", { fg = c.orange, bg = c.bg2, bold = true })

	hi(0, "Cursor", { fg = c.bg, bg = c.white })
	hi(0, "CursorLine", { bg = "#0e0e0e" })
	hi(0, "CursorLineNr", { fg = c.white, bold = true })
	hi(0, "LineNr", { fg = "#222222" })
	hi(0, "SignColumn", { fg = c.fg_faint, bg = c.bg })
	hi(0, "ColorColumn", { bg = "#111111" })
	hi(0, "VertSplit", { fg = c.border })
	hi(0, "WinSeparator", { fg = c.border })

	hi(0, "EndOfBuffer", { fg = "#222222" })
	hi(0, "Whitespace", { fg = "#1a1a2e" })
	hi(0, "NonText", { fg = "#222222" })

	hi(0, "Visual", { bg = c.selection })
	hi(0, "VisualNOS", { bg = c.selection })
	hi(0, "Search", { fg = c.bg, bg = c.orange })
	hi(0, "CurSearch", { fg = c.bg, bg = c.pink })
	hi(0, "IncSearch", { fg = c.bg, bg = c.cyan })
	hi(0, "Substitute", { fg = c.bg, bg = c.red })

	hi(0, "MatchParen", { fg = c.bracket, underline = true, bold = true })
	hi(0, "Folded", { fg = c.fg_muted, bg = "#1a1a2e", italic = true })
	hi(0, "FoldColumn", { fg = "#333333", bg = c.bg })

	hi(0, "StatusLine", { fg = c.fg_dim, bg = c.bg2 })
	hi(0, "StatusLineNC", { fg = c.fg_faint, bg = c.bg })
	hi(0, "WildMenu", { fg = c.bg, bg = c.orange })

	hi(0, "Pmenu", { fg = c.fg_dim, bg = c.bg2 })
	hi(0, "PmenuSel", { fg = c.cyan_dim, bg = "#0a1a33" })
	hi(0, "PmenuSbar", { bg = c.bg3 })
	hi(0, "PmenuThumb", { bg = "#333333" })

	hi(0, "TabLine", { fg = c.fg_muted, bg = c.bg })
	hi(0, "TabLineSel", { fg = c.fg_dim, bg = c.bg, underline = true, sp = c.pink_bright })
	hi(0, "TabLineFill", { bg = c.bg })

	hi(0, "Title", { fg = c.pink, bold = true })
	hi(0, "Question", { fg = c.cyan_bright })
	hi(0, "MoreMsg", { fg = c.cyan_bright })
	hi(0, "ModeMsg", { fg = c.fg_dim, bold = true })
	hi(0, "MsgArea", { fg = c.fg_dim, bg = c.bg })
	hi(0, "ErrorMsg", { fg = c.error })
	hi(0, "WarningMsg", { fg = c.warn })

	hi(0, "DiffAdd", { bg = "#111a07" })
	hi(0, "DiffChange", { bg = "#080d17" })
	hi(0, "DiffDelete", { bg = "#1c1035" })
	hi(0, "DiffText", { bg = "#001433" })

	hi(0, "SpellBad", { sp = c.error, undercurl = true })
	hi(0, "SpellCap", { sp = c.warn, undercurl = true })
	hi(0, "SpellLocal", { sp = c.info, undercurl = true })
	hi(0, "SpellRare", { sp = c.hint, undercurl = true })

	hi(0, "Directory", { fg = c.cyan_bright })
	hi(0, "QuickFixLine", { bg = c.bg3 })
	hi(0, "SpecialKey", { fg = "#333333" })
	hi(0, "Conceal", { fg = c.fg_faint })

	-- ─────────────────────────────────────────────────────────────────────
	-- SYNTAX — mapeando os token colors do Kolada + overrides do settings.json
	-- ─────────────────────────────────────────────────────────────────────

	-- Comentários: "#ffccf7" com ~34% opacidade → usamos dessaturado
	hi(0, "Comment", { fg = "#997799", italic = true })
	hi(0, "SpecialComment", { fg = "#997799", italic = true })

	-- Strings: #aaefff
	hi(0, "String", { fg = c.cyan })
	hi(0, "Character", { fg = c.cyan })

	-- Numbers/Constants: settings.json override = #ff0c9e
	hi(0, "Number", { fg = c.readwrite_ov })
	hi(0, "Float", { fg = c.readwrite_ov })
	hi(0, "Boolean", { fg = c.readwrite_ov })
	hi(0, "Constant", { fg = c.red })

	-- Keywords: #ffb85c (tema base) — sem override no settings.json para keyword geral
	hi(0, "Keyword", { fg = c.orange })
	hi(0, "Conditional", { fg = c.orange })
	hi(0, "Repeat", { fg = c.orange })
	hi(0, "Label", { fg = c.orange })
	hi(0, "Exception", { fg = c.orange })
	hi(0, "Statement", { fg = c.orange })

	-- Operadores: settings.json override = #00B7EB
	hi(0, "Operator", { fg = c.operator_ov })

	-- Funções: settings.json override = #f200ff
	hi(0, "Function", { fg = c.func_override })
	hi(0, "Identifier", { fg = c.var_override })

	-- Types/Classes: #83ffd6
	hi(0, "Type", { fg = c.cyan_bright })
	hi(0, "StorageClass", { fg = c.orange })
	hi(0, "Structure", { fg = c.cyan_bright })
	hi(0, "Typedef", { fg = c.cyan_bright })

	-- Tags HTML: settings.json override = #F04F6A, bold
	hi(0, "Tag", { fg = c.tag_override, bold = true })

	-- Includes/Modules
	hi(0, "Include", { fg = c.orange })
	hi(0, "Define", { fg = c.orange })
	hi(0, "Macro", { fg = c.orange })
	hi(0, "PreProc", { fg = c.orange })
	hi(0, "PreCondit", { fg = c.orange })

	-- Special
	hi(0, "Special", { fg = c.orange })
	hi(0, "SpecialChar", { fg = c.orange })
	hi(0, "Delimiter", { fg = c.white })
	hi(0, "Debug", { fg = c.red })

	hi(0, "Underlined", { fg = c.cyan, underline = true })
	hi(0, "Bold", { bold = true })
	hi(0, "Italic", { italic = true })
	hi(0, "Error", { fg = c.error })
	hi(0, "Todo", { fg = c.bg, bg = c.orange, bold = true })

	-- ─────────────────────────────────────────────────────────────────────
	-- TREESITTER
	-- ─────────────────────────────────────────────────────────────────────

	-- Variáveis: settings.json override = #00ffff
	hi(0, "@variable", { fg = c.var_override })
	hi(0, "@variable.builtin", { fg = c.cyan_bright }) -- self, this, super
	hi(0, "@variable.parameter", { fg = c.param_override }) -- parâmetros: #77ecf0
	hi(0, "@variable.member", { fg = c.pink }) -- campos de objeto

	-- Constantes: #71ffbd + bold (settings override)
	hi(0, "@constant", { fg = c.const_override, bold = true })
	hi(0, "@constant.builtin", { fg = c.readwrite_ov }) -- nil, true, false
	hi(0, "@constant.macro", { fg = c.red })

	-- Strings
	hi(0, "@string", { fg = c.cyan })
	hi(0, "@string.regexp", { fg = c.orange })
	hi(0, "@string.escape", { fg = c.orange })
	hi(0, "@string.special", { fg = c.orange })

	-- Numbers
	hi(0, "@number", { fg = c.readwrite_ov })
	hi(0, "@number.float", { fg = c.readwrite_ov })
	hi(0, "@boolean", { fg = c.readwrite_ov })

	-- Funções: #f200ff (settings override)
	hi(0, "@function", { fg = c.func_override })
	hi(0, "@function.builtin", { fg = c.orange })
	hi(0, "@function.call", { fg = c.func_override })
	hi(0, "@function.macro", { fg = c.func_override })
	hi(0, "@function.method", { fg = c.func_override })
	hi(0, "@function.method.call", { fg = c.func_override })
	hi(0, "@constructor", { fg = c.cyan_bright })

	-- Keywords
	hi(0, "@keyword", { fg = c.orange })
	hi(0, "@keyword.import", { fg = c.orange })
	hi(0, "@keyword.return", { fg = c.orange })
	hi(0, "@keyword.function", { fg = c.orange })
	hi(0, "@keyword.operator", { fg = c.operator_ov })
	hi(0, "@keyword.conditional", { fg = c.orange })
	hi(0, "@keyword.repeat", { fg = c.orange })
	hi(0, "@keyword.exception", { fg = c.orange })

	-- Types
	hi(0, "@type", { fg = c.cyan_bright })
	hi(0, "@type.builtin", { fg = c.cyan_bright })
	hi(0, "@type.qualifier", { fg = c.orange })
	hi(0, "@type.definition", { fg = c.cyan_bright })

	-- Tags (HTML, JSX)
	hi(0, "@tag", { fg = c.tag_override, bold = true })
	hi(0, "@tag.builtin", { fg = c.tag_override, bold = true })
	hi(0, "@tag.attribute", { fg = c.white }) -- attr HTML: #ffffff
	hi(0, "@tag.delimiter", { fg = c.white, bold = true }) -- < > />

	-- Atributos JS: #e4b841
	hi(0, "@attribute", { fg = c.attr_js_ov })

	-- Punctuation
	hi(0, "@punctuation.delimiter", { fg = c.white })
	hi(0, "@punctuation.bracket", { fg = c.punct_ov }) -- () [] {} = #FF69B4
	hi(0, "@punctuation.special", { fg = c.orange })

	-- Comentários
	hi(0, "@comment", { fg = "#997799", italic = true })
	hi(0, "@comment.documentation", { fg = "#997799", italic = true })

	-- Operadores
	hi(0, "@operator", { fg = c.operator_ov })

	-- Namespace / Módulos
	hi(0, "@module", { fg = c.cyan_bright })
	hi(0, "@module.builtin", { fg = c.cyan_bright })

	-- Labels
	hi(0, "@label", { fg = c.orange })

	-- Markdown
	hi(0, "@markup.heading", { fg = c.pink, bold = true })
	hi(0, "@markup.heading.1", { fg = c.pink, bold = true })
	hi(0, "@markup.heading.2", { fg = c.purple, bold = true })
	hi(0, "@markup.heading.3", { fg = c.orange, bold = true })
	hi(0, "@markup.heading.4", { fg = c.cyan_bright, bold = true })
	hi(0, "@markup.heading.5", { fg = c.cyan, bold = true })
	hi(0, "@markup.heading.6", { fg = c.fg_dim, bold = true })
	hi(0, "@markup.bold", { fg = c.red, bold = true })
	hi(0, "@markup.italic", { fg = c.orange, italic = true })
	hi(0, "@markup.strikethrough", { fg = c.fg_muted, strikethrough = true })
	hi(0, "@markup.link", { fg = c.orange, underline = true })
	hi(0, "@markup.link.label", { fg = c.purple })
	hi(0, "@markup.link.url", { fg = c.orange, underline = true })
	hi(0, "@markup.raw", { fg = c.cyan })
	hi(0, "@markup.list", { fg = c.pink })
	hi(0, "@markup.quote", { fg = "#997799", italic = true })

	-- Diff
	hi(0, "@diff.plus", { fg = c.git_add })
	hi(0, "@diff.minus", { fg = c.git_del })
	hi(0, "@diff.delta", { fg = c.cyan_bright })

	-- ─────────────────────────────────────────────────────────────────────
	-- LSP SEMANTIC TOKENS
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "@lsp.type.class", { fg = c.cyan_bright })
	hi(0, "@lsp.type.comment", { fg = "#997799", italic = true })
	hi(0, "@lsp.type.decorator", { fg = c.purple })
	hi(0, "@lsp.type.enum", { fg = c.cyan_bright })
	hi(0, "@lsp.type.enumMember", { fg = c.orange }) -- semanticTokenColors.enumMember
	hi(0, "@lsp.type.function", { fg = c.func_override })
	hi(0, "@lsp.type.interface", { fg = c.cyan_bright })
	hi(0, "@lsp.type.keyword", { fg = c.orange })
	hi(0, "@lsp.type.macro", { fg = c.func_override })
	hi(0, "@lsp.type.method", { fg = c.func_override })
	hi(0, "@lsp.type.namespace", { fg = c.cyan_bright })
	hi(0, "@lsp.type.number", { fg = c.readwrite_ov })
	hi(0, "@lsp.type.operator", { fg = c.operator_ov })
	hi(0, "@lsp.type.parameter", { fg = c.param_override })
	hi(0, "@lsp.type.property", { fg = c.pink })
	hi(0, "@lsp.type.regexp", { fg = c.orange })
	hi(0, "@lsp.type.string", { fg = c.cyan })
	hi(0, "@lsp.type.struct", { fg = c.cyan_bright })
	hi(0, "@lsp.type.type", { fg = c.cyan_bright })
	hi(0, "@lsp.type.typeParameter", { fg = c.cyan_bright })
	hi(0, "@lsp.type.variable", { fg = c.var_override })
	-- semanticTokenColors extras
	hi(0, "@lsp.mod.constant", { fg = c.const_override, bold = true }) -- variable.constant
	hi(0, "@lsp.mod.defaultLibrary", { fg = c.cyan_bright }) -- variable.defaultLibrary

	-- ─────────────────────────────────────────────────────────────────────
	-- DIAGNÓSTICOS
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "DiagnosticError", { fg = c.error })
	hi(0, "DiagnosticWarn", { fg = c.warn })
	hi(0, "DiagnosticInfo", { fg = c.info })
	hi(0, "DiagnosticHint", { fg = c.hint })
	hi(0, "DiagnosticOk", { fg = c.cyan_bright })

	hi(0, "DiagnosticUnderlineError", { sp = c.error, undercurl = true })
	hi(0, "DiagnosticUnderlineWarn", { sp = c.warn, undercurl = true })
	hi(0, "DiagnosticUnderlineInfo", { sp = c.info, undercurl = true })
	hi(0, "DiagnosticUnderlineHint", { sp = c.hint, undercurl = true })

	hi(0, "DiagnosticVirtualTextError", { fg = c.error, bg = "#0a0505" })
	hi(0, "DiagnosticVirtualTextWarn", { fg = c.warn, bg = "#100e04" })
	hi(0, "DiagnosticVirtualTextInfo", { fg = c.info, bg = "#060f14" })
	hi(0, "DiagnosticVirtualTextHint", { fg = c.hint, bg = "#000805" })

	hi(0, "DiagnosticSignError", { fg = c.error })
	hi(0, "DiagnosticSignWarn", { fg = c.warn })
	hi(0, "DiagnosticSignInfo", { fg = c.info })
	hi(0, "DiagnosticSignHint", { fg = c.hint })

	-- ─────────────────────────────────────────────────────────────────────
	-- GIT (gitsigns)
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "GitSignsAdd", { fg = c.git_add })
	hi(0, "GitSignsChange", { fg = "#6cbaff" }) -- editorGutter.modifiedBackground
	hi(0, "GitSignsDelete", { fg = c.git_del })
	hi(0, "GitSignsAddNr", { fg = c.git_add })
	hi(0, "GitSignsChangeNr", { fg = "#6cbaff" })
	hi(0, "GitSignsDeleteNr", { fg = c.git_del })
	hi(0, "GitSignsAddLn", { bg = "#0c1404" })
	hi(0, "GitSignsChangeLn", { bg = "#050b14" })

	-- ─────────────────────────────────────────────────────────────────────
	-- NEO-TREE
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "NeoTreeNormal", { fg = c.fg_dim, bg = c.bg })
	hi(0, "NeoTreeNormalNC", { fg = c.fg_dim, bg = c.bg })
	hi(0, "NeoTreeEndOfBuffer", { fg = c.bg, bg = c.bg })
	hi(0, "NeoTreeRootName", { fg = c.orange, bold = true })
	hi(0, "NeoTreeFileName", { fg = c.fg_dim })
	hi(0, "NeoTreeFileIcon", { fg = c.fg_dim })
	hi(0, "NeoTreeDirectoryName", { fg = c.fg_dim })
	hi(0, "NeoTreeDirectoryIcon", { fg = c.cyan })
	hi(0, "NeoTreeGitAdded", { fg = c.git_add })
	hi(0, "NeoTreeGitModified", { fg = c.git_mod })
	hi(0, "NeoTreeGitDeleted", { fg = c.git_del })
	hi(0, "NeoTreeGitUntracked", { fg = c.git_untrack })
	hi(0, "NeoTreeGitIgnored", { fg = c.git_ignore })
	hi(0, "NeoTreeCursorLine", { bg = c.bg3 })
	hi(0, "NeoTreeFilterTerm", { fg = c.purple })
	hi(0, "NeoTreeModified", { fg = c.git_mod })
	hi(0, "NeoTreeDotfile", { fg = c.fg_faint })

	-- ─────────────────────────────────────────────────────────────────────
	-- TELESCOPE
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "TelescopeNormal", { fg = c.fg_dim, bg = c.bg })
	hi(0, "TelescopeBorder", { fg = c.border, bg = c.bg })
	hi(0, "TelescopePromptNormal", { fg = c.fg, bg = c.bg2 })
	hi(0, "TelescopePromptBorder", { fg = c.border, bg = c.bg2 })
	hi(0, "TelescopePromptTitle", { fg = c.bg, bg = c.pink, bold = true })
	hi(0, "TelescopePromptPrefix", { fg = c.pink })
	hi(0, "TelescopeResultsNormal", { fg = c.fg_dim, bg = c.bg })
	hi(0, "TelescopeResultsBorder", { fg = c.border, bg = c.bg })
	hi(0, "TelescopeResultsTitle", { fg = c.bg, bg = c.purple, bold = true })
	hi(0, "TelescopePreviewNormal", { fg = c.fg_dim, bg = c.bg })
	hi(0, "TelescopePreviewBorder", { fg = c.border, bg = c.bg })
	hi(0, "TelescopePreviewTitle", { fg = c.bg, bg = c.cyan_bright, bold = true })
	hi(0, "TelescopeMatching", { fg = c.purple })
	hi(0, "TelescopeSelection", { fg = c.fg, bg = c.bg3 })
	hi(0, "TelescopeSelectionCaret", { fg = c.pink })
	hi(0, "TelescopeMultiSelection", { fg = c.orange })

	-- ─────────────────────────────────────────────────────────────────────
	-- BUFFERLINE
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "BufferLineFill", { bg = c.bg })
	hi(0, "BufferLineBackground", { fg = c.fg_muted, bg = c.bg })
	hi(0, "BufferLineBufferSelected", { fg = "#dad4f7", bg = c.bg, bold = true, underline = true, sp = c.pink_bright })
	hi(0, "BufferLineBufferVisible", { fg = c.fg_muted, bg = c.bg })
	hi(0, "BufferLineCloseButton", { fg = c.fg_faint, bg = c.bg })
	hi(0, "BufferLineCloseButtonSelected", { fg = c.red, bg = c.bg })
	hi(0, "BufferLineModified", { fg = c.git_mod, bg = c.bg })
	hi(0, "BufferLineModifiedSelected", { fg = c.git_mod, bg = c.bg })
	hi(0, "BufferLineDiagnostic", { fg = c.fg_faint, bg = c.bg })
	hi(0, "BufferLineDiagnosticSelected", { fg = c.fg_dim, bg = c.bg })
	hi(0, "BufferLineError", { fg = c.error, bg = c.bg })
	hi(0, "BufferLineErrorSelected", { fg = c.error, bg = c.bg })
	hi(0, "BufferLineWarning", { fg = c.warn, bg = c.bg })
	hi(0, "BufferLineWarningSelected", { fg = c.warn, bg = c.bg })
	hi(0, "BufferLineInfo", { fg = c.info, bg = c.bg })
	hi(0, "BufferLineInfoSelected", { fg = c.info, bg = c.bg })
	hi(0, "BufferLineSeparator", { fg = c.border, bg = c.bg })
	hi(0, "BufferLineSeparatorSelected", { fg = c.pink_bright, bg = c.bg })
	hi(0, "BufferLineIndicatorSelected", { fg = c.pink_bright, bg = c.bg })
	hi(0, "BufferLineTab", { fg = c.fg_muted, bg = c.bg })
	hi(0, "BufferLineTabSelected", { fg = c.fg, bg = c.bg })

	-- ─────────────────────────────────────────────────────────────────────
	-- LUALINE (via autolink — apenas NormalMode bg, etc.)
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "lualine_a_normal", { fg = c.bg, bg = c.pink, bold = true })
	hi(0, "lualine_a_insert", { fg = c.bg, bg = c.cyan, bold = true })
	hi(0, "lualine_a_visual", { fg = c.bg, bg = c.purple, bold = true })
	hi(0, "lualine_a_replace", { fg = c.bg, bg = c.red, bold = true })
	hi(0, "lualine_a_command", { fg = c.bg, bg = c.orange, bold = true })
	hi(0, "lualine_b_normal", { fg = c.fg_dim, bg = c.bg2 })
	hi(0, "lualine_c_normal", { fg = c.fg_muted, bg = c.bg })

	-- ─────────────────────────────────────────────────────────────────────
	-- WHICH-KEY
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "WhichKey", { fg = c.pink })
	hi(0, "WhichKeyGroup", { fg = c.orange })
	hi(0, "WhichKeyDesc", { fg = c.fg_dim })
	hi(0, "WhichKeySeparator", { fg = c.border })
	hi(0, "WhichKeyFloat", { bg = c.bg2 })
	hi(0, "WhichKeyBorder", { fg = c.border, bg = c.bg2 })
	hi(0, "WhichKeyValue", { fg = c.cyan_bright })

	-- ─────────────────────────────────────────────────────────────────────
	-- INDENT-BLANKLINE
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "IblIndent", { fg = "#1a1a1a" })
	hi(0, "IblScope", { fg = "#2a2a3a" })

	-- ─────────────────────────────────────────────────────────────────────
	-- CMP (completions)
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "CmpItemAbbr", { fg = c.fg_dim })
	hi(0, "CmpItemAbbrMatch", { fg = c.cyan_dim, bold = true })
	hi(0, "CmpItemAbbrMatchFuzzy", { fg = c.cyan_dim })
	hi(0, "CmpItemAbbrDeprecated", { fg = c.fg_faint, strikethrough = true })
	hi(0, "CmpItemKindFunction", { fg = c.func_override })
	hi(0, "CmpItemKindMethod", { fg = c.func_override })
	hi(0, "CmpItemKindConstructor", { fg = c.cyan_bright })
	hi(0, "CmpItemKindField", { fg = c.pink })
	hi(0, "CmpItemKindVariable", { fg = c.var_override })
	hi(0, "CmpItemKindClass", { fg = c.cyan_bright })
	hi(0, "CmpItemKindInterface", { fg = c.cyan_bright })
	hi(0, "CmpItemKindModule", { fg = c.cyan_bright })
	hi(0, "CmpItemKindProperty", { fg = c.pink })
	hi(0, "CmpItemKindUnit", { fg = c.pink })
	hi(0, "CmpItemKindValue", { fg = c.readwrite_ov })
	hi(0, "CmpItemKindEnum", { fg = c.cyan_bright })
	hi(0, "CmpItemKindKeyword", { fg = c.orange })
	hi(0, "CmpItemKindSnippet", { fg = c.orange })
	hi(0, "CmpItemKindColor", { fg = c.pink })
	hi(0, "CmpItemKindFile", { fg = c.fg_dim })
	hi(0, "CmpItemKindFolder", { fg = c.orange })
	hi(0, "CmpItemKindEvent", { fg = c.red })
	hi(0, "CmpItemKindOperator", { fg = c.operator_ov })
	hi(0, "CmpItemKindTypeParameter", { fg = c.cyan_bright })
	hi(0, "CmpItemMenu", { fg = c.fg_faint })

	-- ─────────────────────────────────────────────────────────────────────
	-- ALPHA (dashboard)
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "AlphaHeader", { fg = c.pink })
	hi(0, "AlphaButtons", { fg = c.orange })
	hi(0, "AlphaShortcut", { fg = c.purple })
	hi(0, "AlphaFooter", { fg = c.fg_faint, italic = true })

	-- ─────────────────────────────────────────────────────────────────────
	-- TROUBLE
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "TroubleNormal", { fg = c.fg_dim, bg = c.bg })
	hi(0, "TroubleText", { fg = c.fg_dim })
	hi(0, "TroubleCount", { fg = c.purple, bg = c.bg3 })
	hi(0, "TroubleError", { fg = c.error })
	hi(0, "TroubleWarning", { fg = c.warn })
	hi(0, "TroubleInfo", { fg = c.info })
	hi(0, "TroubleHint", { fg = c.hint })
	hi(0, "TroubleLocation", { fg = c.fg_faint })

	-- ─────────────────────────────────────────────────────────────────────
	-- TODO-COMMENTS
	-- ─────────────────────────────────────────────────────────────────────
	hi(0, "TodoFgTODO", { fg = c.info })
	hi(0, "TodoFgFIX", { fg = c.error })
	hi(0, "TodoFgHACK", { fg = c.warn })
	hi(0, "TodoFgWARN", { fg = c.warn })
	hi(0, "TodoFgNOTE", { fg = c.hint })
	hi(0, "TodoFgPERF", { fg = c.cyan_bright })
	hi(0, "TodoBgTODO", { fg = c.bg, bg = c.info, bold = true })
	hi(0, "TodoBgFIX", { fg = c.bg, bg = c.error, bold = true })
	hi(0, "TodoBgHACK", { fg = c.bg, bg = c.warn, bold = true })
	hi(0, "TodoBgWARN", { fg = c.bg, bg = c.warn, bold = true })
	hi(0, "TodoBgNOTE", { fg = c.bg, bg = c.hint, bold = true })
	hi(0, "TodoBgPERF", { fg = c.bg, bg = c.cyan_bright, bold = true })

	-- ─────────────────────────────────────────────────────────────────────
	-- TERMINAL COLORS (matches Kolada terminal.ansi* colors)
	-- ─────────────────────────────────────────────────────────────────────
	vim.g.terminal_color_0 = "#3d3d3d" -- ansiBlack
	vim.g.terminal_color_1 = "#ff3333" -- ansiRed
	vim.g.terminal_color_2 = "#00ff64" -- ansiGreen
	vim.g.terminal_color_3 = "#ffe779" -- ansiYellow
	vim.g.terminal_color_4 = "#1584ff" -- ansiBlue
	vim.g.terminal_color_5 = "#ff02ff" -- ansiMagenta
	vim.g.terminal_color_6 = "#0ae1ff" -- ansiCyan
	vim.g.terminal_color_7 = "#a3a3a3" -- ansiWhite
	vim.g.terminal_color_8 = "#666666" -- ansiBrightBlack
	vim.g.terminal_color_9 = "#ff6767" -- ansiBrightRed
	vim.g.terminal_color_10 = "#97ffb1" -- ansiBrightGreen
	vim.g.terminal_color_11 = "#ffce00" -- ansiBrightYellow
	vim.g.terminal_color_12 = "#8bceff" -- ansiBrightBlue
	vim.g.terminal_color_13 = "#ff9aff" -- ansiBrightMagenta
	vim.g.terminal_color_14 = "#8ef4ff" -- ansiBrightCyan
	vim.g.terminal_color_15 = "#c9c9c9" -- ansiBrightWhite
end

return M
