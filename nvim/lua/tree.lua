-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",

	enable_git_status = true,
	enable_diagnostics = true,

	sources = {
		"filesystem",
	},

	filesystem = {
		follow_current_file = {
			enabled = true,
		},

		hijack_netrw_behavior = "open_default",

		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
		},

		use_libuv_file_watcher = true,
	},

	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},

	window = {
		position = "left",
		width = 35,
		mappings = {
			["<cr>"] = "open",
		},
	},

	source_selector = {
		winbar = false,
		statusline = false,
	},

	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
		},

		git_status = {
			symbols = {
				added = "A",
				modified = "M",
				deleted = "D",
				renamed = "R",
				untracked = "U",
				ignored = "◌",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},

		name = {
			use_git_status_colors = true,
		},
	},
})

vim.keymap.set("n", "<C-e>", "<cmd>Neotree toggle left<CR>", {
	noremap = true,
	silent = true,
})
