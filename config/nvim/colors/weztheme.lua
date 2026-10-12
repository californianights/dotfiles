local colors = {
	-- Base
	bg = "#08070c",
	bg_alt = "#0e0c13",
	bg_highlight = "#17121f",
	surface = "#211b2a",

	fg = "#c5bfd2",
	fg_bright = "#e1dbea",
	fg_muted = "#8d8799",
	comment = "#625b6e",

	-- ANSI
	black = "#17121f",
	red = "#9b6f87",
	green = "#739b8b",
	yellow = "#9d8d70",
	blue = "#625d8f",
	magenta = "#91749f",
	cyan = "#718b96",
	white = "#b5afc2",

	-- Bright ANSI
	bright_black = "#443b50",
	bright_red = "#b27f98",
	bright_green = "#91aa99",
	bright_yellow = "#ad9c7c",
	bright_blue = "#8078ae",
	bright_magenta = "#ad8abc",
	bright_cyan = "#8daab4",
	bright_white = "#d0c9d8",

	-- UI
	border = "#393044",
	selection = "#393044",
	cursor = "#a99abb",
}

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "weztheme"

local hi = function(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================================
-- Editor
-- ============================================================================

-- Transparent editor background.
-- The actual background comes from WezTerm.
hi("Normal", {
	fg = colors.fg,
	bg = "NONE",
})

hi("NormalNC", {
	fg = colors.fg,
	bg = "NONE",
})

hi("NormalFloat", {
	fg = colors.fg,
	bg = "NONE",
})

hi("EndOfBuffer", {
	fg = colors.comment,
	bg = "NONE",
})

hi("SignColumn", {
	fg = colors.comment,
	bg = "NONE",
})

hi("FoldColumn", {
	fg = colors.comment,
	bg = "NONE",
})

hi("Cursor", {
	fg = colors.cursor,
	bg = colors.cursor,
})

hi("CursorLine", {
	bg = colors.bg_highlight,
})

hi("CursorColumn", {
	bg = colors.bg_highlight,
})

hi("ColorColumn", {
	bg = colors.bg_highlight,
})

hi("Visual", {
	fg = colors.fg_bright,
	bg = colors.selection,
})

hi("Search", {
	fg = colors.bg,
	bg = colors.bright_yellow,
})

hi("IncSearch", {
	fg = colors.bg,
	bg = colors.cursor,
})

hi("CurSearch", {
	fg = colors.bg,
	bg = colors.cursor,
})

hi("Substitute", {
	fg = colors.bg,
	bg = colors.bright_magenta,
})

-- ============================================================================
-- Text
-- ============================================================================

hi("Comment", {
	fg = colors.comment,
	italic = true,
})

hi("Constant", {
	fg = colors.cyan,
})

hi("String", {
	fg = colors.green,
})

hi("Character", {
	fg = colors.green,
})

hi("Number", {
	fg = colors.cyan,
})

hi("Boolean", {
	fg = colors.cyan,
})

hi("Float", {
	fg = colors.cyan,
})

hi("Identifier", {
	fg = colors.fg,
})

hi("Function", {
	fg = colors.bright_blue,
})

hi("Statement", {
	fg = colors.magenta,
})

hi("Conditional", {
	fg = colors.magenta,
})

hi("Repeat", {
	fg = colors.magenta,
})

hi("Label", {
	fg = colors.bright_magenta,
})

hi("Operator", {
	fg = colors.fg_bright,
})

hi("Keyword", {
	fg = colors.magenta,
})

hi("Exception", {
	fg = colors.red,
})

hi("PreProc", {
	fg = colors.bright_magenta,
})

hi("Include", {
	fg = colors.magenta,
})

hi("Define", {
	fg = colors.magenta,
})

hi("Macro", {
	fg = colors.bright_magenta,
})

hi("Type", {
	fg = colors.bright_blue,
})

hi("StorageClass", {
	fg = colors.magenta,
})

hi("Structure", {
	fg = colors.bright_blue,
})

hi("Typedef", {
	fg = colors.bright_blue,
})

hi("Special", {
	fg = colors.cyan,
})

hi("SpecialChar", {
	fg = colors.cyan,
})

hi("Delimiter", {
	fg = colors.fg_muted,
})

hi("Error", {
	fg = colors.red,
})

hi("Todo", {
	fg = colors.yellow,
	bg = colors.bg_highlight,
	bold = true,
})

-- ============================================================================
-- Diagnostics
-- ============================================================================

hi("DiagnosticError", {
	fg = colors.red,
})

hi("DiagnosticWarn", {
	fg = colors.yellow,
})

hi("DiagnosticInfo", {
	fg = colors.blue,
})

hi("DiagnosticHint", {
	fg = colors.green,
})

hi("DiagnosticOk", {
	fg = colors.green,
})

hi("DiagnosticUnderlineError", {
	undercurl = true,
	sp = colors.red,
})

hi("DiagnosticUnderlineWarn", {
	undercurl = true,
	sp = colors.yellow,
})

hi("DiagnosticUnderlineInfo", {
	undercurl = true,
	sp = colors.blue,
})

hi("DiagnosticUnderlineHint", {
	undercurl = true,
	sp = colors.green,
})

-- ============================================================================
-- Line numbers / folds
-- ============================================================================

hi("LineNr", {
	fg = colors.comment,
	bg = "NONE",
})

hi("CursorLineNr", {
	fg = colors.bright_blue,
	bg = "NONE",
	bold = true,
})

hi("Folded", {
	fg = colors.fg_muted,
	bg = colors.bg_highlight,
})

-- ============================================================================
-- Status / Tab / Window
-- ============================================================================

hi("StatusLine", {
	fg = colors.fg,
	bg = "NONE",
})

hi("StatusLineNC", {
	fg = colors.comment,
	bg = "NONE",
})

hi("WinSeparator", {
	fg = colors.border,
	bg = "NONE",
})

hi("VertSplit", {
	fg = colors.border,
	bg = "NONE",
})

hi("TabLine", {
	fg = colors.fg_muted,
	bg = "NONE",
})

hi("TabLineFill", {
	fg = colors.fg_muted,
	bg = "NONE",
})

hi("TabLineSel", {
	fg = colors.fg_bright,
	bg = colors.surface,
	bold = true,
})

-- ============================================================================
-- Popup menu
-- ============================================================================

hi("Pmenu", {
	fg = colors.fg,
	bg = colors.bg_alt,
})

hi("PmenuSel", {
	fg = colors.fg_bright,
	bg = colors.selection,
})

hi("PmenuSbar", {
	bg = colors.bg_highlight,
})

hi("PmenuThumb", {
	bg = colors.bright_black,
})

-- ============================================================================
-- Messages
-- ============================================================================

hi("Directory", {
	fg = colors.bright_blue,
})

hi("Title", {
	fg = colors.bright_magenta,
	bold = true,
})

hi("Question", {
	fg = colors.green,
})

hi("MoreMsg", {
	fg = colors.green,
})

hi("ModeMsg", {
	fg = colors.fg_bright,
	bold = true,
})

hi("WarningMsg", {
	fg = colors.yellow,
})

hi("ErrorMsg", {
	fg = colors.red,
	bold = true,
})

-- ============================================================================
-- Diff
-- ============================================================================

hi("DiffAdd", {
	fg = colors.green,
	bg = "#101a16",
})

hi("DiffChange", {
	fg = colors.blue,
	bg = "#11101a",
})

hi("DiffDelete", {
	fg = colors.red,
	bg = "#1a1116",
})

hi("DiffText", {
	fg = colors.bright_blue,
	bg = "#252036",
})

-- ============================================================================
-- Matching / brackets
-- ============================================================================

hi("MatchParen", {
	fg = colors.fg_bright,
	bg = colors.selection,
	bold = true,
})

-- ============================================================================
-- Spell
-- ============================================================================

hi("SpellBad", {
	undercurl = true,
	sp = colors.red,
})

hi("SpellCap", {
	undercurl = true,
	sp = colors.yellow,
})

hi("SpellRare", {
	undercurl = true,
	sp = colors.magenta,
})

hi("SpellLocal", {
	undercurl = true,
	sp = colors.cyan,
})

-- ============================================================================
-- Treesitter
-- ============================================================================

hi("@comment", {
	link = "Comment",
})

hi("@string", {
	link = "String",
})

hi("@string.escape", {
	fg = colors.bright_magenta,
})

hi("@number", {
	link = "Number",
})

hi("@boolean", {
	link = "Boolean",
})

hi("@constant", {
	link = "Constant",
})

hi("@constant.builtin", {
	fg = colors.cyan,
})

hi("@variable", {
	fg = colors.fg,
})

hi("@variable.builtin", {
	fg = colors.bright_magenta,
})

hi("@parameter", {
	fg = colors.fg,
})

hi("@function", {
	link = "Function",
})

hi("@function.call", {
	link = "Function",
})

hi("@function.builtin", {
	fg = colors.cyan,
})

hi("@method", {
	link = "Function",
})

hi("@method.call", {
	link = "Function",
})

hi("@keyword", {
	link = "Keyword",
})

hi("@keyword.function", {
	fg = colors.magenta,
})

hi("@keyword.return", {
	fg = colors.magenta,
})

hi("@type", {
	link = "Type",
})

hi("@type.builtin", {
	fg = colors.bright_blue,
})

hi("@property", {
	fg = colors.cyan,
})

hi("@field", {
	fg = colors.cyan,
})

hi("@constructor", {
	fg = colors.bright_blue,
})

hi("@operator", {
	link = "Operator",
})

hi("@punctuation.bracket", {
	fg = colors.fg_muted,
})

hi("@punctuation.delimiter", {
	fg = colors.fg_muted,
})

hi("@tag", {
	fg = colors.magenta,
})

hi("@tag.attribute", {
	fg = colors.cyan,
})

hi("@tag.delimiter", {
	fg = colors.fg_muted,
})

-- ============================================================================
-- LSP semantic tokens
-- ============================================================================

hi("@lsp.type.namespace", {
	fg = colors.bright_blue,
})

hi("@lsp.type.type", {
	fg = colors.bright_blue,
})

hi("@lsp.type.class", {
	fg = colors.bright_blue,
})

hi("@lsp.type.enum", {
	fg = colors.bright_blue,
})

hi("@lsp.type.interface", {
	fg = colors.bright_blue,
})

hi("@lsp.type.struct", {
	fg = colors.bright_blue,
})

hi("@lsp.type.function", {
	fg = colors.bright_blue,
})

hi("@lsp.type.method", {
	fg = colors.bright_blue,
})

hi("@lsp.type.variable", {
	fg = colors.fg,
})

hi("@lsp.type.parameter", {
	fg = colors.fg,
})
