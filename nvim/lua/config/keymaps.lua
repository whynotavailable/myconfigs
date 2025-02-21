local map = vim.keymap.set

vim.keymap.del("n", "<leader>.")

map("n", "<leader><Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader><Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })
