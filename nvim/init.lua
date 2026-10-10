-- Disable lspconfig's auto-enabled jdtls
vim.lsp.enable("jdtls", false)

require("base")
require("plugins")
require("plugins.conform")
require("telescope")
require("fugitive")
require("treesitter")
require("tree")
require("lsp")
require("lsp-lua")
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	check_ts = true,
})
require("nvim-autopairs").remove_rule("'")
require("indent")
require("colors")
require("lualine-config")

vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
})
