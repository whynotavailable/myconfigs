return {
	-- Disabled stuff
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"folke/noice.nvim",
		enabled = false,
	},
	-- Actual proper configs
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
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
			})
			-- print(vim.inspect(opts)) -- Keep around as example
		end,
	},
	-- Small updates and basic LSPs
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {},
				gdscript = {},
			},
			inlay_hints = {
				enabled = false, -- This disables the prop names showing up in functions causing weirdness
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
				["cpp"] = { "clang-format" },
			},
		},
	},
}
