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
-- Pastikan leader key kamu sudah di-set (biasanya spasi)
-- vim.g.mapleader = " "

vim.keymap.set("n", "<leader>hh", function()
	-- 1. Toggle LSP Inlay Hints (Hanya jalan di Neovim 0.10+)
	if vim.lsp.inlay_hint then
		local current_buf = vim.api.nvim_get_current_buf()
		local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = current_buf })
		vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = current_buf })
	end

	-- 2. Toggle Virtual Text Diagnostics (Error/Warning di sebelah kanan baris)
	local diagnostics_config = vim.diagnostic.config()
	local virtual_text_enabled = true

	-- Cek status virtual_text saat ini
	if diagnostics_config and diagnostics_config.virtual_text == false then
		virtual_text_enabled = false
	end

	-- Balikkan status virtual_text
	vim.diagnostic.config({
		virtual_text = not virtual_text_enabled,
	})

	-- (Opsional) Notifikasi kecil di command line biar kamu tahu statusnya
	local status = not virtual_text_enabled and "ON" or "OFF"
	vim.notify("LSP Hints & Errors: " .. status, vim.log.levels.INFO)
end, { desc = "Toggle LSP Inlay Hints and Virtual Text" })
