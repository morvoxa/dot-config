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
vim.cmd([[colorscheme catppuccin]])
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
	{ src = "https://github.com/stevearc/conform.nvim" },
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
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		cmake = { "gersemi" },
		zig = { "zigfmt" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		lsp_format = false,
	},
})
--========================================================
local function get_formatter_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype

	-- Abaikan jika buffer kosong atau bukan file biasa (misal: terminal, NvimTree)
	if ft == "" or vim.bo[bufnr].buftype ~= "" then
		return ""
	end

	local fmt_list = {}
	local status, conform = pcall(require, "conform")

	if status then
		-- Mengambil daftar formatter yang tersedia untuk buffer saat ini
		local formatters = conform.list_formatters(bufnr)
		for _, f in ipairs(formatters) do
			table.insert(fmt_list, f.name)
		end
	end

	-- Format tampilan statusline
	if #fmt_list > 0 then
		return " ▼ {" .. table.concat(fmt_list, ", ") .. "}"
	else
		return " [!] {!No Formatter}"
	end
end

function MyStatusLine()
	local file_name = " %f %M "
	local align = "%=" -- Geser semua komponen setelah ini ke kanan
	local fmt_info = get_formatter_status()
	local location = " %l:%c %P "

	return string.format("%s%s%s%s", file_name, align, fmt_info, location)
end

vim.opt.statusline = "%!v:lua.MyStatusLine()"
--========================================================
