return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{
			"<leader>gg",
			function()
				require("telescope.builtin").git_files({})
			end,
			desc = "Git Files",
		},
	},
}
