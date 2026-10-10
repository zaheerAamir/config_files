local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },

		python = { "ruff_fix", "ruff_format" },

		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },

		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },

		json = { "prettier" },
		jsonc = { "prettier" },

		yaml = { "prettier" },
		markdown = { "prettier" },

		go = { "gofmt" },

		rust = { "rustfmt" },

		java = { "google-java-format" },

		sql = { "sql_formatter" },

		sh = { "shfmt" },
		bash = { "shfmt" },

		dockerfile = { "dockerfmt" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
