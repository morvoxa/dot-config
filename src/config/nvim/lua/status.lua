-- 1. SETUP TEMA COKELAT HITAM (DARK ESPRESSO / CHARCOAL MOCHA)
local function setup_statusline_colors()
	-- Memaksa background bar utama menggunakan hitam pekat murni
	local bar_bg = "#111111"

	-- StatusLine bawaan menggunakan warna teks cokelat arang yang sangat samar
	vim.api.nvim_set_hl(0, "StatusLine", { bg = bar_bg, fg = "#3a302a" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bar_bg, fg = "#1c1715" })

	-- Palet Gelap: Cokelat Tua, Cokelat Tanah, Krem Redup, dan Hitam
	local bg_dark_choc = "#231b17" -- Cokelat gelap arang (Blok File)
	local bg_moca_text = "#a88970" -- Cokelat moka pudar (Blok Mode)
	local bg_umber = "#5e4b3e" -- Cokelat tanah/kayu (Blok LSP)
	local bg_clay = "#826955" -- Cokelat tanah liat (Blok Formatter)
	local bg_bone = "#c7b7a7" -- Krem tulang redup (Blok Posisi)

	-- Konfigurasi teks kontras di atas blok bernuansa gelap
	vim.api.nvim_set_hl(0, "BlkMode", { fg = "#111111", bg = bg_moca_text, bold = true })
	vim.api.nvim_set_hl(0, "BlkFile", { fg = "#a88970", bg = bg_dark_choc })
	vim.api.nvim_set_hl(0, "BlkLsp", { fg = "#111111", bg = bg_umber, bold = true })
	vim.api.nvim_set_hl(0, "BlkFmt", { fg = "#111111", bg = bg_clay, bold = true })
	vim.api.nvim_set_hl(0, "BlkPos", { fg = "#111111", bg = bg_bone })

	-- Segitiga Transisi Bergradasi Hitam ke Cokelat
	vim.api.nvim_set_hl(0, "TransModeToFile", { fg = bg_moca_text, bg = bg_dark_choc })
	vim.api.nvim_set_hl(0, "TransFileToBar", { fg = bg_dark_choc, bg = bar_bg })
	vim.api.nvim_set_hl(0, "TransBarToLsp", { fg = bg_umber, bg = bar_bg })
	vim.api.nvim_set_hl(0, "TransLspToFmt", { fg = bg_clay, bg = bg_umber })
	vim.api.nvim_set_hl(0, "TransFmtToPos", { fg = bg_bone, bg = bg_clay })
end

setup_statusline_colors()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = setup_statusline_colors,
})

-- 2. LOGIK STATUS MODE
local text_modes = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	c = "COMMAND",
	R = "REPLACE",
	t = "TERMINAL",
}

_G.get_current_mode = function()
	return text_modes[vim.api.nvim_get_mode().mode] or "NORMAL"
end

-- 3. LOGIK LSP (DIUBAH AGAR MENAMPILKAN NAMA SERVER)
_G.get_lsp_status = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return "NO LSP"
	end

	local names = {}
	for _, client in ipairs(clients) do
		-- Ambil nama, ubah ke HURUF BESAR agar serasi dengan komponen lainnya
		table.insert(names, string.upper(client.name))
	end

	-- Output contoh: "LSP: VTSLS, TAILWIND" atau "LSP: RUST_ANALYZER"
	return "LSP: " .. table.concat(names, ", ")
end

-- 4. LOGIK FORMATTER
_G.get_formatter_status = function()
	local ft = vim.bo.filetype
	if ft == "" then
		return "EMPTY"
	end
	local ok, conform = pcall(require, "conform")
	if not ok then
		return "NO FMT"
	end

	local formatters = conform.list_formatters(0)
	if #formatters == 0 then
		if ft == "typescriptreact" or ft == "javascriptreact" or ft == "typescript" then
			return "PRETTIER"
		elseif ft == "rust" then
			return "RUSTFMT"
		end
		return "NO FMT"
	end

	local names = {}
	for _, fmt in ipairs(formatters) do
		table.insert(names, string.upper(fmt.name))
	end
	return table.concat(names, ", ")
end

-- 5. RAKITAN DIGITAL WAVE BLOCK STYLE
vim.opt.statusline = table.concat({
	-- BAGIAN KIRI
	"%#BlkMode# %{v:lua.get_current_mode()} ",
	"%#TransModeToFile#",
	"%#BlkFile# %f %m%r ",
	"%#TransFileToBar#",

	-- DORONG KE KANAN
	"%#StatusLine#%=",

	-- BAGIAN KANAN
	"%#TransBarToLsp#",
	"%#BlkLsp# %{v:lua.get_lsp_status()} ", -- Sekarang menampilkan nama LSP aktif
	"%#TransLspToFmt#",
	"%#BlkFmt# %{v:lua.get_formatter_status()} ",
	"%#TransFmtToPos#",
	"%#BlkPos# %l:%c │ %p%% ",
})
