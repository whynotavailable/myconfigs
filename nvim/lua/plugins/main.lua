return {
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			---@diagnostic disable-next-line: missing-fields
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
					prepend_args = { "--wrap", "120" }, -- The only reason to actually use mdformat
				},
			},
			formatters_by_ft = {
				["markdown"] = { "mdformat" },
				["python"] = { "isort" },
				["cpp"] = { "clang-format" },
			},
		},
	},
	{
		"folke/noice.nvim",
		enabled = false,
	},
}
