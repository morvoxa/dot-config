local function check_lsp_status(bufnr)
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return "lsp { none }"
	end

	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local lsp_names = {}

	for _, client in ipairs(clients) do
		if client and client.name then
			table.insert(lsp_names, client.name)
		end
	end

	if #lsp_names > 0 then
		return "lsp { " .. table.concat(lsp_names, ", ") .. " }"
	end
	return "lsp { none }"
end

local function check_formatter_status(bufnr)
    local has_conform, conform = pcall(require, "conform")
    if has_conform and conform then
        -- Mengambil daftar formatter yang dikonfigurasi untuk buffer saat ini
        local success, formatters = pcall(conform.list_formatters, bufnr)
        if success and formatters then
            local fmt_names = {}
            for _, f in ipairs(formatters) do
                -- PERBAIKAN: Pastikan formatter bertipe table, punya nama, dan STATUSNYA AVAILABLE (tersedia/aktif)
                if type(f) == "table" and f.name and f.available then
                    table.insert(fmt_names, f.name)
                elseif type(f) == "string" then
                    table.insert(fmt_names, f)
                end
            end
            
            if #fmt_names > 0 then
                return "formatter { " .. table.concat(fmt_names, ", ") .. " }"
            end
        end
    end
    return "formatter { none }"
end

_G.custom_statusline = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lsp = check_lsp_status(bufnr)
	local formatter = check_formatter_status(bufnr)

	return " %f %m %= " .. lsp .. "  |  " .. formatter .. "  |  %l:%c "
end

vim.opt.statusline = "%{%v:lua.custom_statusline()%}"

local status_refresh_group = vim.api.nvim_create_augroup("StatuslineRefresh", { clear = true })
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
	group = status_refresh_group,
	callback = function()
		vim.cmd("redrawstatus")
	end,
})
