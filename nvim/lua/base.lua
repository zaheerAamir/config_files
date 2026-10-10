vim.g.mapleader = " " -- MUST be first, before everything
vim.g.maplocalleader = " " -- good practice to set this too

local opt = vim.opt
opt.number = true

opt.scrolloff = 5
opt.sidescrolloff = 5

opt.hlsearch = true
opt.incsearch = true

opt.mouse:append("a")
opt.clipboard:append("unnamedplus")

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.cursorline = true
opt.termguicolors = true

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})
vim.opt.signcolumn = "yes"

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-CR>", "o<Esc>", { noremap = true })
--vim.g.mapleader = " "
vim.keymap.set("n", "<leader>wv", vim.cmd.Ex)
vim.api.nvim_set_keymap("n", "<A-Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-S-Tab>", ":BufferLineCloseOthers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>cs", ":nohlsearch<CR>", { noremap = true, silent = true })
