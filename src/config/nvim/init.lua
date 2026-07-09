local o = vim.opt
local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "
--========================================================
o.number = true
o.tabstop = 4
o.shiftwidth = 4
o.relativenumber = true
o.splitright = true
o.clipboard = "unnamedplus"
vim.cmd[[colorscheme industry]]
--========================================================
map("i", "jk", "<esc>", {})
map("n", "<leader>w", ":w<cr>", {})
map("n", "<leader>nh", ":nohl<cr>", {})
map("n", "<leader>x", ":bdel<cr>", {})
map("n", "<leader>c", ":belowright 15 split | term ", { silent = false })
map("n", "<leader>ff", ":FzfLua files<cr>", { silent = false })
map("n", "<leader>e", ":Ex<cr>", { silent = false })
map("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
map("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })

vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

--========================================================
require("tree-sitter-manager").setup({
	auto_install = true,
})
--========================================================
require("nvim-autopairs").setup({})
--========================================================
require("flash").setup({})
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "x", "o" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
--========================================================
