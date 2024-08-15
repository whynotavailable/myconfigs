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
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			table.insert(opts.sources, nls.builtins.formatting.csharpier)
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
			},
			formatters = {
				csharpier = {
					command = "dotnet-csharpier",
					args = { "--write-stdout" },
				},
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
	{
		"folke/noice.nvim",
		enabled = false,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {},
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
			},
		},
	},
}
