-- lua/themes/kolada/palette.lua
-- Paleta extraída do tema Kolada (VSCode) por kaliahayes
-- + customizações do settings.json do usuário

local M = {}

-- ─── Cores base (editor.background / foreground do tema) ──────────────────
M.bg          = "#000000"   -- editor.background
M.bg1         = "#0d0d0d"   -- variante ligeiramente mais clara
M.bg2         = "#101010"   -- sideBar, painéis, widgets
M.bg3         = "#141414"   -- list.inactiveSelectionBackground
M.bg4         = "#1a1a1a"   -- hover, fold
M.fg          = "#ffffff"   -- editor.foreground
M.fg_dim      = "#dddddd"   -- foreground geral
M.fg_muted    = "#999999"   -- tab.inactiveForeground
M.fg_faint    = "#444444"   -- inactiveForeground
M.border      = "#101010"   -- bordas gerais

-- ─── Paleta de cores principais (token colors) ────────────────────────────
M.pink        = "#ff90e4"   -- variables, tags HTML, sass selector
M.pink_bright = "#ffa5e9"   -- badge, activityBarBadge, tab.activeBorder
M.pink_hot    = "#ff0c9e"   -- variable.other.readwrite (settings.json override)
M.orange      = "#ffb85c"   -- keywords, operators, attributes
M.red         = "#ff8888"   -- constants, numbers, parameters
M.red_error   = "#ff9580"   -- editorError
M.cyan        = "#aaefff"   -- strings
M.cyan_bright = "#83ffd6"   -- classes, types, language vars
M.cyan_dim    = "#40fdda"   -- untrackedResource, menu.selectionForeground
M.purple      = "#af8bff"   -- functions, methods
M.purple_dim  = "#9c64ff"   -- list.focusBackground (base)
M.white       = "#ffffff"   -- punctuation, text
M.comment     = "#ffccf7"   -- comentários (com opacidade ~34% no VSCode → usamos direto)

-- ─── Customizações do settings.json (overrides aplicados pelo usuário) ─────
M.func_override   = "#f200ff"   -- functions (settings override)
M.var_override    = "#00ffff"   -- variables / entity.name (settings override)
M.param_override  = "#77ecf0"   -- variable.parameter (settings override)
M.const_override  = "#71ffbd"   -- variable.other.constant (settings override, bold)
M.readwrite_ov    = "#ff0c9e"   -- variable.other.readwrite, constant.numeric
M.tag_override    = "#F04F6A"   -- entity.name.tag (bold, settings override)
M.attr_js_ov      = "#e4b841"   -- entity.other.attribute-name.js (settings override)
M.operator_ov     = "#00B7EB"   -- keyword.operator (settings override)
M.punct_ov        = "#FF69B4"   -- punctuation brackets/sections

-- ─── Cores de UI extras ───────────────────────────────────────────────────
M.selection   = "#293b64"   -- editor.selectionBackground
M.sel_search  = "#3d1a28" -- editor.selectionHighlightBackground
M.find_match  = "#001433" -- editor.findMatchBackground
M.word_hl     = "#1a0000" -- editor.wordHighlightBackground
M.line_hl     = "#090910" -- editor.lineHighlightBackground
M.bracket     = "#ff9077"   -- editorBracketMatch.border

-- ─── Diagnósticos ─────────────────────────────────────────────────────────
M.error       = "#ff9580"
M.warn        = "#ffe46c"
M.info        = "#6fbbff"
M.hint        = "#83ffd6"

-- ─── Git ──────────────────────────────────────────────────────────────────
M.git_add     = "#a1ffb2"
M.git_mod     = "#ffa5e9"
M.git_del     = "#ff8888"
M.git_untrack = "#40fdda"
M.git_ignore  = "#8c8c8c"

-- ─── Diff ─────────────────────────────────────────────────────────────────
M.diff_add    = "#111a07"
M.diff_del    = "#1c1035"

return M
