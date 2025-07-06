-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- OneDark Theme:
	--use("navarasu/onedark.nvim")
	--use({ "catppuccin/nvim", as = "catppuccin" })

	use("sainnhe/everforest")

	-- packer plugin declaration
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("tpope/vim-fugitive")

	-- plugins.lua
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("nvim-treesitter/playground")

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip") -- Snippet completions

	-- Snippet engine
	use("L3MON4D3/LuaSnip")

	-- Autopairs
	use("windwp/nvim-autopairs")

	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	})

	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use("echasnovski/mini.indentscope")
	use("axelvc/template-string.nvim")

	-- For the buffers above:
	use({
		"akinsho/bufferline.nvim",
		requires = "nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true,
							text_align = "left",
						},
					},
				},
			})
		end,
	})

	use({
		"mfussenegger/nvim-jdtls",
		ft = "java",
	})

	use("terrortylor/nvim-comment")

	-- ScreenShots using silicon
	use({
		"michaelrommel/nvim-silicon",
		cmd = "Silicon",
		config = function()
			require("nvim-silicon").setup({
				disable_defaults = true,
				output = function()
					return "./" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
				end,
				language = function()
					print(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":e"))
					return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":e")
				end,
				background = "#94e2d5",
				theme = "TwoDark",
				font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
			})
		end,
	})

	-- Gitsigns for git gutter indicators
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
end)
