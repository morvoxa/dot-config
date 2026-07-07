local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "
map("i", "jk", "<esc>", {})
map("n", "<leader>w", ":w<cr>", {})
map("n", "<leader>c", ":!", {})
map("n", "<leader>e", ":NvimTreeFocus<cr>", {})
map("n", "<leader>1", "<C-w>w", {})
map("n", "<leader>nh", ":nohl<cr>", {})
map("n", "<leader>x", ":bdel<cr>", {})
map("n", "<leader>ff", ":lua Snacks.picker.files()<cr>", {})
map("n", "<leader>fg", ":lua Snacks.picker.grep()<cr>", {})
