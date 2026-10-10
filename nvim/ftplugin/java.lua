-- JDTLS (Java LSP) configuration
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	print("jdtls not found")
	return
end
--print("jdtls found!")

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- Key mappings for LSP
	vim.keymap.set("n", "<leader>t", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev({ float = true })
	end, opts)

	-- Add this to your init.lua
	vim.api.nvim_set_keymap(
		"n",
		"<leader>oi",
		"<Cmd>lua require('jdtls').organize_imports()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ev",
		"<Cmd>lua require('jdtls').extract_variable()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"v",
		"<leader>ev",
		"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ec",
		"<Cmd>lua require('jdtls').extract_constant()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"v",
		"<leader>ec",
		"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"v",
		"<leader>em",
		"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
		{ noremap = true, silent = true }
	)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if not root_dir then
	return
end

local config = {
	cmd = {
		"/usr/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = root_dir,
	settings = {
		java = {
			format = {
				settings = {
					-- Use Google Java style guidelines for formatting
					-- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
					-- and place it in the ~/.local/share/eclipse directory
					url = home .. "/.local/share/eclipse/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			signatureHelp = { enabled = true },
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			-- Specify any options for organizing imports
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk",
					},
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk",
					},
					{
						name = "JavaSE-22",
						path = "/usr/lib/jvm/java-22-openjdk",
					},
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk/",
						default = true,
					},
				},
			},
		},
	},
}

jdtls.start_or_attach(config)
