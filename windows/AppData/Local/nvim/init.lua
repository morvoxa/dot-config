local o = vim.opt
local k = vim.keymap
vim.g.mapleader = " "
o.number = true -- Menampilkan nomor baris
o.relativenumber = true -- Menampilkan nomor baris relatif (mempercepat lompat baris)
o.tabstop = 4 -- Jumlah spasi yang dihitung untuk satu Tab
o.shiftwidth = 4 -- Jumlah spasi untuk indentasi otomatis
o.expandtab = true -- Mengubah tombol Tab menjadi spasi (standar modern)
o.smartindent = true -- Indentasi otomatis yang lebih cerdas mengikuti struktur kode
o.wrap = false -- Mencegah baris kode panjang otomatis turun ke bawah
o.ignorecase = true -- Mengabaikan huruf besar/kecil saat mencari teks...
o.smartcase = true -- ...KECUALI jika Anda mengetik huruf besar secara eksplisit
o.incsearch = true -- Menyorot teks yang cocok secara langsung saat baru mengetik
o.termguicolors = true -- Mengaktifkan warna 24-bit (wajib untuk tema modern)
o.splitright = true -- Vsplit otomatis membuka jendela baru di sebelah kanan
o.clipboard = "unnamedplus" -- Menghubungkan clipboard Neovim dengan clipboard OS
o.signcolumn = "yes" -- Selalu munculkan kolom ikon di kiri (mencegah layar "lompat")
o.updatetime = 250 -- Mempercepat trigger event (LSP, Git Gutter, dll.)
o.timeoutlen = 300 -- Mempercepat kombinasi tombol berantai (seperti leader)
o.scrolloff = 8 -- Menjaga jarak 8 baris tersisa di atas/bawah saat scroll
o.autoread = true -- Otomatis reload file jika diubah di luar Neovim (misal oleh git)
o.swapfile = false -- Mematikan pembuatan file .swp yang mengotori folder kerja
o.backup = false -- Mematikan backup file otomatis sebelum disimpan

k.set("i", "jk", "<esc>", { desc = "Keluar dari mode insert dengan cepat" })
k.set("n", "<leader>w", ":w<cr>", { desc = "Simpan file" })
k.set("n", "<leader>nh", ":nohl<cr>", { desc = "Hapus sorotan pencarian" })
k.set("n", "<leader>x", ":bdel<cr>", { desc = "Tutup buffer/tab aktif" })
k.set("n", "<leader>e", ":Ex<cr>", { desc = "Buka file explorer bawaan (Netrw)" })
k.set("n", "<leader>ff", ":FzfLua files<cr>", { desc = "Buka file explorer bawaan (Netrw)" })
k.set("n", "<leader>c", ":belowright 15 split | term ", { desc = "Buka terminal di bawah" })
k.set("v", "<Tab>", ">gv", { desc = "Indent ke kanan" })
k.set("v", "<S-Tab>", "<gv", { desc = "Indent ke kiri" })

vim.pack.add({
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})
require("nvim-autopairs").setup({})
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

local formatters = {
	cpp = "clang-format",
	lua = "stylua -",
	hpp = "clang-format",
	c = "clang-format",
	h = "clang-format",
}
local function run_formatter()
	local ext = vim.fn.expand("%:e")
	local cmd = formatters[ext]
	if not cmd then
		return
	end
	local view = vim.fn.winsaveview()
	vim.cmd("silent %!" .. cmd)
	if vim.v.shell_error ~= 0 then
		vim.cmd("silent undo")
		print("[Formatter] Failed to format ." .. ext .. " (Check syntax or binary path)")
	end
	vim.fn.winrestview(view)
end
local fmt_group = vim.api.nvim_create_augroup("CustomFormatterGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = fmt_group,
	pattern = "*",
	callback = run_formatter,
})
vim.api.nvim_create_user_command("FF", run_formatter, {})
