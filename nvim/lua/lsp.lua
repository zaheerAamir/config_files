-- lsp.lua
-- Disable built-in lspconfig jdtls since we use ftplugin/java.lua
--vim.lsp.config("jdtls", { enabled = false })

local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

-- LSP Capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.semanticTokensProvider = nil

require("mason").setup()
require("mason-lspconfig").setup()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- LSP keymaps when attached
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

	if client.name == "denols" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
end

-- Setup LSP Servers
local servers = {
	"lua_ls",
	"html",
	"cssls",
	"pyright",
	"intelephense",
	"python-lsp-server",
}

for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
		on_attach = on_attach,
	})

	vim.lsp.enable(server)
end

-- TypeScript (non-deno projects)
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = vim.fs.root(0, { "package.json", "tsconfig.json" }),
})
vim.lsp.enable("ts_ls")

-- Deno
vim.lsp.config("denols", {
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" }),
})
vim.lsp.enable("denols")
