return {
	{
		"EdenEast/nightfox.nvim",
		opts = {},
	}, -- lazy
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "carbonfox",
		},
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c_sharp",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"elixir",
					"heex",
					"javascript",
					"html",
					"angular",
					"typescript",
					"css",
					"scss",
					"markdown",
					"rust",
					"templ",
					"go",
					"gdscript",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {},
				gdscript = {},
			},
			inlay_hints = {
				enabled = false,
			},
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters = {
				["mdformat"] = {
					prepend_args = { "--wrap", "120" },
				},
			},
			formatters_by_ft = {
				["markdown"] = { "mdformat" },
				["python"] = { "isort" },
				["cpp"] = { "clang-format" },
			},
		},
	},
}
