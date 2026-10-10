--[[
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
]]

-- lua/lsp-lua.lua

-- register lua_ls using Neovim's built-in LSP config
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

-- enable the server
vim.lsp.enable("lua_ls")
