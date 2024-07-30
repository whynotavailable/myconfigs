vim.keymap.set("n", "<leader>ch", function()
	vim.lsp.buf.hover()
end)

-- Think about removing this cause it's confusing
vim.keymap.set("n", "<leader>cv", function()
	vim.lsp.buf.definition()
end)

vim.keymap.set("n", "<leader>gd", function()
	vim.lsp.buf.definition()
end)
