vim.g.onedark_diagnostic_line_highlisht = 1

vim.g.everforest_background = "soft"

-- Set up the everforest theme
vim.cmd("colorscheme everforest")
-- Customize comment highlight group to be italic
vim.cmd("highlight Comment gui=italic")

vim.diagnostic.config({
	virtual_text = true, -- show text inline
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.INFO] = "»",
			[vim.diagnostic.severity.HINT] = "⚑",
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

vim.api.nvim_set_hl(0, "NeoTreeGitAdded", {
	fg = "#A7C080",
})

vim.api.nvim_set_hl(0, "NeoTreeGitModified", {
	fg = "#DBBC7F",
})

vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", {
	fg = "#E67E80",
})

vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", {
	fg = "#7FBBB3",
})
