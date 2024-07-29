return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{
			"<leader><space>",
			function()
				require("telescope.builtin").git_files({})
			end,
			desc = "Git Files",
		},
	},
}
