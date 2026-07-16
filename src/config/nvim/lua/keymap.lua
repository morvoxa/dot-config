vim.g.mapleader = " "
local o = vim.opt
local k = vim.keymap
o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.termguicolors = true
o.splitright = true
o.clipboard = "unnamedplus"
o.signcolumn = "yes"
o.updatetime = 250
o.timeoutlen = 300
o.scrolloff = 8
o.autoread = true
o.swapfile = false
o.backup = false
k.set("i", "jk", "<esc>", { desc = "Keluar dari mode insert dengan cepat" })
k.set("n", "<leader>w", ":w<cr>", { desc = "Simpan file" })
k.set("n", "<leader>nh", ":nohl<cr>", { desc = "Hapus sorotan pencarian" })
k.set("n", "<leader>x", ":bdel<cr>", { desc = "Tutup buffer/tab aktif" })
k.set("n", "<leader>e", ":Ex<cr>", { desc = "Buka file explorer bawaan (Netrw)" })
k.set("n", "<leader>c", ":belowright 15 split | term ", { desc = "Buka terminal di bawah" })
k.set("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
k.set("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })
k.set("n", "<leader>ff", ":FzfLua files<cr>", { desc = "Cari file pakai FzfLua" })
k.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
k.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
k.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
k.set({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
k.set("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
vim.keymap.set("n", "<leader>hh", function()
	local is_hint = vim.lsp.inlay_hint and vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) or false
	local state = not is_hint

	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(state, { bufnr = 0 })
	end
	vim.diagnostic.config({ virtual_text = state })

	vim.notify(
		state and "Hints & Errors SHOWN" or "Screen Cleaned",
		state and vim.log.levels.INFO or vim.log.levels.WARN,
		{ title = "LSP Focus" }
	)
end, { desc = "Toggle Zen Mode" })
