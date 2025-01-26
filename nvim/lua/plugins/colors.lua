local themes = {
	carbon = "carbonfox",
	night = "nightfox",
}

return {
	{
		"EdenEast/nightfox.nvim",
		opts = {},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = themes.night,
		},
	},
}
