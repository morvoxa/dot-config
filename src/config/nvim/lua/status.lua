-- 1. SETUP TEMA CATPPUCCIN ASIMETRISBLOCKS
local function setup_statusline_colors()
	local base_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	local bar_bg = base_bg and string.format("#%06x", base_bg) or "#1e1e2e"

	vim.api.nvim_set_hl(0, "StatusLine", { bg = bar_bg, fg = "#585b70" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bar_bg, fg = "#313244" })

	local bg_green = "#a6e3a1"
	local bg_sapph = "#74c7ec"
	local bg_peach = "#fab387"
	local bg_lav = "#b4befe"
	local bg_dark = "#313244"

	-- Teks kontras tinggi di atas blok warna
	vim.api.nvim_set_hl(0, "BlkMode", { fg = "#11111b", bg = bg_green, bold = true })
	vim.api.nvim_set_hl(0, "BlkFile", { fg = "#cdd6f4", bg = bg_dark })
	vim.api.nvim_set_hl(0, "BlkLsp", { fg = "#11111b", bg = bg_sapph, bold = true }) -- Blok LSP
	vim.api.nvim_set_hl(0, "BlkFmt", { fg = "#11111b", bg = bg_peach, bold = true })
	vim.api.nvim_set_hl(0, "BlkPos", { fg = "#11111b", bg = bg_lav })

	-- Segitiga Transisi
	vim.api.nvim_set_hl(0, "TransModeToFile", { fg = bg_green, bg = bg_dark })
	vim.api.nvim_set_hl(0, "TransFileToBar", { fg = bg_dark, bg = bar_bg })
	vim.api.nvim_set_hl(0, "TransBarToLsp", { fg = bg_sapph, bg = bar_bg })
	vim.api.nvim_set_hl(0, "TransLspToFmt", { fg = bg_peach, bg = bg_sapph })
	vim.api.nvim_set_hl(0, "TransFmtToPos", { fg = bg_lav, bg = bg_peach })
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
