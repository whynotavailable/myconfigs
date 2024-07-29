vim.keymap.set("n", "<leader>ch", function()
	vim.lsp.buf.hover()
end)

vim.keymap.set("n", "<leader>cv", function()
	vim.lsp.buf.definition()
end)
