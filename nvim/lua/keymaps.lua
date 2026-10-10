vim.keymap.set("n", "<leader>oi", function()
	if vim.bo.filetype == "java" then
		require("jdtls").organize_imports()
	end
end)

vim.keymap.set("n", "<leader>em", function()
	if vim.bo.filetype == "java" then
		require("jdtls").extract_method(true)
	end
end)

vim.keymap.set("n", "<leader>ev", function()
	if vim.bo.filetype == "java" then
		require("jdtls").extract_varable()
	end
end)

vim.keymap.set("n", "<leader>gc", function()
	if vim.bo.filetype == "java" then
		require("jdtls").generate_constructor()
	end
end)
