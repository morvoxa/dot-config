local function get_status_components()
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype

	-- Abaikan buffer kosong atau tipe spesial (NvimTree, toggleterm, dll)
	if ft == "" or vim.bo[bufnr].buftype ~= "" then
		return "", ""
	end

	-- 1. Deteksi LSP
	local lsp_list = {}
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in pairs(clients) do
		table.insert(lsp_list, client.name)
	end

	local lsp_string = ""
	if #lsp_list > 0 then
		-- Menggunakan ikon ▲ untuk LSP aktif
		lsp_string = " ▲ {" .. table.concat(lsp_list, ", ") .. "}"
	else
		-- Menggunakan [!] untuk peringatan
		lsp_string = " [!] {!No LSP}"
	end

	-- 2. Deteksi Formatter (Conform)
	local fmt_list = {}
	local status, conform = pcall(require, "conform")
	if status then
		local formatters = conform.list_formatters(bufnr)
		for _, f in ipairs(formatters) do
			table.insert(fmt_list, f.name)
		end
	end

	local fmt_string = ""
	if #fmt_list > 0 then
		-- Menggunakan ikon ▼ untuk Formatter aktif
		fmt_string = " ▼ {" .. table.concat(fmt_list, ", ") .. "}"
	else
		-- Menggunakan [!] untuk peringatan
		fmt_string = " [!] {!No Formatter}"
	end

	return lsp_string, fmt_string
end

function MyStatusLine()
	local file_name = " %f %M "
	local align = "%=" -- Geser ke kanan

	local lsp_info, fmt_info = get_status_components()
	local location = " %l:%c %P "

	return string.format("%s%s%s%s%s", file_name, align, lsp_info, fmt_info, location)
end

-- Terapkan ke Neovim
vim.opt.statusline = "%!v:lua.MyStatusLine()"
